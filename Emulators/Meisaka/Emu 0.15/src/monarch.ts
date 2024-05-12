function createcpl() {
return {
	defaultToken: 'invalid',

	commandsc: [
	  'ABS','END','LEN','MAX','MIN','MOD','SET','SGN'
	],
	commandsd: [
	  'CALL','CURB','CURP','CURS','DECR','DUMP','ELSE',
	  'FILE','FREE','FRER','GETR','HLDR','HOLD','INCR',
	  'LOAD','LOOP','NOTE','OPEN','PUTR','READ',
	  'SKIP','STOP'
	],
	
	keywords: [
	  'ADRLST','BUFFER','CLOSE',
	  'CURSOR','DECODE','DECREMENT','DEFINE',
	  'ENCODE','ENDFILE','ENDREC','ENTRY','ENTRYPOINT','EQUATE','EXTERNAL',
	  'FORMAT','GTIME',
	  'INCREMENT',
	  'LDATE','WHILE',
	  'ORIGIN',
	  'POINT',
	  'READB','RECORD','RESET','RETRIEVE',
	  'RETURN', 'RETURN TO',
	  'REWIND','REWRITE','ROUND','SDATE','SETFORM',
	  'STRING','SUBROUTINE',
	  'SYSTEM','TABLE','TBLGET','TBLPUT',
	  'WRITE','WRITEB','WRITEN','WRITN'
	],
	ifs: ['IF','IFS','IFSTRING'], // todo ELSE, DO, Null
	operators: [ // optional H before for strings
	  'EQ','NE','LT','LE','GT','GE'
	],
	// special vars
	sysvars: ['BEEP','VTAB','EJECT','STATUS','ZERO'],
	keytypes: ['INTEGER','STRING','SET','TABLE','DEFINE','BUFFER'],
	retreive: ['FILE','FORMAT','CONTROL','EXT','NUMBER','NUM48','STRING','ADDRESS'],
	// The main tokenizer for our languages
	tokenizer: {
	  // TODO hyphen continuation '-'
	  // TODO multiple statment '\'
	  root: [
		{include:'@preproc'},
		{regex: /SYSTEM\w*/,action:
		{cases:{'==SYSTEM':{token:'keyword',switchTo:'system'},
		'@default':'invalid'}}
		},
		// whitespace
		{include:'@whitespace'}
	  ],
	  system: [
		[/\(/, {cases:{
		  '@eos':{token:'delimiter',switchTo:'main'},
		  '@default':{token:'delimiter',next:'sysparam'}
		  }}],
		[/[A-Z]\w*/, {cases:{
		  '@eos':{token:'invalid', switchTo:'main'},
		  '@default':{token:'string'}
		  }}],
		[/[ \t]+/, {cases:{
		  '@eos':{token:'white', switchTo:'main'},
		  '@default':'white'
		  }}],
		[/.+/, {token:'invalid', switchTo:'main'}]
	  ],
	  sysparam: [
		[/([A-Z]+)(=)([A-D]|(?:[0-9]+))/, {
		  cases: {
			'~EXP=[A-D]': ['keyword','delimiter','type'],
			'~(LL|STACK)=[0-9]+': ['keyword','delimiter','number']
		  },
		}],
		[/MAIN|SUBPGM/, 'keyword'],
		[/[,=]/, 'delimiter'],
		[/[ \t]+/, 'white'],
		[/\)/, {cases:{
		  '@eos':{token:'delimiter',switchTo:'main'},
		  '@default':{token:'delimiter',next:'@pop'}
		  }}],
	  ],
	  main: [
		{include:'@preproc'},
		{include:'@logic'},
		{include:'@whitespace'}
	  ],
	  preproc: [
		[/(PRINT O(?:N|FF(?:,COM)?))(.*)$/, ['regexp','invalid']],
		[/(PAGE EJECT\w*)(.*)$/, {cases:{'$1==PAGE EJECT':'regexp'}}],
		[/(EJECT\w*)$/, {cases:{'$1==EJECT':'regexp'}}],
		[/(TITLE\w*)([ \t]*)('[^']*')$/, {cases:{
		  '$1==TITLE':['regexp','white','string'],
		  '@default':'invalid'
		  }}],
		[/(DIRECT\w*)$/, {cases:{'$1==DIRECT':'regexp'}}],
		[/(CPL\w*)$/, {cases:{'$1==CPL':'regexp'}}],
		[/(SPACE\w*)([ \t]*)([0-9]*)$/, {cases:{
		  '~SPACE[ \t]+[0-9]+':['regexp','white','number'],
		  '@default':'invalid'
		  }}],
		[/(COPY\w*)$/, {cases:{
		  '$1==COPY':'regexp'
		  }}]
	  ],
	  logic: [
		[/GO TO/, 'keyword'],
		[/END DO/, 'keyword'],
		[/IF\w*/, { cases: {'@ifs':'keyword', '@default':'invalid'} }],
		// commands and labels
		[/(([A-Z]{3})[A-Z]?)[A-Z]*:?/, { cases: {
		  '@keytypes': 'type',
		  'RETRIEVE': {token:'keyword', next:'preretrieve'},
		  '$2@commandsc': { cases: {'@commandsc':'keyword','@keywords':'keyword'} },
		  '$1@commandsd': { cases: {'@commandsd':'keyword','@keywords':'keyword'} },
		  '@keywords': 'keyword',
		  '@sysvars': 'variable',
		  '~[A-Z]+:':'key',
		  '@default': 'variable'
		  }
		}],
		[/(')([@?A-Z]+)(')/,['string',{token:'variable',next:'streq'},'string']],
		[/[,()]/,'delimiter']
	  ],
	  streq: [
		[/=/,{token:'delimiter',switchTo:'stringexp'}],
		[/[ \t\r\n]+/, 'white'],
		[/.*$/, {token:'invalid',next:'@pop'}]
	  ],
	  stringexp: [
		[/'/,{token:'string',switchTo:'stringsexp'}],
		[/"/,{token:'string',switchTo:'stringdexp'}],
		[/.*$/, {token:'invalid',next:'@pop'}]
	  ],
	  stringsexp: [
		[/'/,{token:'string', next:'@pop'}],
		[/[@?A-Z][@?A-Z0-9]*/, {token: 'variable'}],
		[/\+/, {token: 'operators'}],
		[/.*$/, {token:'invalid',next:'@pop'}]
	  ],
	  stringdexp: [
		[/'/,{token:'string', next:'stringlit'}],
		[/[@?A-Z][@?A-Z0-9]*/, {token: 'variable'}],
		[/\+/, {token: 'operators'}],
		[/"/,{token:'string', next:'@pop'}],
		[/.*$/, {token:'invalid',next:'@pop'}]
	  ],
	  stringlit: [
		[/''/, 'string.escape'],
		[/[^']+/, 'string'],
		[/'/, {token:'string', next:'@pop'}]
	  ],
	  stringdef: [
	  ],
	  preretrieve: [
		[/\(/, {token:'delimiter.parenthesis', switchTo:'retrieve'}],
		{include:'@whitespace'},
		[/.*$/, {token:'invalid',next:'@pop'}]
	  ],
	  retrieve: [
		[/[A-Z48]+/, {cases:{'@retreive':'type', '@default':'variable'}}],
		[/[@?A-Z][@?A-Z0-9]*/, {token: 'variable'}],
		[/,/, 'delimiter'],
		[/\)/,{token:'delimiter.parenthesis',next:'@pop'}],
		{include:'@whitespace'},
		[/.*$/, {token:'invalid',next:'@pop'}]
	  ],
	  whitespace: [
		[/[ \t\r\n]+/, 'white'],
		[/;.*$/,    'comment']
	  ]
	},
  };
}
