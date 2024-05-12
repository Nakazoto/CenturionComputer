"use strict";

import type * as monaco from 'monaco-editor';

//@ts-ignore
window.cen_ts_version = 21;
// hi there
const view_reg = document.getElementById('view_reg') as HTMLInputElement;
const view_page = document.getElementById('view_page') as HTMLInputElement;
const view_int = document.getElementById('view_int') as HTMLInputElement;
const view_uop = document.getElementById('view_uop') as HTMLInputElement;
const view_dis = document.getElementById('view_dis') as HTMLInputElement;
const view_ffc = document.getElementById('view_ffc') as HTMLInputElement;
const loc_crt0 = [
	document.getElementById('crt0loc_t') as HTMLInputElement,
	document.getElementById('crt0loc_b') as HTMLInputElement];
const ui_crts = [
	{
		view: document.getElementById('view_crt0') as HTMLInputElement,
		tall: document.getElementById('crttall0') as HTMLInputElement,
		size: document.getElementById('crtsize0') as HTMLSelectElement,
	},
	{
		view: document.getElementById('view_crt1') as HTMLInputElement,
		tall: document.getElementById('crttall1') as HTMLInputElement,
		size: document.getElementById('crtsize1') as HTMLSelectElement,
	},
	{
		view: document.getElementById('view_crt2') as HTMLInputElement,
		tall: document.getElementById('crttall2') as HTMLInputElement,
		size: document.getElementById('crtsize2') as HTMLSelectElement,
	}
];
const opt_rtc = [
	document.getElementById('rtc_0') as HTMLInputElement,
	document.getElementById('rtc_1') as HTMLInputElement,
	document.getElementById('rtc_2') as HTMLInputElement
];
const conv_hex = document.getElementById('conv_hex') as HTMLInputElement;
const conv_ee = document.getElementById('conv_ee') as HTMLInputElement;
const conv_mei = document.getElementById('conv_mei') as HTMLInputElement;
const conv_uew = document.getElementById('conv_uew') as HTMLInputElement;
const dc_fpd = document.getElementById('dcfpd') as HTMLDivElement;
const dc_crt0 = document.getElementById('dccrt0') as HTMLDivElement;
const win_crt1 = document.getElementById('crtc1') as HTMLDivElement;
const win_crt2 = document.getElementById('crtc2') as HTMLDivElement;
const dc_int = document.getElementById('dcint') as HTMLDivElement;
const dc_pages = document.getElementById('dcpages') as HTMLDivElement;
const dc_uop = document.getElementById('dcuop') as HTMLDivElement;
const dc_hawk = document.getElementById('dchawk') as HTMLDivElement;
const dc_ffc = document.getElementById('dcffc') as HTMLDivElement;
const dc_regs = document.getElementById('dcregs') as HTMLDivElement;
const dc_listing = document.getElementById('dclisting') as HTMLDivElement;
const dc_textio = document.getElementById('dc_textio') as HTMLDivElement;
const con_rows = [
	document.getElementById('cd_r1') as HTMLDivElement,
	document.getElementById('cd_r2') as HTMLDivElement,
	document.getElementById('cd_r3') as HTMLDivElement,
	document.getElementById('cd_r4') as HTMLDivElement,
	document.getElementById('cd_r5') as HTMLDivElement,
	document.getElementById('cd_r6') as HTMLDivElement,
];
const con_row1col1 = document.getElementById('cd_r1c1') as HTMLDivElement;
const con_row1col2 = document.getElementById('cd_r1c2') as HTMLDivElement;
const con_row2col2 = document.getElementById('ccr2') as HTMLDivElement;
const con_row6col2 = document.getElementById('cd_r6c2') as HTMLDivElement;
const down_div = document.getElementById('dld') as HTMLDivElement;
const step_button = document.getElementById('b_step') as HTMLButtonElement;
const run_button = document.getElementById('b_run') as HTMLButtonElement;
const run_rate1 = document.getElementById('b_r1') as HTMLButtonElement;
const run_rate2 = document.getElementById('b_r2') as HTMLButtonElement;
const run_rate3 = document.getElementById('b_r3') as HTMLButtonElement;
const run_rate4 = document.getElementById('b_r4') as HTMLButtonElement;
const run_rate5 = document.getElementById('b_r5') as HTMLButtonElement;
const run_rate6 = document.getElementById('b_r6') as HTMLButtonElement;
const run_rate7 = document.getElementById('b_r7') as HTMLButtonElement;
const run_rate8 = document.getElementById('b_r8') as HTMLButtonElement;
const win_assm = document.getElementById('assmview') as HTMLDivElement;
const con_assm_edit = document.getElementById('assmedit') as HTMLDivElement;
const con_assm_out = document.getElementById('assmoutp') as HTMLDivElement;
const memory_view = document.getElementById('memview') as HTMLDivElement;
const memory_button = document.getElementById('b_memory') as HTMLButtonElement;
const memory_elem:{a:HTMLDivElement, d:HTMLDivElement, t:HTMLDivElement}[] = [];
const win_disk = document.getElementById('diskview') as HTMLDivElement;
const assm_button = document.getElementById('b_asm') as HTMLButtonElement;
const disk_button = document.getElementById('b_disks') as HTMLButtonElement;
const micro_button = document.getElementById('b_micro') as HTMLButtonElement;
const btn_rcon = document.getElementById('b_rcon') as HTMLButtonElement;
const win_rcon = document.getElementById('netcfg') as HTMLDivElement;
const local_button = document.getElementById('b_local') as HTMLButtonElement;
const ws_addr = document.getElementById('cfgwsip') as HTMLInputElement;
const win_micro = document.getElementById('mclisting') as HTMLDivElement;
const microstep_button = document.getElementById('b_mstep') as HTMLButtonElement;
const btn_ss1 = document.getElementById('ss1') as HTMLButtonElement;
const btn_ss2 = document.getElementById('ss2') as HTMLButtonElement;
const btn_ss3 = document.getElementById('ss3') as HTMLButtonElement;
const btn_ss4 = document.getElementById('ss4') as HTMLButtonElement;
const btn_ssR = document.getElementById('ssR') as HTMLButtonElement;
const btn_ssH = document.getElementById('ssH') as HTMLButtonElement;
const btn_ssI = document.getElementById('ssI') as HTMLButtonElement;
const btn_dt1 = document.getElementById('diag1') as HTMLButtonElement;
const btn_dt2 = document.getElementById('diag2') as HTMLButtonElement;
const btn_dt4 = document.getElementById('diag4') as HTMLButtonElement;
const btn_dt8 = document.getElementById('diag8') as HTMLButtonElement;
const sts_dt1 = document.getElementById('diag1s') as HTMLSpanElement;
const sts_dt2 = document.getElementById('diag2s') as HTMLSpanElement;
const sts_dt4 = document.getElementById('diag4s') as HTMLSpanElement;
const sts_dt8 = document.getElementById('diag8s') as HTMLSpanElement;
const btn_settings = document.getElementById('b_settings') as HTMLButtonElement;
const win_settings = document.getElementById('wset') as HTMLDivElement;
const btn_dtrun = document.getElementById('diagrun') as HTMLButtonElement;
const fp_rf = document.getElementById('fp_r') as HTMLButtonElement;
const fp_load = document.getElementById('fp_l') as HTMLButtonElement;
const fp_select = document.getElementById('fp_s') as HTMLButtonElement;
const fp_perf = document.getElementById('fp_perf') as HTMLSpanElement;
const mcs_p = document.getElementById('mcs_p') as HTMLSpanElement;
const mcs_s = document.getElementById('mcs_s') as HTMLSpanElement;
const mcs_alu = document.getElementById('mcs_alu') as HTMLSpanElement;
const mcs_alu2 = document.getElementById('mcs_alu2') as HTMLSpanElement;
const mcs_alu3 = document.getElementById('mcs_alu3') as HTMLSpanElement;
const mcr_res = document.getElementById('mcr_res') as HTMLSpanElement;
const mcr_bus = document.getElementById('mcr_bus') as HTMLSpanElement;
const mcr_sys = document.getElementById('mcr_sys') as HTMLSpanElement;
const mcr_addr = document.getElementById('mcr_addr') as HTMLSpanElement;
const mcr_swap = document.getElementById('mcr_swap') as HTMLSpanElement;
const check_sound = document.getElementById('ck_sound') as HTMLInputElement;
const crtcol = document.getElementById('crtcol') as HTMLSelectElement;
const crtcrev = document.getElementById('crtcrev') as HTMLInputElement;
const nio = {
	sim: [document.getElementById('niosim1') as HTMLInputElement,
		document.getElementById('niosim2') as HTMLInputElement,
		document.getElementById('niosim3') as HTMLInputElement,
		document.getElementById('niosim4') as HTMLInputElement],
	disp: [document.getElementById('niodisp1') as HTMLInputElement,
		document.getElementById('niodisp2') as HTMLInputElement],
	mem: [document.getElementById('niomem1') as HTMLInputElement,
		document.getElementById('niomem2') as HTMLInputElement,
		document.getElementById('niomem3') as HTMLInputElement],
	memv: document.getElementById('niomemv') as HTMLInputElement,
	sts: [document.getElementById('niosts0') as HTMLInputElement,
		document.getElementById('niosts1') as HTMLInputElement,
		document.getElementById('niosts2') as HTMLInputElement,
		document.getElementById('niosts3') as HTMLInputElement],
	rss: document.getElementById('niorss') as HTMLInputElement,
	rsh: document.getElementById('niorsh') as HTMLInputElement,
	crt0: [document.getElementById('niocrt00') as HTMLInputElement,
		document.getElementById('niocrt01') as HTMLInputElement,
		document.getElementById('niocrt02') as HTMLInputElement,
		document.getElementById('niocrt03') as HTMLInputElement],
};
const fp_runstate_con = document.getElementById('fp_runstate') as HTMLElement;
const fp_runhalt = [
	fp_runstate_con.children[0],
	fp_runstate_con.children[1],
];
const fp_ext = [
	step_button, // step
	run_button,
	fp_runstate_con.children[2], // mem parity fault
];
const mcpage = [
	document.getElementById('mcp_0') as HTMLSpanElement,
	document.getElementById('mcp_1') as HTMLSpanElement,
	document.getElementById('mcp_2') as HTMLSpanElement,
	document.getElementById('mcp_3') as HTMLSpanElement,
];
const mcr_file:HTMLSpanElement[] = [];
const mcr_file_v = new Uint16Array(128);
(function(){
	let row_index = 0;
	while(row_index < 15) {
		const row = document.getElementById(`mcr_file${hex(row_index,1)}`) as HTMLSpanElement;
		for(let col_index = 0; col_index < 16; col_index++) {
			const col = document.createElement('span');
			col.innerText = '0000';
			row.appendChild(col);
			mcr_file.push(col);
		}
		row_index += 2;
	}
})();
const mcr_level = document.getElementById('mcr_level') as HTMLSpanElement;
const mcr_rfir = document.getElementById('mcr_rfir') as HTMLSpanElement;
const mcr_rfdr = document.getElementById('mcr_rfdr') as HTMLSpanElement;
const mcr_pta = document.getElementById('mcr_pta') as HTMLSpanElement;
const mcr_dat_in = document.getElementById('mcr_din') as HTMLSpanElement;
const mcr_dat_out = document.getElementById('mcr_dout') as HTMLSpanElement;
const mcs_op = document.getElementById('mcs_op') as HTMLSpanElement;
const mcs_op_alu = document.getElementById('mcs_op_alu') as HTMLSpanElement;
const ffc_op_seq = document.getElementById('ffc_op') as HTMLSpanElement;
const ffc_op_alu = document.getElementById('ffc_op_alu') as HTMLSpanElement;
const ffc_op_bus = document.getElementById('ffc_op_bus') as HTMLSpanElement;
const ffc_addr = document.getElementById('ffc_addr') as HTMLSpanElement;
const ffc_ctrl = document.getElementById('ffc_ctrl') as HTMLSpanElement;
const ffc_ipl = document.getElementById('ffc_ipl') as HTMLSpanElement;
const ffc_sys = document.getElementById('ffc_sys') as HTMLSpanElement;
const ffc_status = document.getElementById('ffc_status') as HTMLSpanElement;
const ffc_track = document.getElementById('ffc_track') as HTMLSpanElement;
const ffc_disk = document.getElementById('ffc_disk') as HTMLSpanElement;
const ffc_alu = document.getElementById('ffc_alu') as HTMLSpanElement;
const ffc_alu2 = document.getElementById('ffc_alu2') as HTMLSpanElement;
const ffc_alu3 = document.getElementById('ffc_alu3') as HTMLSpanElement;
const ffc_log = document.getElementById('ffc_log') as HTMLButtonElement;
const d_listing = document.getElementById('listing') as HTMLDivElement;
const d_listinga = document.getElementById('listinga') as HTMLDivElement;
const d_listingc = document.getElementById('listingc') as HTMLDivElement;
const vc_reset = document.getElementById('vc_reset') as HTMLButtonElement;
const vc_sync = document.getElementById('vc_sync') as HTMLButtonElement;
const vc_step = document.getElementById('vc_step') as HTMLButtonElement;
const vc_clear = document.getElementById('vc_clear') as HTMLButtonElement;
const vc_snap = document.getElementById('vc_snap') as HTMLButtonElement;
const vc_restore = document.getElementById('vc_restore') as HTMLButtonElement;
const vc_run = document.getElementById('vc_run') as HTMLButtonElement;
const vc_rerun = document.getElementById('vc_rerun') as HTMLButtonElement;
const d_micro = document.getElementById('micro') as HTMLDivElement;
const in_diagins = document.getElementById('diagins') as HTMLInputElement;
const in_dbgcmd = document.getElementById('dbgcmd') as HTMLInputElement;
//const btn_cm_import = document.getElementById('cm_imp') as HTMLButtonElement;
const btn_cm_tocrt = document.getElementById('cm_vki') as HTMLButtonElement;
const btn_cm_clear = document.getElementById('cm_clear') as HTMLButtonElement;
const txt_anno = document.getElementById('anno') as HTMLTextAreaElement;
const cv_diag = document.getElementById('fp_diag') as HTMLCanvasElement;
const cx_diag = cv_diag.getContext('2d') as CanvasRenderingContext2D;
const com_conf = {
	mux: [
		document.getElementById('com_m0') as HTMLSelectElement,
		document.getElementById('com_m1') as HTMLSelectElement,
		document.getElementById('com_m2') as HTMLSelectElement,
		document.getElementById('com_m3') as HTMLSelectElement,
	],
	crt: [
		document.getElementById('com_c0') as HTMLSelectElement,
		document.getElementById('com_c1') as HTMLSelectElement,
		document.getElementById('com_c2') as HTMLSelectElement,
	],
	have_net: false,
	net: [] as NetSerial[],
	dev: [] as string[],
	ext: [
		{sel:document.getElementById('com_x0') as HTMLSelectElement, opts:[]},
		{sel:document.getElementById('com_x1') as HTMLSelectElement, opts:[]},
		{sel:document.getElementById('com_x2') as HTMLSelectElement, opts:[]},
		{sel:document.getElementById('com_x3') as HTMLSelectElement, opts:[]},
	] as {sel:HTMLSelectElement, opts:HTMLOptionElement[]}[]
};

const RUNRATES = [1,10,100,1000,10000,50000,100000,150000];
interface ConfigSchema {
	0:[number, boolean, boolean],
	1:[boolean[],number,number],
	2:[number],
	3:[boolean[],number,number,number,number], // net
	4:[boolean,boolean,number],
	5:[boolean,number],
	16: [boolean[],number,number,number][],
	17?: [][],
	18?: [][],
	19?: [][],
	20?: [boolean,boolean][],
}
const CONFIG_LL:BRObject & ConfigSchema = {
	0: [0, false, false],
	1: [[false,false,false,false],0,0],
	2: [0],
	3: [[false,false,false,false,false],0,0,0,0], // net
	4: [false,false,1],
	5: [false,13],
	16: [ // CRT[]
		[/*0:viewopts*/[true,false,false,false],0,0,0],
		[/*0:viewopts*/[false,false,false,false],0,0,0],
		[/*0:viewopts*/[false,false,false,false],0,0,0]
	],
	//17: [ // MUX[]
	//[]
	//],
	//18: [ // DSK[]
	//],
	19: [ // Hawk[]
	],
	20: [ // FFC[]
		[true, false]
	]
};
const vt_colors:[number,number][] = [
	[0xffca86, 0x0c0501],
	[0x146af0, 0x000408],
	[0xe0dada, 0x111111],
	[0x3aee18, 0x010801],
	[0x141af0, 0x000108],
];
class ConfigClass {
	//uicore: CONFIG_LL[0]; // uicore
	cpu = CONFIG_LL[1]; // cpu
	emu = CONFIG_LL[2];
	net = CONFIG_LL[3];
	disassm = CONFIG_LL[4];
	diag = CONFIG_LL[5];// diag
	crt = CONFIG_LL[16];// crt[]
	ffc = CONFIG_LL[20];// ffc[]
	get sound() { return CONFIG_LL[0][2]; }
	set sound(v:boolean) {
		if(v!=CONFIG_LL[0][2]) {CONFIG_LL[0][2]=v;this.updated();}
	}
	get vt_colors() { return vt_colors[CONFIG_LL[0][0]]; }
	get vt_color_scheme() { return CONFIG_LL[0][0]; }
	set vt_color_scheme(v:number) {
		if(v != this.vt_color_scheme) {
			CONFIG_LL[0][0] = v;
			update_font_data(CONFIG.vt_colors);
			this.updated();
		}
	}
	get vt_reverse() { return CONFIG_LL[0][1]; }
	set vt_reverse(v:boolean) {
		if(v != this.vt_reverse) {
			CONFIG_LL[0][1] = v;
			vt_force_redraw = true;
			this.updated();
		}
	}

	static config_timeout = 0;
	static handle_timer() {
		ConfigClass.config_timeout = 0;
		rtd();
	}
	updated():void {
		if(ConfigClass.config_timeout != 0) {
			clearTimeout(ConfigClass.config_timeout);
		}
		ConfigClass.config_timeout = setTimeout(ConfigClass.handle_timer, 3000);
	}
}
const CONFIG = new ConfigClass();
let caps_lock = false;

interface DiskContainer {
	set_disk(image:DiskImage|null):void;
}
const diskui:DiskImageUI[] = [];
function style_off(elem:Element, domclass:string) {
	elem.classList.remove(domclass);
}
function style_if(elem:Element, domclass:string, cond: boolean) {
	if (cond) {
		elem.classList.add(domclass);
	} else {
		elem.classList.remove(domclass);
	}
}
function display_if(elem:HTMLElement, cond: boolean) {
	if (cond) {
		elem.style.removeProperty('display');
	} else {
		elem.style.display = 'none';
	}
}
interface StdFrame {
	base: HTMLDivElement;
	show: boolean;
	fixed: boolean;
}
class FrameManager {
	frames: StdFrame[] = [];
	drag_frame: StdFrame | undefined;
	drag_origin_x = 0;
	drag_origin_y = 0;
	last_client_x = 0;
	last_client_y = 0;
	constructor() {
		window.addEventListener('mousemove', (ev) => {
			let nx = 0, ny = 0;
			if(this.drag_frame) {
				this.last_client_x = ev.clientX;
				this.last_client_y = ev.clientY;
				nx = this.drag_origin_x + ev.clientX;
				ny = this.drag_origin_y + ev.clientY;
				if(!this.drag_frame.fixed) {
					nx += (window.scrollX | 0);
					ny += (window.scrollY | 0);
				}
				if(nx < -10) nx = -10;
				if(ny < -10) ny = -10;
				this.drag_frame.base.style.left = `${nx}px`;
				this.drag_frame.base.style.top = `${ny}px`;
				ev.preventDefault();
			}
		});
		window.addEventListener('mouseup', (ev) => {
			delete this.drag_frame;
		});
		window.addEventListener('scroll', (ev) => {
			if(this.drag_frame && !this.drag_frame.fixed) {
				let nx = this.drag_origin_x + this.last_client_x + (window.scrollX | 0);
				let ny = this.drag_origin_y + this.last_client_y + (window.scrollY | 0);
				if(nx < -10) nx = -10;
				if(ny < -10) ny = -10;
				this.drag_frame.base.style.left = `${nx}px`;
				this.drag_frame.base.style.top = `${ny}px`;
			}
		});
	}
	raise_frame(frame: StdFrame) {
		let l = this.frames.indexOf(frame);
		if(l == -1) {
			this.frames.push(frame);
		} else {
			let i = l;
			for(; i < this.frames.length - 1; i++) {
				this.frames[i] = this.frames[i + 1];
				this.frames[i].base.style.zIndex = `${i + 1}`;
			}
			this.frames[i] = frame;
			frame.base.style.zIndex = `${i + 1}`;
		}
	}
	toggle_show_raise(frame: StdFrame) {
		let vis = !frame.show;
		frame.show = vis;
		if(vis) this.raise_frame(frame);
	}
	begin_drag(frame: StdFrame, event: MouseEvent) {
		this.drag_frame = frame;
		const szre = /^(-?[0-9]+)([a-z%]*)$/;
		let reres = szre.exec(frame.base.style.left);
		let f_x = 0;
		let f_y = 0;
		if(reres != null && reres[1] != '') {
			f_x = parseInt(reres[1]);
		}
		reres = szre.exec(frame.base.style.top);
		if(reres != null && reres[1] != '') {
			f_y = parseInt(reres[1]);
		}
		let t_x = f_x - event.clientX;
		let t_y = f_y - event.clientY;
		if(!frame.fixed) {
			t_x -= window.scrollX | 0;
			t_y -= window.scrollY | 0;
		}
		this.last_client_x = event.clientX;
		this.last_client_y = event.clientY;
		this.drag_origin_x = t_x;
		this.drag_origin_y = t_y;
	}
}
const frame_manager = new FrameManager();
class ModFrame {
	base: HTMLDivElement;
	header: HTMLDivElement;
	title: HTMLDivElement;
	content: HTMLDivElement;
	private _show: boolean;
	private _fixed: boolean;
	constructor(basis: HTMLDivElement) {
		this.base = basis;
		this._show = this.base.style.display != 'none';
		if(this._show) this.base.style.display = 'flex';
		this._fixed = this.base.style.position == 'fixed' || this.base.style.position == '';
		if(basis.children.length < 2) throw(new Error("bad content format"));
		this.header = basis.children[0] as HTMLDivElement;
		this.title = this.header.children[0] as HTMLDivElement;
		this.content = basis.children[1] as HTMLDivElement;
		if(this.header.tagName.toUpperCase() != "DIV")
			throw(new Error("bad content format"));
		if(this.content.tagName.toUpperCase() != "DIV")
			throw(new Error("bad content format"));
		frame_manager.frames.push(this);
		this.base.addEventListener('mousedown', (ev) => {
			frame_manager.raise_frame(this);
		});
		this.header.addEventListener('mousedown', (ev)=>{
			ev.preventDefault();
			frame_manager.begin_drag(this, ev);
		});
	}
	get show():boolean {
		return this._show;
	}
	set show(v:boolean) {
		this._show = v;
		this.base.style.display = this._show ? 'flex' : 'none';
	}
	get fixed():boolean {
		return this._fixed;
	}
}
const frame_crt1 = new ModFrame(win_crt1);
const frame_crt2 = new ModFrame(win_crt2);
const frame_assm = new ModFrame(win_assm);
const frame_memory = new ModFrame(memory_view);
const frame_disks = new ModFrame(win_disk);
const frame_mclist = new ModFrame(win_micro);
interface LoadResponse {
	kind: string,
	address: number,
}
const win_load = (function() {
	let accept_fn:null | ((v:LoadResponse)=>void) = null;
	let cancel_fn:null | (()=>void) = null;
	function do_cancel() {
		let f = cancel_fn;
		accept_fn = null;
		cancel_fn = null;
		if (f != null) {
			f();
		}
	}
	const con_win = document.getElementById('wload') as HTMLDivElement;
	const file_name = document.getElementById('wload_fn') as HTMLSpanElement;
	const file_type = document.getElementById('wload_ft') as HTMLSpanElement;
	const file_size = document.getElementById('wload_fs') as HTMLSpanElement;
	const load_addr = document.getElementById('wload_addr') as HTMLInputElement;
	const load_opt = [
		document.getElementById('wload_lt0') as HTMLInputElement,
		document.getElementById('wload_lt1') as HTMLInputElement
	];
	const o = {
		show(file:File) {
			do_cancel();
			file_name.innerText = file.name;
			file_type.innerText = file.type;
			file_size.innerText = `${file.size} (0x${hex(file.size,1)}) bytes`;
			con_win.style.display = '';
			return new Promise<LoadResponse>(function(resolve, reject) {
				accept_fn = resolve;
				cancel_fn = reject;
			});
		},
		hide() {
			con_win.style.display = 'none';
		}
	};
	(document.getElementById('wload_h') as HTMLButtonElement).addEventListener('click', function(ev) {
		o.hide();
		let f = accept_fn;
		accept_fn = null;
		cancel_fn = null;
		if (f != null) {
			let address = parseInt(load_addr.value, 16);
			if (isNaN(address)) {
				address = 0x100;
			}
			let r = {address, kind:''};
			if (load_opt[0].checked) {
				r.kind = 'raw';
			}
			f(r);
		}
	});
	(document.getElementById('wload_c') as HTMLButtonElement).addEventListener('click', function(ev) {
		o.hide();
		do_cancel();
	});
	return o;
})();
const cv_map = document.getElementById('fp_flagsc') as HTMLCanvasElement;
const cx_map = cv_map.getContext('2d') as CanvasRenderingContext2D;
const cv_addr = document.getElementById('fp_addrc') as HTMLCanvasElement;
const cx_addr = cv_addr.getContext('2d') as CanvasRenderingContext2D;

cx_diag.fillStyle = '#ff3232';
cx_diag.font = '16px Consolas, "Envy Code R", monospace';
cx_map.font = '20px Consolas, "Envy Code R", monospace';
cx_addr.font = '10px Consolas, "Envy Code R", monospace';

interface Run {
	run(increment:number):void;
}
let selsim:ICCPU;
let selcdsp:ICCPU;
let active_connection:WSConnection|null = null;
let net_provides_rc = false;
let show_reg = view_reg.checked;
let show_page = view_page.checked;
let show_int = view_int.checked;
let show_uop = view_uop.checked;
let show_dis = view_dis.checked;
let show_ffc = view_ffc.checked;
let show_mem = false;
let run_ctl = 0;
let run_rate = 10000;
let run_step:boolean = false;
let run_busy = false;
let dis_meminval = true; // memory was written
let dis_adrinval = true; // the vpc (possibly) changed
let dis_last_vpc = 0; // the vpc highlighted in the listing
let dis_last_exec = 0; // index of the exec highlight line
let memv_after = false;
let run_follow = false; // disasm listing should keep the vpc in view
let last_pc = 0; // the most recently seen vpc pointing an instruction boundry
let last_map = 0; // the map register at the vpc
let dis_vpc = 0x100; // boundry the listing starts at
let dis_map = 0; // map to disassemble in
let dis_ppc = 0x100; // physical start address of listing
let dis_ppc_end = 0x200; // physical end address of listing
let memv_begin = 0;
let memv_end = 0;
let run_accu = 0;
let run_accutime = 0;
let run_once = false;
let HEX_CONV = conv_hex.checked;
let name_conv = NAMECON.MEI;
let sense_switch = 0;
let dswitch = 0; // inverted on bus - R H I 0
const mux_hw:MUXPort[] = [];
const run_hw:Run[] = [];
const run_hshw:Run[] = [];

let run_stop:null | (()=>void);
function do_run_stop():void {
	if (run_stop) {
		run_stop();
		run_stop = null;
	}
}
function run_hw_steps(inc:number) {
	const l = run_hw.length;
	for(let i = 0; i < l; i++) {
		run_hw[i].run(inc);
	}
}
function run_hshw_steps() {
	const l = run_hshw.length;
	for(let i = 0; i < l; i++) {
		run_hshw[i].run(5);
	}
}
function run_core() {
	if (!selsim.can_step) return;
	run_busy = true;
	let runtime = Date.now();
	for(let i = 0; i < mux_hw.length; i++) {
		mux_hw[i].run_tx();
	}
	if (run_rate > 10000) {
		let hsr = (run_rate / 100) | 0;
		mcsim.hspre();
		for (let i=0;i<hsr;i++) {
			run_hw_steps(100);
			for (let ql = 0; ql < 20; ql++) {
				mcsim.hsstep(); mcsim.hsstep(); mcsim.hsstep();
				mcsim.hsstep(); mcsim.hsstep();
			}
			if (run_ctl == 0) {
				do_run_stop();
				break;
			}
		}
		mcsim.hsend();
	} else {
		for (let i=0;i<run_rate;i++) {
			run_hw_steps(1);
			selsim.step(false);
			if (run_ctl == 0) {
				do_run_stop();
				break;
			}
		}
		selcdsp.step(true);
	}
	run_busy = false;
	if(active_connection) active_connection.handle_tx_tick();
	if(run_ctl == 0) {
		selcdsp.showstate(true);
	} else {
		selcdsp.showstate(false);
	}
	main_ffc.step(true);
	if (show_dis) show_disasm();
	if (memv_after) update_memview();
	if (disk_view_update) disk_view.update();
	runtime = Date.now() - runtime;
	run_accutime += runtime;
	run_accu += run_rate;
}
function run_control(run:boolean):void {
	if (!run && (run_ctl !== 0)) {
		clearInterval(run_ctl);
		fp_ext[1].classList.remove('active');
		run_ctl = 0;
		run_step = false;
		if (!run_busy) {
			do_run_stop();
			selcdsp.step(true);
			selcdsp.showstate(true);
			main_ffc.step(true);
		}
		return;
	}
	if (run && (run_ctl == 0)) {
		run_once = true;
		fp_ext[1].classList.add('active');
		run_ctl = setInterval(run_core, 20);
	}
}
function handle_break():boolean {
	if(run_once) return false;
	run_control(false);
	dis_adrinval = show_dis;
	return true;
}
setInterval(function() {
	let runtime = run_accutime;
	let runcount = run_accu;
	run_accutime = 0;
	run_accu = 0;
	fp_perf.innerText = runcount.toString().padStart(6,'0') + ':' + (run_rate > 10000 ? 'F' : 'R') + ':' + runtime.toString().padStart(4,'0');
}, 1000);

function bload(v:string):Uint8Array {
	const bv = atob(v);
	const a = new Uint8Array(bv.length);
	let i = 0;
	for(let c of bv) {
		a[i] = c.charCodeAt(0);
		i++;
	}
	return a;
}
const vtfont = bload(`AAcHBwcHAgcHBQERBw4HBwABAQEBAQUJCQUBEQEBAQEABwcHBwcHBwcHAREDAQcHCCwkIQExJQl5
BTkKOT4EBAAvFxc/TxUXFz0PdAlIHz8AOAgIEEgMEHAQGCAYOCQQACgUFBBIFBBAEAggCCgkEAAo
IiIQsCRwcBAIIAhIGDgHBwcHBwkHBw4HBwcHDgcJCQkJCQkLAQEBAQEBAQEJCQkJCQkJDQcHAQcH
BwMNBwl5KTl5KUkEOQ4BHAE5aWV2FzdHRzcpT09IRyd/CR4ZEHAgMHAoGFg4WGwcCDggIHAQIAhA
fChoSGhUJAggQEBAcHB4eCBISDhIRBxwODAwcAAIFBQUQgYEEAQIAAAAAEAACBQUfiUJBAgIKggA
AAAgAAgAPhUSCQAEEBwIAAAAEAAIABQ+CAYABBAIPgA+AAgACAA+VCQpAAQQHAgAAAAEAAAAFD9S
EQAICCoIDAAAAgAIABQUIS4AEAQIAAgADAEAAAAAAAAAAAAAAAAEAAAAPggcPhA+GD4cHAAAIAAE
HGEMIiAYAgQgIiIAABAACCJRCCAQFB4CECIiDAwIHhAgSQgYGBIgHggcPAAABAAgEEUIBCA/ICIE
IiAMDAgeEAhDCAIiECIiBCIQAAgQAAgAPhw+HBAcHAQcCAAEIAAECAAAAAAAAAAAAAAAAAAAAAAc
HB4cHj4+HCIcHCICQSIcIiIiIiICAiIiCAgSAmMmIjoiIgIiAgICIggICgJVKiIqPh4CIh4eAj4I
CAYCSTIiOiIiAiICAjIiCAgKAkEiIgIiIiIiAgIiIggIEgJBIiI8Ih4cHj4CHCIcBiI+QSIcAAAA
AAAAAAAAAAAAAAAAAB4cHhw+IkFBQSI+PgE+CAgiIiIiCCJBQSIiIAYCMBwEIiIiAggiIkEUIhAG
BDAqAh4iHhwIIiJJCBQIBggwSX8CKgogCCIUVRQIBAYQMAgCAhISIggiFGMiCAIGIDAIBAIsIhwI
HAhBQQg+PkA+CAgAAAAAAAAAAAAAAAAAAAAABAACACAAGAACCBACDAAAAAgAAgAgACQAAgAAAggA
AAAQHB48PBwEPB4MGBIINw4cACAiAiIiHiIiCBAKCEkSIgA8IgIiPgQiIggQBghJIiIAIiICIgIE
PCIIEgoISSIiADwePDw8BCAiHAwSGEEiHAAAAAAAAAAcAAAAAAAAAAAAAAAABAAAAAAAABgIBgAA
AAAAAAQAAAAAAAAECAgAAB4cOjweIkFBIiI+BAgIBgAiIgYCBCJBQRQiEAIAEEkAIiICHAQiIkkI
IggECAgwAB48AiAEMhRVFDwEBAgIAAACIAIeGCwIYyIgPhgIBgAAAmAAAAAAAAAAHAAAAAAAAAAA
AAAAAAAACAAAAAgAAAAAAAAAAAAAAAgAAAAIAAAAAAAAAAAAAAAIAAAACAAAAPgAAAAPAAAA+AAA
AA8AAAAIAAAACAAAAAAAAAAAAAAACAAAAAgAAAAAAAAAAAAAAAgAAAAIAAAAAAAAAAAAAAAIAAAA
CAAAAAAAAAAAAAAAAAAAAAgAAAAIAAAACAAAAAAAAAAIAAAACAAAAAgAAAAAAAAACAAAAAgAAAAI
AAAA/wAAAA8AAAD4AAAA/wAAAAgAAAAIAAAACAAAAAAAAAAIAAAACAAAAAgAAAAAAAAACAAAAAgA
AAAIAAAAAAAAAAgAAAAIAAAACAAAAAAAAAAAAAAACAAAAAgAAAD/AAAAAAAAAAgAAAAIAAAA/wAA
AAAAAAAIAAAACAAAAP8AAAD/AAAACAAAAP8AAAD/AAAAAAAAAAgAAAAIAAAA/wAAAAAAAAAIAAAA
CAAAAP8AAAAAAAAACAAAAAgAAAD/AAAAAAAAAAgAAAAIAAAA/wAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=`);
const bpl_rom = bload(`9WVL0AyAfUHVvnOhZQmhZUBV0HM1QPoYKUA3BwSASAovewMBcYQVRPGBABx7Ai8f6pAALwABkAYv
BC/yFFogAMAUGEkFwBkWMUERgA4ZMUEJgCUWSbDAJRRJjcAqFE3n0KAVWgAE0B6UAzt7QfGxOq8U
WhAA0C2UQPGhuhhJB8BMeUAyom2+R5NMeQOzQZUAiwCMCfoVSgn4wdpzCQEVCL9zAnNicwnmpDFC
38AEFkngwDFDgMD1hPsRLO6E73MB+IEDAXEDew17CIAI+KFFgAYvNC8CLx/qkAAvAAGQmnPyoQkB
FUGF+REsLADygRFzc3OFcwcAio3Sz9LSxYqNEQJzIHsODgj4oUOABi80LwIvO4BRAC9AH5AOCPih
Dgj4ewMBcQMVRRV7Ai//8JAALwABkEMiewIv9v+QoC8GLxShKg4I+KFBgE57CICBpf+A8xVJDsAo
gfWQAdCBpSqBpS+i9fsXKTAnBgCB0KL1AIPQouWIwKL1IDKi9QAP0D0YhYCBtTqBpYOAgaUxQA/A
BBShhYGlhICBtQCBkF5AH5BJA8B/GH8WocVIFjFAUMBye1AVScjABRRJw8AKFKLlSaKloHMJ+xAs
34RI8aFBhQn2hPoVKQH4gQD4oUGFAPxxxsByewC9xHl7XwAQkA4OAfKhjIAA8qHFgAGAcQNzAho=`);
const bpl_romc = bload(`
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABEnOcvAH2kE5oVegUPetzanMJAIHQLFVB
1ShVIC9AHwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA0Idz4BVae217CYoAAIMAhFJ7
+xcpMCcGAA9vewkADwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACIAINmezAgEBVL
FC8A+C57CfsQLPKESPGhQYUDAXHFAAAAAAAAAAAAAAAAAAn6FUoByMUKgAm7FY4Ee67gFbQVRPGB
AAl7ansEL/IUWiAA0NcVWgAE0BSUAx57QfGxOnsOrg6uKg6uQYAUezQv1HsJhQAAg7d7SBDAAxY5
AITQ5hRaEADQI5RA8aGXcwcAio3Sz9LSxYqN3nsJ8KQxQt+B9Qj4g3vVc4Gl/4DzFUkOwCiB9ZAB
0IGlKpdzAwFxQsAEFkkhQ+CA0AHygfwRLIsJ9RVBhfsRLCyLHXsJJUUle0WAyXtBlUp7Q4DWc4BR
r5P1c4GlBBRJCcBBhYH1AHUYSdopFjFAUMAZe/cVSTQUQcU+PgGAcQAD8NgD8s0HdfQVKOgBiMX7
ETAkzAABkAkGLwIvOyAvAAHQ4BWQAPxxyAfuwwOvxhV7OXsAvcQ0e18AIJAODlz4APKQjMXQJxo=`);
const wipl_test = bload(`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
AAAAAAAAAA==`);

const wipl_dump = bload(`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
AAAAAA==`);

const diag = {
f1:bload(`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`),
f2:bload(`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`),
f3:bload(`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`),
f4:bload(`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`),
};
const uc = {
c0:new Uint32Array(2048),
c1:new Uint32Array(2048),
e:bload(`wAAADQABDS2TUnAAUJoAACAAGgoQEAEACoAAAAEQAAAAAAAAgAENAAAAcC0AAAAtCQoAABAQAAAA
AC1QAACdYAAAcBANDQAKCwAAAIAAAQAKGgAQAAAAAIAAAAABAAAAAAAAAYAAcBBQAAAgEgAAAAAA
ABCAAAAAUAIAAAAAHRBQAAAKDQENLRMAAC0AAABQAQAQABAAIBEQgAAAI4AwIFBwEQAKABoAABoA
DQogABAQgAANCw0QnTAQAC1QCgAgAAAAEAABARoAGhAaAAAALQAAAAAAAAAAAAAAAAAAAAAAAAAg
EBAAUAAtEC0AcBBwAHAAAAAAAHAAAAAAAAAAcAAgEGphLQstABARAABamgAAAAAhLQAACgBwEQAA
EBAtABBwEAAQIAoAABAAIAAQECAtABAQICAKABEREQEQIAAQIAAgAQAAABogAQAAAQFwbQAAbQAA
CRpwAHEADSogYAAAAABtAA0AAAABAA0qAAGRYA0aIAAAAAAAcXANDS0TYA0aIABwAAAACiANABAQ
AAANCi0AAAAdEABdcC0AAJANAA1qCmCQAAAAAABQAA1wIA1qCg1hAAANIAAAAAAAACogTS0ADQBw
AAAAAA0ALQAADS0SDRGAEABwAHADAi0AAAAAACFwAAABAAAtLQAtCgAgAIARgEAQCg0tLS0tLQkR
EQBQABERAACQCpACHQAAEREAUJkREQAAkAqQIAAAGhERAFAAEQEAAADwEBoRABEREQANAhAgAHCQ
AJoRABEAEREAECAREQAAkAoKDWAgEBAQEA0NEREAAAB6UBEAAAAAcABQABEgABoACgANIAAtAQEA
UAAQEAANCXodUBAAcAEBAFAAAFAacAEBAQAQIAAAcABQAAAAGgBQAQEQIAAAExIQUJEAAFBwcBER
ADAALQ0REFCRAQAAkHAQGkAAAABQABBQEBAgAAAAAQEAgJGtESAQUAAALX0AcAEBHRAAAAAAEFAQ
EHAQAAAREQAAcBCAABBQAAAKIFAhEABQAC0AGgAAGgAacHABERFwcCBwAJGQAQAAkAAAcACRAAAR
ESARERERERENIBERES0tLS0tAAAACgoKDQAREREqICEBEABwABoAGiBgIABgYB1QEAAAEQAaABoA
UAAAABoAUAAaEAAQACAAABAKGgoaChoQECAAAAqAIAAAChoKGgoaEBATAREtXRERgFAQABAggBAQ
EABQcAAAABNgIBoAAAAAAAoNCgAKAAAAAAAAAAAhAQAAAFAAAFCAAFAAAAABUQAAcGAAAAFgAAAN
AAAAAnAACQBQCoAACgCAAAAQcB0AEBAADQ0RAHBQXQAdUAANDQAAAgMQgABQEBAQIFAggBAAEAAa
AAAaABoQAC0AAACAcAAKAAogGhAaEAAAAAABAAAAEAAaECBQGhBNUAAAAFsADQAAAC0AERoQCAIN
AABQEwoDAAAKAAAaEIBAUC0AUG1gAAAQEABQGhAKAC0AUABtAAAAERFAUFAAcAktcJEAAAAKAACA
AJAKAAAAAF0AUAoAMQAQACARCgCQQAAtbWANE3AALQABGgEgKiANDQAAAAAAAAAAAAAAAAAAAAAA
AA0AAAoNABEADQAAAAANABENDQAAEAAtAAENAAANDW1gcHAAAAoqACAAAAEQEFAQAAEBcQEAChAA
UAqaAS0SABEQEFAQAABQCgBQAABQgFAAABMLERBNgIBQGgAALQEtUAAtAREgACAtEAAAEAATEBAA
AABwEA0tACAAAABQAAoAAAAAEQoKAHAAcABwAABQAAAAUAEKgAAAAB0NEE0aXcBQABBxEBAAAAAA
LRAAcABwAHABDQEAExAAAC0gDSAAAQAAAHEAcBAAgAAtcIBwAAAQAFAAIAABAIAKCgAAcAARkQAA
AABQAACAAAAAAAAAABEAAA0AAIAKgC0AAABwAC0AABoKDQAAAC0QDQAACgBSAA0BAZBQIwAtEABQ
LSAjEC0gEgAAACAtABEAAAAAXRAgABMAAHAtAAAAEwCQAAAKCQAA0ABgAAANAAAKDQAAIABwAIAT
gQAADQkAIBAAAAAAEayQAwAAQ9CQkACQkACQIxIdHR0NQBHQUCAAAFAtIABQEEAAI3BQACANAAAj
AAAAIA0NACMRLQ0gAAsAIAANXVAAAF1dADyaMAAAEC0gCwAQcF0ADQBwmtANAAAgIw0AgAAAAC0A
AJpwUAAAAAAAAAAKAFAKAAAREwsAUCA9AAANDQBQHXAAUABQAAAAEAAAIAAAERARAAAAAAAAAAAA
Cg0AAAAAAAAAAK2QLAAAAC1QAAAAEBEQEVAQAABQgAANAAAADXAAACANAC0AABBQAAAAABFwAAAA
cAAAAA0gDRFwQAAAAAAAMAkAAgAAIwBQIBAAChAAAAAAKgEBAAAAAAAAAFBwDQkADQBQABEgAAAN
DQBQAQoaEBBwkwALIAEAAACBAAAAAAAAEQAMAAwAgAAAAAAAIAARAAABLQAAAC0AEABQcAAAAAAA
AAAAAIAAAAAAAAoAEAEAEAAAcABQUBAIDSCgEAANDYAdAB0BAACAAAENGgBDgIAAAQAAAAtQjQwN
AQ0ALYANLQAAkQAAAAEAIAAAIAANAABQEAAQAAAAABANLQAgLQ0AgBAQEAAACg0AAAAgABAAExAA
ECEAEQABIQoKAJCAAAAAAAAACgAACgCQLQAAUACaAAAADQAKDQAAACoKAQBgAA0AkBGAEAA=`),
f:bload(`qwABEwFjAEs5AwEBAQMBAKIBAQABgQABCzEbAAMBSwE7ASOjAVNLiwABGwEDAQHLABu7AQGBAYEj
AUsBAQGqmiMBBAuBA0kDGwAbAbEBI0O7q4uBAQMBATF1GwEjQwF1IwEBa3mJBAu7dRuBAYmLAwEB
AYFxiYsju3MbIwGJqtoBAQEbAwsDAQEBG0sBARsBCwEBKwEBywEjORu5AbuBgQEBAQG7AQEBAQHL
IxPLAUGBATNbAykButsBSUthIztLAAEAgQEbEwMBgREBAQEBAQEBAyYmJiYmJiYmJiYmJiYmJiZD
gQEAAQEBAQEAAQEBAHQBAQEBASQBAQEBAQGApAHLwjuKEwABEwEBAQG7AQAAAAABSwEBQwEBAQEB
gYEBAYkBgYyBSxsBAQGTSwGBgUtLAcLCubkbAAEBAQMBSwGBAQEBEwEBywFLAAEBAxMBO0MbOxtD
FwEBAQs7QysjKRtDG8O7G0MBAQEAAUMrIwsTASurSwEBQ4EDCwEzMwEBASujS6sBAAAAAcsBAYEB
AQEro0sBIwEBASPLAUtzIwEDAQABIwEBARsBAYHbq1MBywMBIwNCAEMTAQMTARsBExMBigEBAAEB
AQlpAXMZAhEBAwEBAwExAQEjASMTCwIAAZsjAYIBAQGBIwFLAQECASPLATkLgYEBAQOCgoKCAhOB
AQMBASsjAauBC4IDAQUFgQEDAQErIwGrgQuCywEBAYEBAwEBqwMBq0MBAgEBAQGBAQMbgwFLq7uB
AQsLAwMDgQEDI0sBAQGrgQArgUuBAYEBgTNLCwOAI4ALAQHDAYsDAQEBKwGiAQFLAAUFyQEDCwMB
AQABqgELEwuBAQGMgQsDQwEBAQEBAVsLAwEBS0sAAUMBAQEBEwEBCwOZSwEjAYEBARMBAQEBAYsD
AQEBS0sDAQETAAEBAQEBG5qbnxszswEBmQFLCysDCwMBMQE5C4EBASMbm5u7AQsDgQEBADOzAQEp
gQGBiwMLAwGABAE5AQEBAQETywESAQEBe0tpCwEBAYEBAQELAQEBAQEBARMTCwEBgQEBAQETQ0MB
AUsBAQEBAQEDS4GBgQEBAQEBAQEBCwsBAwGBgYFLAYIDAQEBASMBK0tLggGCgoEBAQEBAQEjASsB
AQEBASMBAQErOwABS8sBAQEBqwGrAasjI0sBAQsxAykBAYEBgQGBAQEBCwJLExMBAQEBAQFLgQGB
gQEBI6s7AQEBywEBQwABAUMDQxsjAQDLG8MjywGaE0MBm4GBOwExAQFLIyMLAxMTAYEBAQOBC4u7
uwGNAwEBAAEBCzEBEwMxAIsZAQEBgYElJYsBAQEBAQEBAQEbIwEBAyurOQEBIyMBywHLMQEBASsB
AQEBAYEBk0sBAQGCAQATSxPLgQOBAQMBCwEAARuBIwGBEcBLgQGKAQsDBgQDAxEBE0sBAYEBAAuL
AQEBAQMbAQELAQGBASOBAQEBAQEBqzsZgQEBAQELnUudnR0BI7MzAQGBAQEBAQABATkjAQEDAQEx
AQEbI0M7K8ujQxMBAQABAYEbGyMBgQFLAQEDAQGDSwEbAxMBEwEAAQEBqwEGIyMjIwEjIyM7AwMA
AAMBAQMBqwEBAQEBEwEBAQEBIwEBohNLAQABAQEDAwEjBgYBAQFLAUsBARMrkwELAQsLCyMBgzkB
ARMBCwEDAbqBAQGBAQEBAxsBGwEBMQEBAQEDgYGKCQEBAaUBSyMBAQFLc4FLQzvLAQGlogEBORMB
AQEBASNLI0sBIwEBAQsBGwEBgSO7AQEBASMBAZsBAZMBAQwjMUOrjPojgYoDAYEjAHEDAwEBAasB
SwMBAQEBAAHzIwsBAYEBAUuhM8oBASsBAQMBAQEBaYlLq7CrAwEBiQAjSwEAAWEBEzuBAQEBAQEB
qxsBAQFRAQEAqyMBgQEBAYEBATkrWUsBARMBAUuBAYG7AwEBAQEBEwEjc3BzASOrqwEBAQEBAQEB
AYEBgQGBYgAAAAFLgQEBOwEBYwHLI+oFAQEBAwEB2gG5AwEBAAFBKSMBAQEDAQEjAwEASwABASEB
AQEBJisBS8IBAQEBASnBewF1ejmBgQGBAQEBipIBAQEzAQE5AUsrSwGBygEBgYGvAa8BAYEAAQAB
AQFhgaszswEBAQCBASUBHqMDOwGTIzsBjwGLAQErCU2BAwMBAcujAQEBizEAAQGBAUujMSMmAUsB
AYsBAQEAo6OjAQMDAQELAQEBARNJYYIDAQErA0MLgQE7EwGBCRupATsBAQEbAQEBASMBAQGBAaij
AAEBJgEBAQGAASlBAQF1i0sAARsmATsBQwEBAQsBMQFLo4EBAQEBccurK0sBAAEBS6OBARIBAQsB
qQGzASPKAwszgUurq6MBASMBEwCbAQEBgYE7i4oTAQEBARsLAQEBAQMAAAEBe4MBSyMBAYFLC0ED
C4EBEwGLExMBOQEBARMBAwEAAUsBAQGbASOBAZMBOY8AAYEBgTsBAVkbUQGrOwEBgQEBAQEDAQEA
gQABATsBAQEBAROBAQABgZsRAQEBAYE7AYGBigG7uwEBIwFLAQExeYt7AAF6STkBQxsBAQMBOQMT
AwEBSxMTUVgbAxsBAAEBgZsBAZYAAZsBAQEBAQEBAAEBSwEBAQMruQGBAQEBQ0urAQsBu4GLAQG7
AZoBqiMTigETAQExAQEDAQEBE4uLCwGBAQMBCIsBmwEBAAEAAQEBAUsbCwEBAQGBARMxAYE=`),
h:bload(`xgAD/gN+//9/fgMDA3/GAC8Df3lzcn8DfwKSAH5yLmotAgZxA37/8goCDv4yAgI2/n8HAnNyAlIv
Af8CAwP/LjEDc2qXf4R/f3IOA3MCFy4XFgdyAgcAAQJyDgI3DwByMwEBfgJFc2pycg5y1kUHBwAB
AXICRkcucn4OJgJGFxMCAwN+/5b//34CDv8DAi8AfwJrLrcCchsSAhJmfTJycgIDfgIXkX8DA38T
/38HAwcSAsX+3pfF/8b/A/4CfweSAAEAcAN/f38BFwZ/AgIC/gMCB3JycnJycnJycnJycnJycnKW
c3IAAwJ3cXUAAmoCc5MBAQEBAhIDAQEBAQJyBgPHE39+/5b/cpIWAwMXfgAAAAAS/wMCfwICVgMC
EjL/AgYC8nLyEn8DApJyEwISMhL/ApIOBgZ+AD41/n6SEwJyEwITfgMCc3+GfgMCfn4C/5MS/xOS
fn8CAn5//3+XpnMSE3K3E/4DAgB+A/9/f39+f/+XfwICDnKQfgJ2tv9+f/+XfzICAAAAAoa3ARKS
AgP/lv8CcgL3anIWA/5qcWr/A/+bf4ZyAi8BAnJy5fYCx/+Xf/9+AAd/EuXGA5IC5n8SFv4C/wID
AAECAfYCfgIC///W/n4CcgIyAjJ/9n6SATMzAn4DAwHXLQL+/wJ+Ai8RAmp/cnJyAn9/f39/fv4X
FuYDAn9+UwZyFw5/13NyNzbGA/5/flMmclcuBwIDfpeWxgICV15TJjJzkn9/An53dub/1pJyE2Zy
AzV+Un7y19bGc3J/flNScn5/F31yknNycrc2f34DBiJ+A35zAgcGAgICclYvA38NfnO3BgL+f34C
ApKSLwH/tn4XAxJzcn9+EpMDAwN/An5/fwJmFn4AAhIDAwMDfwMCf38GLwMuf/bGk39zAwMCAldf
AnIC//8exgN/fwMDagKSfwcHB4enZsaSBxNycmtyf38CAX7+H3LGApJ/t3cCAn9/FxICAKdmxpIG
cwJyBwZXXwJzc2rDAcYCAwN/hwJ+kgMCcv4CfwMDf3J/AgJ+Hl8CAnICA35zfwMDc3MDAwJ+khN/
f3IWVpZ21n7+chY2lv7+/v7+AgICfn4C/gIWNpZ/f35fcwICA38Df3J/kQIODhcDEwMCfgN/A38D
AwMDA38DAwN+BpKSc4cDAhN/FX8VfxUSM3IDA38CR8YCfxV/FX8VEjJ/f3///1dfcwNzA3MHc3Nz
cwMCB3Ny5n5zxn9yMeRyaH//h5d/xnFzc3IGcgJ+fjMDMXFwkwICcQNykeV/fpLmAnIBan9ykua3
ZgIRfgMC/gMDfwMDfkcCkQYFAtcCEjJzt7Z/AQICuwH+AgL/fgIC138FAwMCEjIRcgJxAnICcpJ/
AwN/AhcGcxcCAwJvAgB+c3+HFwZXRpICkgF/MTIyBQEXB4dql4YXAmYGc/6S/4cB7v8Dfndmfn/X
AgMCfn9+AwN/AwLXxi9xAv4DArdyc3IHEwOSf3J/cv5zc3G3aqdnf39zAgICA///c34GAwN/cwID
A3J/kmpqkhdyDn+SfpKScnN+f5FrcQL+l3L/fgOWtwN/f39yfxK3+wGScuZyBAQEBwAEBAVyJgYA
AP8DA5cXcX8CFwIBLgIXAX42lgMDLi8XAX4XAQI2NpdqJgYDAQKXApcDA30PBwMPAn5+f38DlwYD
A3d+fv/3An9zcwNzAgMDfy8CLQMBAwIDAn7+FnMXAgICf3IC/n/+AgL+flZyLg02kgJyLuZ+bpID
AwICk///Lw0CkgMDA38CkgMCNX8XAgICApIDAjMBAmZyAn1/A3IzcRr/cxd/13MsAAZ/BXNyAzEB
/gUCAwICAALWf33mfnLyRv4H1xID/5FGAn8BAgcCAif+MmIyBwFxJpMvLwF7AgLXfXJSAwIWfmoC
Ri8BAgICAgIARy4CUT5yApcBAXN8Av8CAi4DAn5xAhcWtwIDAv/m/wNzfwZ+ARYWNnICfQL/kgMC
/nJ9cv5yfgAAAJL+UX8CLwMA93IScn5v8wP+kwICfgFykQNV/gJGAgZyAwJ+AwN//5JxDXJyAQF+
fgEBt/4CkxICAgMCfn5yfgJyfgJycgNycgNyf3/3//+Xkn4CAn9rHmo3EgICc3MHfQYCAnL/ApJ9
AgICcre3Zn1+/v5yAh0CcQb//wJzkheWBn6WcgKSZ/9yfQ2SAzdytwEDdgP/AgJyff9yAnByAn8C
AdYDAwIAcnJxAuZ/AwN/AwJefn0CAn+3AgL//4Zp1wKSaQLARy3Gku8BkwMtf/J/AnIBAgLBAgcD
l1shcgHCAwIjwv/nfgJy8jeSSi1y8l6SXgHGAoYCAwL/cnEBfwMCAga3Z/8CAHMCf3JxAX4DAob/
5wFmAhcS/3+ncn7mkrUCcuaG1gDlfQICcgMKFg4SAwMDfn5+AQICAvJwAAIC/7YC/3ICARaXfgL/
/3Jqf38VEjIDfgOWfRYCE5J+An4CAgLlfuaWApUBAgYAATECci5eAgJ+/wJzcv4CEgECAwGOAgIA
cgACAi0DAgIDA5dxcl4BEjIGAmsAAnJ9l3FzDgJ2lgL+Bv5/AgIBkhb/fwJ+AgICfnICAn0Ct31+
frcB/hL//5KSfpICAH0DcgUClgb+AjMBkgKSAgJykQq3/gGSXv9y8pJykgMDfv/mcpKSMnLmfpIy
kn4CfgZ/f38VAnICAgPyAgMDFxIyfwNy/n8DZzN+MwED/wOb+wEDA5d/fgNzAvsxcn4AcnI=`),
j:bload(`gQAA9ACEgIABgoQAbxPIAEB0AIIAhgBgAIGAAIDChMDAgIKAAISAgICEhICIhICAgAQA9ACGgMBA
gICAAHSDiMAAgMDAgMACAICEiEH0AMAAwMDAgECAgIGAhIAAwICAQICAgIXAgMCAgISAgsDAQICA
gMCFwALAgICEwILAgIyAAHSAgICAgICEhIQA9EDgAIAAwoSClECChYTAoMLggoKAgIBAwAQCdAQC
9AQAYECCgICAgN2cgYGDjYCBBAD0AIAAgAB0BAD0TIMMg4iEgAD0wICAgICAgICAgICAgICAgICA
wMYAj4SCwoIAgMCAAICAgICAgIAAgICAgIyAgIRAdBiEgICAgODAAHQPgwAAAACcgAD0AICAwAD0
wMCAgMCCwIDAgAQA9ILgAPTAwICA4ICAgICAAMbAxuDgAPTAgICAgAD0dACDgAD0gICAgAD0gAD0
wACEgIAA9BwAhAD0APSAAPQAgICAAPQcAACDAPRcAICAgMCAgICAgICAAPRcAACAAAAAnMTAgODg
gAD0nICAgICAgoCAgICAgIOAAPQAAMCDgEDglMCPgICAAPQAAICAAAD0gICAAPTggACAjICAgICA
gIWBhYCBgIGEgICChICBhoTAgsAAgICEgEDAgICAgIBAwICAgIKAnED0gMEAg4CAnICAgICAgADE
woAPhACDQMCDQMOCgOKAxMKAD4MAg0DAg8DDAvQAjMTCgI+IQINAwNSDiAQC9ILEwoCAgICMQICD
AMOAyOPIxMKAgo4Ag0DAg4AcwICAgMTCgICAAINAgMCAb4QD9EDAgoCPgMBAdACCgACAgISAAICA
gISAQMCAgIDMj4aAxACAgM+EAG9EgoAAAPSAgIQAgoCPhAB0BALvAADAAGDAgIKAz4PIAOCEgEAC
9oCAgIDAgI+DiAB0w4CAgoCAgICAhIDPzIKCgACAAAD0gZeBg4yAj5wAgIDAiAAAwPbgAISEgM/A
AobGwMBAAvaAgMDBgoCPAHQEAO+AgIyAgICBBAB2RMBEgoKAxsaCgoCG4IODiAB0w8gA9ISDgICA
Y4zExMTExMSAjMDAwICAgICAjISEwMCcgIzAwMAcgIADgo6CAAB0DINAgIyAhMwPhgL0wgAAdAyD
j4QAdAQA7wCMwITgAAB0APZCwEDAQMCDg4wAYACBlMCCQsBAwEDAg4OAAIKCgMADj4+CigD0g4gO
YIOCgICAwIAAgETAwMDAwASAHHQAwICAAICAgIDAgEB0wM/AAO+FwI+EgICMj4CAgoCAwAD0hISA
gISAgoCMgABvBAFwgACBgMDAhICCg4OAgIADjIKAwICAj4CA4ISCAIDAiQDgg4PCgoKCgYCIwIAE
DHQAg0TCAICAAIDDiACEBAB0QINEwoCAgIBAwIDAgIDAA4yPRMKMj4KAgI+AgED0gIAAgETCgACA
hADvgECAAHQEAPREwkKAj4AA74CAAIDAgwzARMIAgOAA74CAgACAgIOMgI+DgACAwIGAAHQEQOAB
dIMAgICAgI+EgADAgoCAwICcQJyDgIiIgICAgICAhAB0BAyAAIKAwIDAgMCAgICAAICAgICAwMAA
AIAAdADAgAOMwICAwIDAgIDAgAB0wECAgIDAgICAgICAwMAA9JwAgAAAAICDzICDjICAhABgAMAQ
bwCDgICCgoCDjACDjABvBFDvwADvAe+QhJCAxADsgYGPFICEgAOAnICAgMSEwoCAgICAwMCAgIAA
YICGgICAQoCAgABvBBDggAD0xAQA9IKEgoCAgEDvkIjAj4AEAfRAgMCEAOwUzwLPAMCAwAPCAMCG
gMAAgIiAAICAgIDAgIDEwICAgICAQIDAhICAhgCMgcCAwInAQIDAwIBAdICIgIFAgITAgIDAg8CE
gkDvgJCBgIQAAsCAwMDAiMCAgEGAgYCAhMCAgIDMhECDgIAA9ICAhADgAMCAgIDAwIOAoIiAgADv
4IKghOCCgwAAAICAwAD0QHSAgIOAgIyAwICAgICEg4CNgBDAgIDAgYCAAPSAAHQAgMCAgIDAgIGA
g4CAgICAQPSAgACAgIGBgICAgIGDlxSDlxSDgICCgoyAg4OBjwBAgMCAgICAAICAgIDv4KCAgICA
iOCBoICAgICD4ICghIKEgICUj4AAgIDcgICDgJSAAICCgICAgICEwICAg4GAlOCCoICAgYCAgICA
gIOAD4AAhICAgIAEAG8EAPTAgICBgYCAjICAgISPgICEj4TPwMDAgICAgIDAgICDgIyAgITAgAB0
AMDAgIDAAICAwIGBgoiAgICPwMCAgMCAg4+MhICPAeCUgMCAwICAgYGAAICAAACCAIDAgIKAgIDA
wICAgICAgACAgICAgMCAhJzAgACAoIDvgkCDhMjgAHQEnICAgIiE4MCAAICEwYCAgMCAgMQAnIGA
gMDAdEDAg4OUgQDAgMCUAMCDgIyAgIKAjIDAgMCAgYAAgMCAgoCAgIGAgYQAgICAg4CPgICAhIAA
wACAhMGg4IwAYEDAgICAgJDAgEDvgMSAwIACxOCAgIKAgIAAgOCBw4CAAJaAgYGUgICAhJSPwYCA
gMCAgIKAgYGAg4SQAMAAgICEwICAhFDvgICAhODA4IDAgICAgICEwYCMgAB0gICAwICClIDUgoCA
gICA7IB0AEDAgIOJgADAgAB0QICAAACDgIcAb1CDQPQAgGAAwIAAdAQcgAB0gMDAg4CBgMA=`),
k:bload(`QgBAQMDgQEBAYEBAQEBEAERAQEBGxkBAQEBAAADgQEBAQPBBwOBAQlBASEBQQOBBQEBBQEXFQEpA
QEDgQEBCQkJAQEBEQEDAQENIQEBAUkBDQEBA4FBAQEBHSEBSSOBHQkBAQEBASEBBR0hE4EhQUEBA
QEBAQFBAQUBIUcBIQk1AQEBA4EBAQEBASEBAQEAAQEBAQEPgQ0BSQExCQENBRMDgwEBD4EDAQEDs
QEBEQEDwQENAQEBAQkVAQEBAQEJAAEAAQODAQEBAQVBAQEBAQEBAUEpKSkpKSkpKSkpKSkpKSkpE
QOAAQEDE4sQAQEBAQUBAQEBAQFpAQEBAQEBBWEBETOCDQEFAREDKQEBDQAAAAABMQEBAQEBAwkBA
SEBA4EDgQEDATEBAQOBATEDIwExAwMDIQ0NAAPDC4EBATEBATODM4EBAQkBEwEBAQOBAQEBMQExA
QEBAQMBAQEBE5ERMTEFDTEBAQEDAQEBA4MDgQEBCQIDgSENAwEBDQ0BAQEBCQKJAAAAAQEJDQExA
gEBAQkDgRABAQERBQEBAREBAQEBAQAJAQEBAQAJHQkdAREBAQMCiAExATEBBQEBAQUBJQEBAQEBA
QEBAQMdAREBAQEDgQEBA4EBCwEJAQERAQEFSQEFAQEBCQEBAQEBEQEBMQEBAQEFAQEBDQ0NDREDB
8UBAQMBASFBCSlDgQMNAyfFAQEDAQEhQQkJQxEBA4MHhQMBAyVBIUERCQsDAQODB4UBAQUAEQEJC
QELAUEBAweFA4ITAQEhQQkBAQkAEQEHhQ0NEwEBBUUlAwOBEQEhQwEBAAcBEQEDIQEBAREBAwEBA
QEBAQEJAQEBAQPBIQMBATEBAQEBA4EDAQEDBQkAAwOxAQEBAQMBAwEBAQEBAQOJA4EBBQEBAQMnw
wEFAQODIQMDgQEBAQEBAwEFBQUJCQUBAQvKEQEBCwEBAwEBAUERAQEBAQUFDQMBAQPBAAEBAQOBS
48DjQFDA8MBAQEBBYEDAQEBAQgBCQEBAQUBAQEDAQEBA4OBA8PDA4ETA4EDgQEBAQEFAQEDg4OzA
QARASEBAQEBABEBIQICAgICAQEBAQEBAQEDAyMBAwMRQ4NjgQEBAQARARECrq0BA8MBA4EBAQEBA
QEBAQEBAQEBAREBAREJAAPDAQEBAQEBQUARAQEBAUEJAwEBAQEBAUFDgwODA4MlQQEDB4EBEQELA
QkDgQkBBQEBCBEBBREDjQEBAQEBAQEJBRERCQUDCoERAQUJAQEBAQUBEQELAQEBBwONAQEADQEBD
QEBb4EBAQEBAQEBAQFAAQEBAQEDAUFBCQkBAQMBAQEBAQEBAQEDgQEBAQEBAUFDwwcDBwERAREBA
QEBAQEDxQUFAQABAQABAREBCQPFI8UBAQEBAQUFDUkBBUELAQOFAQEJEQEBAQEBAQEDgwEDhQEBA
QEBAQEBAQEBAQEBA4UBBQEBAQEJCQEFJUEBAQOFAAUBBQUNCQEDgwEBBQEBAQEBA48BCQEBAQgBA
QEBAQEBAQEFBSEBA4EBAQeRAQEBAQUBAQkJAQEBAQuBAwEBCQElCQEBAQEBAUlJSUkBSUlJBTEQA
AEBAQEBIQUBASEBAQEBIQMBIQEBAQEBBQEBIQEBAQEJATERAQEBAQEBA4MBQQUBQQEBAwEBAQEBA
QEFAwEDgwENCQUBAQEBAQEBAQEBAQEBAQEBASkBAQEBAQEBAQEBAQEBAQEJAQEhBQABAQEBAQABA
QODAQEBAQEhAQEBAQEBAQEBAQkBDQMBAwEBAQEFAQEBBQEBAQEFCQEBAQEBAQEFAAFdAQELBQELA
QEAAQEBAAEBAwEBAQENCQEBEQ0xAQEBIQEBAwFJAQEBAQkBCUEBASEBAQEBAQEBBQEFKQEBXQEBA
UkBAQEBAQEAAUkBASlBCQEFAQEHgQEBAQEBAQEBBQEBDQEBAQEBAQEBEQEdAQEDCykJAQEBAQEBA
QERAQEBERgAAAEBASEBAQEBARkVMREZIQEBAQEBARUBFQEBIQEBKQEJCQEBAQEBAQEBCSERCQEBA
QEBAQkBAQExAQEBAwEBFQEBDR0BCQUBAQUBAREDhwEBDQEBAQEBASEBETEBAQkJCQEJAQERAQEBA
QEBAREJDQkBAQEBEQHhAQUFAQEBBQEhDQEBAQUBAQEDkQEhAQENDQ0BAQEBAQEBEQEBDQERCQEBA
QEBAQEAAQUFBQEBAQEBAQEBAQEBAQEBAQOBAQEBAQ0BAQEBCSUBAQEBAQOBAwEBAQERA4EBCQEJK
QEhKQkBEQEBKREBEQEBDR0RASEBCQMBAUEBAQEdAQEBAQ0BAQEBAQERCQkDgAEDAQEFAQOFAQEBA
QEBAQEhM4EBAQEBCQkNAQUJB4QBBQEBARENIQEtRQEBAQEDAQEBAQEBCAEBAQEdAQERAQMBA4EBA
QEJAQEBAUVFAQEBA4MFASEBAwEBAQEBBQEJAQEBAQEAAQENAZEBAQGBAQEBAQUBAUkBAQEBAQEAA
QgBAQEBAQEBAQEJBQUBAUkFCQEBAQEBAQUFES0BDQ0BAQkBAQEBAQFBAQMBDQEBAAEQAQEBAQEBA
QEBAQFFAQGBAQEBAAEBAREFAQEFAQEFAQMBAQEBBQEhAQEBAQEBAQkBCQEBAQEBCQEDgQ0FA4EDj
QMNAwULAQEBBQEBAQEBAQEBAQVBQQEBAQEBAQEBAQUBAQEBAQEBAQEDgwEBCAEBDQOBAQkI=`),
l:bload(`GAD+HvwY+Pj/GZn+//8cAP7//5j8G/7//xgeABAbGKCYHB2Y/Br4Fh0HeAAXHBwVHPn+GPwbHrj/
mPgc/f/4GJj/maD4+Bn8/x4Z+P2g/xj/GJigH/8RmB4YHRj/+B2g/5iYGRmYmaAcGB0ZGJj4/xGY
mKAZGP8dHBkdGR0Y+PgY/v8f+Br4+BgdHPj+GP0Y/xD/HfgZEP8cHxwcmKAeHhj4HBj/mP/+//n+
+Pn+//8aEJgQEPiY+Bn4mB8Z+f4YAJgAGf7//v6Y/Bj8GBgdGP4Y+BISEhISEhISEhISEhISEhIY
+BsA+ByQmJAAgBiA//mQkJCQGKH/kJCQmBgYofD+//xZ+Br4Hxkb/v//HQAAAAAf+P4b/B+4G/4b
Gxv4Gxu4GxsZG/7+GR0b/hsbGxn4GxsbGxsZABuYGxsZ/htT+Fv4W/4b/PwaGP4bGh+4+P5bmP5b
HP+5ARj++Pz7HP5b/lv4/lv+HIAY/vj8/Pob/vj8/x0UFRiAGLi4uPgb/vj8/xm4AAAAGQD4mBkZ
Xf74HPgaERH4GRV++B0dmB34/vj//B8YoP2YHR4ZmKC4/vj8//gfAP74Hpgc/hkfHPwZGRgW+Bj4
gJgemKAZeRkc+PgYfxkeGRygGaD/HHkYmP+YoBn4mJj/mB4d+Bh5Gf2YGaD/HR8dGZiYmJiYeXz4
Gxv/HPwa/xoa+Br4+Pga+Bsb/x38Gv8aGvga/hr5GvgbGxob/Br/Ghv4oP/+Ghz4Gxv4Gxka/6Aa
+JgaGhoa+Bsb+Br8G/8aGhz8+JgYGfgbFPh5/Bv/GhB8/x/+GP+guBoaGhv+//mYHP/4Ghp6/xwa
GRsZ/5j4Gnz4+BqYGv8cGfj4/v//uBn7/hscGxoAuB/4+P7///4b+/4b/v8a+BsZ+Pj4/vi4oPv+
GxkU+PgaGfj4+P7/GqAa+Pj4+Pj4Ghka+PgaEP8a+/4bmBt6+BoZGhD/+PgaoPv++BsZAPgZGRoT
/7gb+KD7/hv4+Rj4mBka/v///hwHGvgZHx8a/v7//hv+uLhZG/i4uB24+Bv4+P7/+Pj++BkbG/j4
/xobGxsbGxsTGhsbGyMjIyMjGxsbGxsbExsaGhr8+Fv8+Bu4/v7//Br8mBsaGvj/+P4bG/7+//z4
+Pj+///++P8bFBsZ/v7/HPj8mPyY/Jgb+Br+//8S+BsZ/Jj8mPyYGxv4//j4+Pj/+Pj4+P34+Pj9
//gZ+PgTFBT/Gv8amBscG/74/v/8FJj4/6AbExsbGv3/mJgb/hsbmPgamJj4GxoauAOYG/5cGxv4
GBuYG5gbG/7///7/Ev8amBiYuPgZGhr4+KD/mLgZ+JgZWhn4ERkZ/PiY+P4ZoKCYGxmYGqAaAh3+
/v/8G/8b//gc+BD4oAAb/v7//Bv/GxwcHJj/mAQfmJjg/Pga/xv4HBwc+Bwc+P6YBPj8Hv8bHPyY
Gf4fGv8b/v/+/hz/G/+YHRj+GfhZ/xz4+P+g/xv+HR7+mJj4Wf/4+Pj4GR4c+P/4+Bsc/v///hL+
/xv/EBAaFPgQHPygHBsZG/gc/5j4mBwd+F34HPkc4P7//v4Z/B34+JigHBwUFBQU/xQUFJgdHBwA
APj+///4mP8bmByYHRz4mBwdHf3/HP/4mBz4kB+goPhdoKD+mBz/HP/8/Jj4+Pj4oByg+P7//x/+
//4eG/j4oPj4+P/4oP7///4dmP2Y/R/4GBkfGv6YGRkcmRMdHP8UHxsaHRoYHpgVFRgTHBQUFBj9
/xy4+Pj4/5igHf7///4dHf4amPn+HbgduB34Hf2YHR0dHZj5/h3/mBr4/vj5+P8YABj4mP8d/5iY
HpgemB24ALgd+JgUFBQcGh6Y+B34/5gaHfiYuP8dGZgeoBmg/5CYHZj9/5iYGRn/mBgd+BgdHaAc
GP2YGR0ZGBwA/x0ZmB2gGfiYmP8dGfgdGRn4GBiYHf8dmBz+Hfgf+P7//x0dmH0YGBgZmB34H/4Z
GR6YG30eHQAAABQdmP4c/f+Y+B0dGB34+PgYmBkcHZigmP+YGxkeHRwd/h0f/v/8+BSYmBh4mJgZ
HpiY+B4e/hEZHv4eHgcRFREQGBkWFv8WFv8W+Pj4+Pj4Hh4eF///Fx/4HRYe//iYmB4fHB74GBiY
Hx4ZHvj4HpgbFngeGZgZmB/4+B7/HZh+Hh4dHh8d//gUmJgZ+PgQ+JigHfj4GBkemPgWHh8eHPgd
mB35/x4AEBWYHR35/v///h0eHpgWHviYoB74+BaY+B4WmBYe+JgeHpiY+JiYmB6YHh6YoBaYHv7/
//iYHpig/h74oOD4Hx4QHvgVFpgeHh4eHpgeHh4e+KD4FpiY+PgdFh74//geAP8e/xaYmBj4Hh74
+JgZGfgd+P/5HxYeHpgfHhEeHwCYmB4dHv8fBxYf/v/+Hx8emB8fHhQfAB64+B4f+BYemBr+HxT4
mB8H//yYHx/4Gf8fmB8e/KAfBx4fHxmYGhEeH5iYHh4AmJgfHh8fHR8fgBj/HRYZH5gf+JgcHx0A
HwAdF5j4Hx/+//+QHx+YHAAfoP2YHxqQ+JD/Fh+goB+gH6D8GB+fHx+Y/6AVHgegHx8fGJgY+JgH
HPiYBx/44B4fHx8fAJj/HpgZHx8YGf2YGR8ZHBkdmBmYH5gUH/gXHxkfGf7/H/gWHx8fGB+gGRkf
GR8dHR///P+YHwcVBfwUH/7//B8f/v8fGPj+//8Y/Zj++P//+Jj+//7+H/7/GfiYGB8fHxk=`),
m:bload(`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`),
map:new Uint8Array([
//.0   .1   .2   .3    .4   .5   .6   .7    .8   .9   .A   .B    .C   .D   .E   .F
0x8B,0x01,0x19,0x4F, 0x8B,0x8B,0x85,0xAF, 0x7B,0x93,0x8B,0x8E, 0xCA,0x7E,0x8B,0x8B, // 0.
0xFD,0xFD,0xFC,0xFC, 0xFB,0xFB,0xFA,0xFA, 0x56,0xF9,0xFE,0xEE, 0xDE,0xCE,0xBA,0x07, // 1.
0xEF,0xEF,0xEF,0xEF, 0xEF,0xEF,0xEF,0xEF, 0x1D,0x1E,0x22,0x23, 0x24,0x21,0x8B,0x8B, // 2.
0xF8,0xF8,0xF8,0xF8, 0xF8,0xF8,0xF8,0xF8, 0x2E,0x2F,0x2A,0x25, 0x4D,0x4E,0x1F,0x1F, // 3.
0x45,0x45,0x45,0x45, 0x45,0x45,0x4B,0xA0, 0x41,0x41,0x41,0x40, 0x40,0x40,0x40,0x40, // 4.
0x89,0x89,0x89,0x89, 0x89,0x89,0x7C,0x7D, 0x43,0x43,0x43,0x40, 0x40,0x40,0x40,0x40, // 5.
0x14,0x65,0x65,0x65, 0x65,0x65,0xB7,0xB0, 0x31,0x64,0x64,0x64, 0x64,0x64,0x50,0x53, // 6.
0x09,0x54,0x54,0x54, 0x54,0x54,0x8B,0x89, 0x89,0x64,0x64,0x64, 0x64,0x64,0x90,0x90, // 7.
0x1B,0x51,0x51,0x51, 0x51,0x51,0x8B,0x3D, 0x33,0x35,0x35,0x35, 0x35,0x35,0x35,0x35, // 8.
0x15,0x54,0x54,0x54, 0x54,0x54,0x8B,0x09, 0x33,0x35,0x35,0x35, 0x35,0x35,0x35,0x35, // 9.
0x2B,0x51,0x51,0x51, 0x51,0x51,0x8B,0x09, 0x33,0x35,0x35,0x35, 0x35,0x35,0x35,0x35, // A.
0x3C,0x54,0x54,0x54, 0x54,0x54,0x8B,0x09, 0x33,0x35,0x35,0x35, 0x35,0x35,0x35,0x35, // B.
0x2C,0x60,0x60,0x60, 0x60,0x60,0x8B,0x09, 0x34,0x36,0x36,0x36, 0x36,0x36,0x36,0x36, // C.
0x3E,0x62,0x62,0x62, 0x62,0x62,0x6B,0x8B, 0x34,0x36,0x36,0x36, 0x36,0x36,0x36,0x36, // D.
0x26,0x60,0x60,0x60, 0x60,0x60,0x8B,0x09, 0x34,0x36,0x36,0x36, 0x36,0x36,0x36,0x36, // E.
0x30,0x62,0x62,0x62, 0x62,0x62,0x8B,0x13, 0x34,0x36,0x36,0x36, 0x36,0x36,0x36,0x36  // F.
])
};

const ffcmc = {
r1:bload(`AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAQAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIgAAACIiIiIiIiIiIiIiIiI
iIiIiIiIiIiIiIgAiIgAiIiIiIiIgICAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAICAgICAgICA
gICAgAAAAACAgICAgIAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAgICIiIiIiIiIiIiAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAgICAgICAgAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAgICAiIgICIiIiIiIgAAAAAAAAAAIiIiIiIiIgAiIiIiIiIiIiIiIiIiIiIiACIiIiI
iACIiIgAiIiIiAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAgICAAICAgICAAIAAAAAA
AAAAAAAAgICAgICAgICAgICAgICAgICAgICAgICAgACAgICAgICAgICAgACAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAiIiIiIiIiIiIiIiIiIiIiIiIiAAAAABQAFAAAAAAAABQAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgICAgA
CAgICIgAAAAICIiIiIiIiIiIgICAgIAAAAAAAAAACAgICAgICAgICAgIAAgICAgICAgICAgICAAA
AACAgICAgIAAAAAAAAAAAAAAAIAAgICAgIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
ABEWABYAFgAWAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
CAAACAgICIiIiIiIiIiIiIiIiIgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==`),
r2:bload(`f8/fH4+f/58Pn/i/j58vb8+f/8/6v/////////////+Pn6/P/4///6n//////////////4+a/4+a
///P+///////j5r/z4+f/8///4+fz//5/////4//////////////////////////f4+/n/L/////
/7+PHw/Zn4+f/////7r/iv/6//r///v/////////oKH/o6T////5/5//D///Dw///x//////////
///////////y////j5/P//r/+f+f//////n/n////////////////////////5T////P//mU////
+ZT4////////+///pP//z///////D/////D/z///+///+///+v9/H///8v8fT/9Pj0/5T/lP+U//
/////0//T/9P/4////lC//9C/x///x////9//7//////D////7+Pf///9v///5b/////8P8P////
v4//////f///j7//H/+//////x9PT0+PT79P/0//T////0n//////0+/H/////8ff///j7//v///
/////w+/j3////b///85//////D/D//////////////0+f/////5lM////mU+P/////7///////7
///69P//z//////////y///y////+Y+f8v////9P//9PH/9fH/8f/09fH//y/0/////y///////y
////T8//T///////////T///////T/v////////7//9K/8/////P////8v//j///+f///4///1n/
H/+S//////////L////////0///0////////////////////////////////////8v//////////
////+f/5/5///x//8v/////y+f//////n////////x//8p//H///n////x//8v//////H/8f////
////////////+///////+///////D//////5Hx/w/4///////////////////////////3//9P//
/w////T///////T////0////D//////w///y/w//f//z//L///P///////T////////z//T/D3+P
//9J//9J//+P///5//L///L///L///+P//n/8v//////+f/y///////w//////Kvr/8K/////xr/
/w/yD/IP8g8CD6////n/+f/5nx/4j/mf//8f////////H/8fH/+f+I+f/x//H///////////8v//
/w//D8//////mpr//8/P/////6mp////z/v///////////////////////////////+Pv/n5//L/
//APf///9v/2//b/9v/2//////D/Dw///7+P+Y/5+fv//////////////////////////////w==`),
r3:bload(`AwMDAwMDowMDA0MDAwMDAwMDEwMDAwMDU1NTU1NTEwMDAwMDEwNzEwMTE1NTU1NTU1MTEwMDEwMD
EwMDA1MTYxMTAwMTAwMDEwMDEwMDAwMDcxNTAwNTU1NTU1NTU1NTU1NTU1NTU1MTAwMDAwNTExMT
AwMDAwMDAwMDExMDEwMTAxMDEwNDUwNDExMDExMTAwMTAwMTU0NTEwMTAwMTAwNDEwMDEwMTUxMT
A0MTEwMDAwMDA7MTAwMDEwMTsxMDE0NTE7MTAxMTUxMDExMTUxMTE1MTAxMDQwPzcwMDQwMDAwND
AwMDCWMJYwNDA1MTA+MTAwNDEwNDAwNDA1MTAwljA1MTA0MTAxMDAwMTA1MDA0MDAwMDAwMDAwMD
AwMDAwNzAwMJQwMDAwMDU0MDUwMDEwMTUwMDEwMTA1MTAxMTAwMDCQMDA0MDAwlzCQMDUxMDQwkD
AwMTUxMTAxNTAwMDAxMDE1MTEwMDCQMDAwMDAwNDAwMDAwlzAwkDAwMDA0NTExMDAxNTAwMTAxMD
UxMTAwMDAwkDAwNDAwMJcwkDA1MTA9NDUxMTE0NjA0MDQxMTA0MDAwMDQwMDAwljCWMDUxPzA0MD
QxMDQxMTAwNDExMTAwMDExOjEwMTAwMDDSMTCXMDA0MDAxMDA0MDAwMDA0OjEwMDQwOjE0MTEwOj
E0MDAwMTA2MDExMTAxMTAwMTEwkDAwMJY1MTAxMDQxMDEwMDExMDAxMDoxNDA3MDA0MTAwMDE1MT
AxOzExMTEwMTAwNjA0MTA0MDA0MDCQMJYwNDEwMTEwUDBQMJAwkDAwUDQxMTExMTAwNDQ0MTAxMT
E2MToxNJAwMDIwMTUxMTQxMDQwNDA0MTAxMDE3MDAwMTA0MTAxNDAwMTEwNTA0MTExMDAxMDE1MD
AxNTAwMDQ0MDA1MDExMTA0MDEwMDAxNTEwNjAwMDAwNDAwUzBTMFI0MDExMTc2MDE0NDQwMD80MT
UwMDQwMTAxMDQwNDA0MDQwNDAwNDA/MDQwMNAwMTA/MDUy0TMwNTQxNTEwMDQwNDAwMDQwNDAwMD
AwMDA0MDA0MDExMDEw0zEw0jA6MTQwMDcwMTA0MDEwMTUxMDUwMDEwNDEwMTA0MDAxMDExMDQxMT
EwMDAwMDAwMDAwMTAwMDQxMJAwMDAwMDU7MDCQMTCUMTAxMDAxMDAwMDAwMDAwNDUwMDUxMTA1MD
EwMDAwMTExNDEwMJcwMDExMDQxMDEwlzAwNTEwMDEwMTUxMTCQMJcxMJYxMDAwkDAwMDAwMDAwNT
QwMDAwMDA0MDQwNDA0MDQwMDA1MTAwNTEwMDAwMDAwNTAxMDExMDExMDExMDExMDExMDExMDEw==`),
r4:bload(`BAgAAAD/+gAAAAAACgEx/gCQtQgA8AAA2uHh1HNpEgAIAAAAEgARHgC7H8zhxeGzg4IetQ8AtRAA
HxELAARFwklGAAA8CA0RHwgRcwwACBEAjcqNgPFnQjvh4eHhLfXMo3qXVS3AmQceBPMAEQAgPUFO
AAALAAAAAA4AIAEARgBGAEYARgBrYQAE6+AVkLsfAACnAABLsK0A+AE1AAC+gH8BWQQhaWjKhPjK
/AiuswlBSiMAAwiWDBEIkQBpAPj/QYVszwD4/0E1Ac4ANZ2NlqrP1iQiPHMcJwC5KBkJIQAAABwc
AAAAAAgADBcTAATrAOdGChkKGDsHAB0EIADuCwCWAATrAAIFAAAAABfiAIAQAAClAAAAAAAAAAAA
AgAADQAAlhf/AACAAAAACO4AAAAYXABSpcMA4gA1AKs5QDXKAAAABZYAAAIAAAAAAAAgAO6/x8QA
AMNhy+hp/1J9wwAAAWsANX0dORD///8A/wAA+ACNlgAAAAAAAAAAAAAA75qj6GkA/1JXwwBrADUA
WB05AkAAAAWWAAACAAAAAAAAIADuv+xzeehp1itMG1EAAFMTGksAAAscRgAAAAAIADEABOtGEzkA
AusAAL3sCBkvQjgqASMANeMA1QDBAAf+AADVAB9SHhilgL8XABKAAAAcAAwA1QAiB9MA1QU149IA
1f8AgPTAAPILMTUHDDM1AAsxNQAAAAAA2AQjCzEAAusAGAgLMRcIDjMgANXUAMsjAJJXAAcCzgDD
BGkAPMU46pLcAAC2HbhFGrUAHrIAAAAAqRyrUUAxMQAAAAAAAG8EAwAAndc46jXjADyTkpHBSAA2
cE2NAJMAAABAgQZ+AIulgKoAAAB0+FWq/zEYc00AAAw2AECeBqVr/zJzpQRlAECdqqoABa4ErgAA
YrEAAGRkTU4AAAIAtU61AAEAuwAAEMkDPCkAlLQADwAA/wDUANQA0TIAP+o1BQWN4yIhIAY2AABz
HiAaFwAnAf8cEQAOHQ0AEz0JABwGIPIAEAAAhQAcBgMA7wAADgDv+wP89ABQ/BjrCqEA/AD8IAQP
AAAAHt0AH9oANTYAQQAqQQAuAADVzgAABQA/ABAAQiRzAPgAAQBBcxAAODlzAgAAgLUAH7UVAQBz
H/cABAACAAEAAADJBAAAAHoAAAAAAAAAlosCAACCAIuKAGkEAIoAAAAAAAEAADJ5AAAAcoWKAAEA
jYAAAAtWTkoAAAAAaPcJVk4AAAAAuwEBCAAE6wDDPQA1QcrKAAAAEPsAAE8A/8QAAAAKAAAAGgAI
NgBAAqUAACAADgAOAAgAIAAgAADvv78BxgAUABYAAAAEACM6czs1czM0cyEXcxkTcxQacxsdcw==`),
r5:bload(`AKDw4AAAAAAAAAAAAAAAAAAAAAAAEBABAQEBAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AOAAAAAADgAzDu4AAO4OAAAAAAAAAADQ7d0AALAAAAAAAAAAAAAAAAAAAAAAAAAA3d0ADQAAAAAA
AAAAAAAAAAAAAAAAMwAzADNAM1AAAAAAAAAAAAAAAAAAAAAAABAAAAAAAJAACQkJAKDwACAAAAAA
EMEAAMDAwMAAHBDCAA0AAAAAAAAAAAkJAAAAAAAACQAQACAQDwAAAAMAAAAAAADdAAAAAAAgAAAA
EDDQMyIRAAAAQAQAAAAAAAAAEAAACQAAAAAAABEAAAAAAAAAAAAADAAAAAA8AAAA3QFAAlADYARV
3VUAAAAAAABmVW1QiHCoCoemCgDQADy7C5CAAAAAQAAAxQAiMAgJVwBGAAAAAFVEk4IAAAAMu1lI
AAAADwAAPL0LkIDDDMMAAABNDAzdV90JRggAAAAAAAAAAFVEAJeGAAAAPLsPAAA8PL0LkIADAABA
AN0M3cUICVcARgAAAABaRJeGAAAADAC7DwAAAAMAAAAAAN3dAAAAIAAAABAw0DMiEQAAAAAAAAAA
AAAAAAAAAAAAEQAAABBgADAGAEAAIAAEBgAAEQAAAAAAAAAACgAAAAIACgAGAAMAAAAGAAAAEAAG
AAABADAAABEAAAAAAAAAAAAAADMgEAARAAAAAAAAAAAAAAAAAAAAAAAABgAA3e0AAAAA3QAAAAAA
CgAQAKAAAEAAQ2BEAAAAAAAAAAAQMSARAAAAAAAAABMCEQATAhEAAAARAAAAAAAQYAAAAAAAAAAg
oAEAAAABAAEAACoAAAAAAAAAAAAAAAAAAAAAAEGgFKAAAAAAKgAAAAAAACoAAAAAAAAqAgACAA//
MAAP/zBARDMAAAAAADMAAAAAAAAACQAAAAAACgoAAAAAAAAAAAAAAAAAAAAADQ5AAERERAAAMEQA
AwkAADAAIABwd3AHcHdwF3B3CXB3cAB3BwAAMAkAAABTBQAAAFMFUwAiAEBEBFBVQFBEBFUFCQAA
AAAAAAAAAAANABAAAAAAAAAAAAYAAADd7QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA
ABHxAPEA8QDxAAAgMAAABQBiAiIAAFEBZQUgZlUAZlUADAAwAAAAAAAA8AIAAkBEAzMAAwAAAAAA
AAAAAAAzMwAAAABVRAAAMzMAAAAAAFVEAAAAAABQQM0AALAAVUCFlAB4abu7AFVE3PAAAGBwoAAA
qlAFAKAAUApQEVAiUDNQRAAAAAAABQUAAAAAMAAQIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==`),
r6:bload(`h4eHh4eHmoeHz4eHh4ePh8SHh4f3h8HRgICAgICAh4eHgoKHh4Slh/eHh5SUlJSUlJSHh4f3h4f3
h4eH98aHlYdEhISHh4eVh4eHh4eHh4eVoZSCloKSkpKSkpKSkpKSkpKSkpKSkpKHh4SHlYfGh4eH
h4eHh4f/x4eHh4fHxPfE98T3xPeEhPfGh8SHhYeHh4fE9/eHhIT3h4eHgoKCtcXFxIeHh4eEpoeE
h8CGh4eHh4fFxaHBh5WHh8eHh4eHh5SUh4eHh4eHxYeCh4KChIeHh6GHh4eHkveEnIeHkvf3gI+S
9/f3lJSUlIeS98WHd4eHh4eUxIeShIeSh8aHh5SU90aH98aHgIfEhIeHh8a1xJSHhIT3jIeMh4SH
hYeHh8SUh4eEhISHxfeHxYSHwIeHh4TEhIeHh4eHgoKHtYeCgoSElIeUh6CHh5ScgYGHxofFlJWV
h4eEhIeHhMeEh4eEh4TEh4KCh7WElISElISHh4eCh4eHh5Sch4GBh4eHxZSEh4eEh8eEh4fExIeC
goeHhbWEhJSHlIegh4eTnIGBh8aHxYeUhIeHh6GUj5L3hoSEj5L394ePkvf395SUlJT3xocHh5L3
xof3hoeHh4eUxIeHh4f3h4LFh4SH94eExYCHlJSHh5SH1oeHsJTWgISHsJTFh4SHkofFh5KHgofF
h5KEh4KHgpSHh4eHh4eHgoeHh4CEgveUlMaHB4f3xof3h4eHh4eHh4eHxYeShKGH96WHlIeHh/fE
tYeHh8eHh4eHhPeUh5KHh5L3h5L3gYSUlIeSh4eHh4SEhISBgYWFh4SEkoeHh4eC94eSkpKHh4fC
x5WH94eFgISHh7WkxoeHhIfG9+CEh4SHh4eHh5WHhLfDh8aHtYeUh4eHh7WUh8aHh4extYe1h4SU
h4eElIeHkpSH98aHh4SH98aHh4eHtYeWgoeGtbWHxYeEh4SHhI+Mj4SHh4eHgKGHgpSUlIeH95SH
hLWHkveHh4eHlPehh5T3oYeUhIeUh4fFhICHh4SHh4eFhIeAh4WEoYeUh/eVhIeUh4eFhIWEtYeH
gID/h5L3h5KEh4L3h4eHh4eHgMWHkoCEofeHh8aAh4eHh4eHxoCHh4fGh4eHh8aHh4eHh4eHlYeH
h8TFh8WHxYfFh4KHt4ePtoeFhMT3lIWEsYSHpKSHhISHhIeHxIfE95TEz7WHtYeUhJSHhIeHh8aH
h4eHh4fEhAeFh/eclIeHxISHhHcHj5WUh/fGh4eHxISHgoeCgIGlpYehoYSEh5WVhIKHxP/3h4fG
lIe1h4eHh6CHoIegh6CHoIeHh8aHxcWEh4eH94f/9/fGh4eHh4eHh4eHh4eHh4eHh4eHh4eHhw==`),
r7:bload(`AAEBAwEBgAEBAQEBAQEBAQEBAQEDAwADgICAgICBAAABAQEBAQEBAQEBAYODg4ODg4MBAQGBAQGB
AQMBAAEBAQGDAYMBAQEBAQEAAQEBAQMDgYOBAIOAgICAgICAgICAgICAgICAgIABAYMBAQABAQEB
AAEBAQGBAQEBAQMDgwGDAYMDgwOBgQABAYAAAQEBAQGDgYEBgYMBAQEBAQODAQEBhwMDAQOHAQGH
A4MBAQMDAwMFA4GDAQEBAQEBAQEBAYGBAwEBAQEBAQEDAYODgQEBAYEAAAEAgIGDgwABgAODAQCA
A4MDA4MDgwCAAwEBgQEBAQODgwCAAQCAAAEBAQODAAEBAAEBAQFhQUNBQEFBQUNhQ0FDQUNBQ0FB
U1FRU0FDYUPDQ1NQU1NCQcFSQUFDAUHDwUNDQUFBQ8HDQ0HDQ0FBw0NDYOFBQcNDQ0NAQQFBw0ND
QUHDwUEBw8PBQ0NDQsNBQcHDw0HDw8NBw0FBQEHAYUFBQcPDUVNTUUFBQ8PBQQFBwcPBQ0PDQUFD
wcHDQ0NBQcNDQ0DhQUFDQ0NDQEFBQUHDwUEBAYGDAIAAAYODAIADgwEAgAODAwODA4MAAQEBAIAA
AQEAAQEBAQODgwEBAwMDAYMBAQMBAwGDAQEBA4MBA4MBAQEDAYMBAQEDAYMBAQEAgBARAZABgwAB
AYAAAYMBAYMAAQEBAAEBAwABAQMDAwADgwEBAAEAAQGBAQEAAQEBAAEAEQGQA4EAAwEBAwEAgQGD
AQECAYMBAQMBAwODAIABAIADAIADAwMDgwCAAQABAQcHBwcDAwMDAAUFgAEBAQGDAwCAgIABAAGD
gwEBAQEDAQEAAQODAQEBgwEDAQOBA4MBAQAAAQMDAwODAAEBAwGBAQABAQODAAEBAQEDAQEBAQED
AwEBAwMAgIMBAAEBAYMBAAEBAQEBAQEBgAABAAADAwABAAUBBQEFAYEBAQEBg4EDg4ODgwEAAwMB
gQEAgAMBAwEDgwOBA4MDgQODAQODAwEDgQEBAwEBAQEDgQEBAQOBgQGDAQMDgQODAwMDgQOBASEB
AQGBAICBAIABAYMDAQEBAQEBAQEBgAEDgQABAAABAAABAQEAAQEAAQABAAABAAEBAQGBAQEAAYEB
AYYGAQYBBgEGAQEBAwABAQEDAQMDAQMBgYEDAwMBA4MBAQEDAQEBAwEBAwEBAQODAQMBgQEBAAGB
AQEBAQGDg4EDAQEDg4EBg4MBAQEBAQMDAQABAQEDgwMBgIGDAwMDAwEBAYMDAAMDAwMBAQMDQ0BB
w0NBQWNBQMFAwUDBQMFAwUFAQUFBQUHDQUFBQ0FDQwABAQAAAQAAAQAAAQAAAQAAAQAAAQAAAQ==`),
r8:bload(`AQEBAQEBBgEBBQIBAQEBAQEBhAEBAQEBBgYGBgYGAAEBAQEBBgEQBgGEBgYGBgYGBgYGhAEBhAEB
BgEBAQAGEAaEAREGAQERBgEBBgEBAQEBFowWEQEGBgYGBgYGBg4ODg4GDg6Gho4GAREBEQEAjowG
AQEBAQEBAQEBBgABhAGEAYQBhAGMjAEAjgYBBIQGAwOOAwOOjo4AjgGMAQGMAQEABgEBBgGMEI6M
AY4EBgMDAwMBAZ4GAREBjAEGEI4BjIyEBhCOAYyMAAYBjI6EBoQGhBYAAQYBBgGeBgEBBgEBAQEG
AQEBAVYBVgEGAQCOAQaOAQEGBgEGAQEGAQCOAQFWAQCOAQAOAQ4BAQGMBQIBBQIBEQEBAQEBAQEB
AQEBAQUCAQEVUhEBAQEFAh4FAgEBDgGMDgEBjAGMAR6MAYyMAQEBAQFRAZ4BAQVSAVEBAI4BDhFR
AQGcHowGAYwOAQEBAYwBjB6MjAERAREBUQEBAQEeAQEBAQVSAQFRAQEBAQ4ejAYBAYwOAQGMAYwB
HoyMAQEBAQEBUQGeAQEFUgFRAQCOAY4OHowGhBYOAQ4BEB6eAQ4BAQEBDgEBAQFWAV4BAI6OAQ4B
AI4BEA6OAQEODoyMAQEBjIwABgGEAQEBAQAGAV4BAQ4BAYQBAQ4BAQEBAQ4ABgEBDgEABg6MjAEA
BoYBAQGEAYYBjIyGAYyMAQGMjAFRAQEB1gCGAYwBAI4BhgEBjIYBAYwBAAaGEZYBARCGAQEBjACG
AQYAhoaMhAGEAQGGAYaGAYYBAYYBAVEB1gGGhgGMjAEBAQEBUQFRAQEBhg6MhIyMAQGGhoaEAYaE
hBCGAIQQAwEBhgGWAIaEloQBAAGGAZSGAQABBhADAQOEAQCGAYSGAQEGhAGGAQCGhIYBAYQBhgAB
AYYAAQEBhoYDAQADhpSGAQADhgEDAYQQlgEQAwMBAQEAAwGGAYYBhoYDjISMno4BjIaGhgEBAAAG
hgEBhgOMAYQBhgGeAYYBlgGGAQGGAY4BjgMBAQGMAY4RjgAAjhGOno6OjgERjgGOAQERjhGOAwEB
AQEBAY4BAY4DjIQDjAGOjAGOAwAGjgMRjgOMAQADAAEGAI4BAAMBBgEAAAEGAQADA4QBBoQBEAAG
BgEBAQEBAQEBAQOEAQEBAIwRAQEBAVEBBo4BEVGMEd6MAQYBAYwBAQEBAwEBAQGOAAEDjoyOAQAD
jgEBAwGMlIQAAAEB3gMBjJQFAAABhBFSAwEAjgMBjAGMnoyMAVERUI4RUJ4RARFRAQMBAQEDAQUC
jgEBAQEBAZ4BngGeAZ4BngEBAQCOAwGejgEBAQEBAwEAAwABBgABBgABBgABBgABBgABBgABBg==`),
tsm:bload(`pRn/l/8T/xP///////////8TgDH/lxMe/xv/khn/HP+18LD//6dkLv8r/6Ip/yz//zSg/zq3wbb/
Oz2yOSY8//9xw8X/xnb//////////////////////////////////////xb//////////////7Vy
c3X/wnd5/3D//////7Wlgf+X/4X/Ef///////////5OAsf+Xkx7/G/+SGf8c/7X/sP//p+Qu/yv/
oin/LP+VtKD/urfBtv87vbI5pjz//3HDxf/Gdv//////////////////////////////////////
lv//////////////tXJzdf/Cd3n/cP//////tQ==`),
mfm:bload(`ICABAQAAAQEgIAEBAAABASAIAQIAAAQBECABAgAABAE=`)
};

const mclisting:MicroListing[] = [];

interface DiskImage {
	type: 'empty'|'hawk'|'finch',
	filename: string,
	identifier?: string,
	stride: number,
	backing_data: ArrayBuffer,
	protect: boolean,
	data: Uint8Array,
}
function disk_image_luid(image: DiskImage) {
	if(image.identifier) {
		return `${image.identifier}:${image.filename}`;
	}
	return image.filename;
}
const FINCH_TRACK = 13440;
const FINCH_TPP = 605;
const FINCH_PLAT = FINCH_TRACK * FINCH_TPP;
const disk_images_lu:{[id:string]:number} = {};
const disk_images:DiskImage[] = [];
let disk_view:DiskViewer;
let disk_view_update = false;

function export_disk(image:DiskImage) {
	const unitdata = image;
	if(unitdata == null) return;
	const link = document.createElement('a');
	let filename = unitdata.filename;
	let ext_at = unitdata.filename.lastIndexOf('.');
	if(ext_at > -1) filename = filename.substring(0, ext_at);
	const reg = /(_EX)([0-9]+)(?:\.\w*)?$/i;
	if(filename.match(reg) != null) {
		filename = filename.replace(reg, function(v, x, n){ return `${x}${(parseInt(n)+1).toString().padStart(3,'0')}` });
	} else {
		filename += '_EX000';
	}
	filename += (unitdata.stride == FINCH_TRACK) ? '.FFI' : '.IMG';
	const ex_blob = new Blob([unitdata.backing_data], {type:'application/octet-stream'});
	link.download = filename;
	const url = URL.createObjectURL(ex_blob);
	link.href = url;
	down_div.appendChild(link);
	link.click();
	setTimeout(function() {
		down_div.removeChild(link);
		URL.revokeObjectURL(url);
	}, 0);
}

let wa:{
	context: AudioContext,
	filter: BiquadFilterNode,
	gain: GainNode,
	osc: OscillatorNode,
} | undefined;
function wa_setup() {
	const context = new AudioContext();
	const filter = new BiquadFilterNode(context, {type: 'bandpass', frequency: 8192, Q: 1});
	const gain = new GainNode(context, {gain: 0.0});
	filter.connect(gain);
	gain.connect(context.destination);
	let wa_osc = new OscillatorNode(context, {frequency: 3200, type: 'square'});
	wa_osc.connect(filter);
	wa_osc.start();
	return {context, filter, gain, osc: wa_osc};
}
function wa_do_beep() {
	if(wa == undefined) return;
	let ctime = wa.context.currentTime;
	wa.gain.gain.setTargetAtTime(0.0625, ctime + 0.125, 0.01);
	wa.gain.gain.setTargetAtTime(0.0, ctime + 0.825, 0.01);
}
check_sound.addEventListener('change', function() {
	CONFIG.sound = check_sound.checked;
	if(check_sound.checked) {
		if(wa == undefined) wa = wa_setup();
		wa_do_beep();
	}
});

const vt_width = 8;
const vt_height = 10;
const vt_font_data = new ImageData(512, 512);
const vtx_quad = [0,0,0,0, 0,1,0,1, 1,0,1,0, 1,1,1,1];
const vtx_quadidx = [0,1,2,2,1,3];
let vt_font_bmp: ImageBitmap | undefined;
let vt_use_gl = true;
let vt_use_offscreen = true;
if ((window.WebGLRenderingContext == undefined) || localStorage.getItem('nogl') != null) {
	vt_use_gl = false;
}
if ((window.OffscreenCanvas == undefined) || localStorage.getItem('nooffscreen') != null) {
	vt_use_offscreen = false;
}
let vt_force_redraw = false;
let vt_font_canv: OffscreenCanvas | HTMLCanvasElement;
let vt_font_ctx: OffscreenCanvasRenderingContext2D | CanvasRenderingContext2D;
if (vt_use_offscreen) {
	vt_use_offscreen = true;
	vt_font_canv = new OffscreenCanvas(512, 512)
	vt_font_ctx = vt_font_canv.getContext('2d') as OffscreenCanvasRenderingContext2D
} else {
	vt_use_offscreen = false;
	vt_font_canv = document.createElement('canvas');
	vt_font_canv.width = 512;
	vt_font_canv.height = 512;
	vt_font_ctx = vt_font_canv.getContext('2d', { willReadFrequently:true }) as CanvasRenderingContext2D;
}
function get_vt_style_color(col: [number,number], bg = false):string {
	const r = col[bg?1:0] & 255;
	const g = (col[bg?1:0] >> 8) & 255;
	const b = (col[bg?1:0] >> 16) & 255;
	return `#${hex(r)}${hex(g)}${hex(b)}`;
}
function update_font_data(main_colors:[number, number]) {
	const vtf = new Uint32Array(vt_font_data.data.buffer);
	let vrow = 0;
	let vcrow = 0;
	let vcid = 0;
	const aa_alpha = 0.1875;
	function mix_alpha(a:number, b:number, s:number, alpha:number):number {
		const ca = (a >> s) & 255;
		const cb = (b >> s) & 255;
		const m = (ca * alpha) + (cb * (1 - alpha));
		return (m & 255) << s;
	}
	const fore_color = 0xff000000 | main_colors[0];
	const back_color = 0xff000000 | main_colors[1];
	const half_color = 0xff000000 |
		mix_alpha(fore_color, back_color, 16, 0.5) |
		mix_alpha(fore_color, back_color, 8, 0.5) |
		mix_alpha(fore_color, back_color, 0, 0.5);
	const main_aa = 0xff000000 |
		mix_alpha(fore_color, back_color, 16, aa_alpha) |
		mix_alpha(fore_color, back_color, 8, aa_alpha) |
		mix_alpha(fore_color, back_color, 0, aa_alpha);
	const rev_aa = 0xff000000 |
		mix_alpha(fore_color, back_color, 16, 1-aa_alpha) |
		mix_alpha(fore_color, back_color, 8, 1-aa_alpha) |
		mix_alpha(fore_color, back_color, 0, 1-aa_alpha);
	for(let y = 0; y < 160; y++) {
		const line0 = y * 512;
		const line0h = y * 512 + 256;
		const line0uf = 81920 + y * 512;
		const line0uh = 81920 + y * 512 + 256;
		const vtf_char = vcid * 8;
		const vtline_up = (vtf_char + vcrow - 1) * 16;
		const vtline_dn = (vtf_char + vcrow + 1) * 16;
		const vtline = (vtf_char + vcrow) * 16;
		if((vrow > 0 && vrow < 9) || vcid >= 8) {for(let x = 0; x < 256; x++) {
			const cx = (x & 7);
			const cellx = (x >> 3) & 15;
			const v = (vtfont[vtline + cellx] >> cx) & 1;
			if ((v > 0 && x < 128) || (v == 0 && x >= 128)) {
				vtf[line0 + x] = fore_color;
				vtf[line0h + x] = half_color;
				vtf[line0uf + x] = fore_color;
				vtf[line0uh + x] = half_color;
			} else {
				const vnu = vcrow < 1 ? 0 : vtfont[vtline_up + cellx] >> cx;
				const vnd = vcrow > 6 ? 0 : vtfont[vtline_dn + cellx] >> cx;
				const vn = (vnu | vnd) & 1;
				if (vn > 0 && x < 128) {
					let vlr = 0;
					if(cx > 0) vlr |= (vtfont[vtline + cellx] >> (cx - 1)) & 1;
					if (cx < 7) vlr |= (vtfont[vtline + cellx] >> (cx + 1)) & 1;
					if (false&& vlr > 0) {
						vtf[line0 + x] = main_aa;
						vtf[line0h + x] = main_aa;
						vtf[line0uf + x] = main_aa;
						vtf[line0uh + x] = main_aa;
					} else {
						vtf[line0 + x] = back_color;
						vtf[line0h + x] = back_color;
						vtf[line0uf + x] = back_color;
						vtf[line0uh + x] = back_color;
					}
				} else {
					vtf[line0 + x] = back_color;
					vtf[line0h + x] = back_color;
					vtf[line0uf + x] = back_color;
					vtf[line0uh + x] = back_color;
				}
			}
		}} else if(vrow == 0) {
			for(let x = 0; x < 128; x++) {
				vtf[line0 + x] = back_color;
				vtf[line0h + x] = back_color;
				vtf[line0uf + x] = back_color;
				vtf[line0uh + x] = back_color;
			}
			for(let x = 128; x < 256; x++) {
				vtf[line0 + x] = fore_color;
				vtf[line0h + x] = half_color;
				vtf[line0uf + x] = fore_color;
				vtf[line0uh + x] = half_color;
			}
		} else if(vrow == 9) {
			for(let x = 0; x < 128; x++) {
				vtf[line0uf + x] = fore_color;
				vtf[line0uh + x] = half_color;
				vtf[line0 + x] = back_color;
				vtf[line0h + x] = back_color;
			}
			for(let x = 128; x < 256; x++) {
				vtf[line0uf + x] = back_color;
				vtf[line0uh + x] = back_color;
				vtf[line0 + x] = fore_color;
				vtf[line0h + x] = half_color;
			}
		}
		if(vrow > 0 && vcrow < 7) vcrow++;
		if(++vrow >= 10) {
			vrow = 0;
			vcrow = 0;
			vcid++;
		}
	}
	for(let y = 0; y < 10; y++) {
		const block0 = (150 + y) * 512 + 112;
		const block0i = (150 + y) * 512 + 112 + 128;
		const block0h = (150 + y) * 512 + 112 + 256;
		const block0hi = (150 + y) * 512 + 112 + 384;
		const block1 = (310 + y) * 512 + 112;
		const block1i = (310 + y) * 512 + 112 + 128;
		const block1h = (310 + y) * 512 + 112 + 256;
		const block1hi = (310 + y) * 512 + 112 + 384;
		for(let x = 0; x < 16; x++) {
			vtf[block0 + x] = back_color & 0xffffff;
			vtf[block0i + x] = fore_color & 0xffffff;
			vtf[block0h + x] = back_color & 0xffffff;
			vtf[block0hi + x] = half_color & 0xffffff;
			vtf[block1 + x] = back_color & 0xffffff;
			vtf[block1i + x] = fore_color & 0xffffff;
			vtf[block1h + x] = back_color & 0xffffff;
			vtf[block1hi + x] = half_color & 0xffffff;
		}
		if(y >= 8) {
			for(let x = 8; x < 16; x++) {
				vtf[block0 + x] = fore_color;
				vtf[block0i + x] = back_color;
				vtf[block0h + x] = half_color;
				vtf[block0hi + x] = back_color;
				vtf[block1 + x] = fore_color;
				vtf[block1i + x] = back_color;
				vtf[block1h + x] = half_color;
				vtf[block1hi + x] = back_color;
			}
		}
	}
	vt_font_ctx.putImageData(vt_font_data, 0, 0);
	if(vt_font_bmp != null) {
		vt_font_bmp.close();
		vt_font_bmp = undefined;
	}
	createImageBitmap(vt_font_canv).then(function(v) {
		vt_font_bmp = v;
		vt_force_redraw = true;
	});
}

let font_load = (async function() {
	await new Promise((res) => { setTimeout(res, 10); });
	update_font_data(CONFIG.vt_colors);
})();

interface GLVars {
	ctx: WebGLRenderingContext,
	v: WebGLShader,
	f: WebGLShader,
	p: WebGLProgram,
	fd: Uint8Array,
	fi: Uint16Array,
	vb: WebGLBuffer,
	ib: WebGLBuffer,
	tx: WebGLTexture,
	tx_loaded: boolean,
	vb_update: boolean,
	vb_min: number,
	vb_max: number,
}

function compile_gl(c:WebGLRenderingContext, flavor:number, src:string) {
	let s = c.createShader(flavor);
	if(s == null) throw new Error('ctx error 2');
	c.shaderSource(s, src);
	c.compileShader(s);
	let status = c.getShaderParameter(s, c.COMPILE_STATUS);
	if(!status) {
		let l = c.getShaderInfoLog(s);
		c.deleteShader(s);
		if(l != null) console.error('shader:', l);
		throw new Error('shader error');
	}
	return s;
}

function init_gl(canv:HTMLCanvasElement):GLVars|undefined {
	const gl = canv.getContext('webgl', {antialias: false});
	if(gl == null) {
		console.warn('webgl is null');
		return undefined;
	}
	const p = gl.createProgram();
	if(p == null) throw new Error('ctx error 3');
	let v = compile_gl(gl, gl.VERTEX_SHADER,
		`attribute vec2 p;\nattribute vec2 c;\nvarying vec2 t;\nuniform vec2 scn;\nvoid main() { t=c*vec2(0.015625,0.01953125)+vec2(0,-1); gl_Position=vec4(p.xy*scn+vec2(-1,1),0.0,1.0); }`);
	let f = compile_gl(gl, gl.FRAGMENT_SHADER,
		`precision mediump float;\nuniform sampler2D tx;\nvarying vec2 t;\nvoid main() { gl_FragColor = texture2D(tx, t); }`);
	gl.attachShader(p, v);
	gl.attachShader(p, f);
	gl.linkProgram(p);
	gl.validateProgram(p);
	let status = gl.getProgramParameter(p, gl.LINK_STATUS);
	if(!status) {
		let l = gl.getProgramInfoLog(p);
		console.error(l);
	}
	gl.useProgram(p);
	gl.uniform2f(gl.getUniformLocation(p, 'scn'), 2/80, -2/25);
	gl.uniform1i(gl.getUniformLocation(p, 'tx'), 0);
	let vb = gl.createBuffer();
	let ib = gl.createBuffer();
	if(vb == null || ib == null) throw new Error('ctx error 4');
	const quad_count = 80 * 25 + 1;
	const vb_size = quad_count * 4*4;
	const ib_size = quad_count * 6;
	const fd = new Uint8Array(vb_size);
	const sample = [0,0,15,15];
	for(let i = 0; i < 16; i++) {
		fd[80*25*16+i] = sample[i & 3] + vtx_quad[i];
	}
	for(let y = 0; y < 25; y++) {
		for(let x = 0; x < 80; x++) {
			const q = y*80 + x;
			sample[0] = x;
			sample[1] = y;
			sample[2] = q & 0x0f;
			sample[3] = (q >> 4) & 0xf;
			const dest = q * 16;
			for(let i = 0; i < 16; i++) {
				fd[dest+i] = sample[i & 3] + vtx_quad[i];
			}
		}
	}
	const fi = new Uint16Array(ib_size);
	for(let q = 0; q < quad_count; q++) {
		for(let i = 0; i < 6; i++) {
			fi[q*6+i] = q*4 + vtx_quadidx[i];
		}
	}
	gl.bindBuffer(gl.ARRAY_BUFFER, vb);
	gl.bufferData(gl.ARRAY_BUFFER, fd, gl.DYNAMIC_DRAW);
	let atr = gl.getAttribLocation(p, 'p');
	gl.enableVertexAttribArray(atr);
	gl.vertexAttribPointer(atr, 2, gl.UNSIGNED_BYTE, false, 4, 0);
	atr = gl.getAttribLocation(p, 'c');
	gl.enableVertexAttribArray(atr);
	gl.vertexAttribPointer(atr, 2, gl.UNSIGNED_BYTE, false, 4, 2);
	gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ib);
	gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, fi, gl.DYNAMIC_DRAW);
	gl.disable(gl.DEPTH_TEST);
	gl.disable(gl.STENCIL_TEST);
	gl.enable(gl.BLEND);
	gl.blendFunc(gl.SRC_ALPHA, gl.ONE_MINUS_SRC_ALPHA);
	let tx = gl.createTexture();
	if(tx == null) throw new Error('ctx error 5');
	gl.activeTexture(gl.TEXTURE0);
	gl.bindTexture(gl.TEXTURE_2D, tx);
	gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, gl.NEAREST);
	gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MAG_FILTER, gl.NEAREST);
	gl.texImage2D(gl.TEXTURE_2D, 0, gl.RGBA, gl.RGBA, gl.UNSIGNED_BYTE, vt_font_canv);
	if(gl.getError() != gl.NO_ERROR) {
		console.warn('GL errors exist');
	}
	return {
		ctx: gl, tx_loaded: false,
		vb_update: false, vb_max: 0, vb_min: 0,
		f, v, fd, fi, ib, p, tx, vb
	};
}

interface CharDevice {
	emu_linked?:boolean;
	receive(c:number):void; // data into this device
	can_receive():boolean; // VT cheat
	check_send():void; // send budget (VT cheats)
	get_dev():CharDevice | undefined; // get current remote device
	bind_dev(dev:CharDevice | undefined):void; // the line (dis)connected
	set_cts(value:boolean):void; // our rts line changed their cts
	rts:boolean; // allow getting rts state
}
type KeySeq = number | number[];
type KeyShift = KeySeq | {n:KeySeq, s:KeySeq};
const vtctrlkeys:{[id:string]:KeyShift} = {
	Digit2: 0, KeyA: 1, KeyB: 2, KeyC: 3,
	KeyD: 4, KeyE: 5, KeyF: 6, KeyG: 7,
	KeyH: 8, KeyI: 9, KeyJ:10, KeyK:11,
	KeyL:12, KeyM:13, KeyN:14, KeyO:15,
	KeyP:16, KeyQ:17, KeyR:18, KeyS:19,
	KeyT:20, KeyU:21, KeyV:22, KeyW:23,
	KeyX:24, KeyY:25, KeyZ:26, BracketLeft: 27,
	Backslash: 28, BracketRight: 29, Digit6: 30, Minus: 31,
	Delete: [27,76], Insert: [27,77],
	End: {n:12, s:[27,71]},
};
const vtkeys:{[id:string]:KeyShift} = {
	End: {n:[27,75], s:[27,107]},
	Delete: {n:[27,69], s:[27,101]},
	Insert: {n:[27,70], s:[27,102]},
	Tab: {n:9, s:[27,79]},
	Home: 1, Backspace: 8, Enter: 13, NumpadEnter: 13, Escape: 27,
	ArrowUp: 26, ArrowDown: 10, ArrowLeft: 21, ArrowRight: 6,
	F1: {n:[2,49,13], s:[2,33,13]}, F2:{n:[2,50,13], s:[2,34,13]},
	F3: {n:[2,51,13], s:[2,35,13]}, F4:{n:[2,52,13], s:[2,36,13]},
	F5: {n:[2,53,13], s:[2,37,13]}, F6:{n:[2,54,13], s:[2,38,13]},
	F7: {n:[2,55,13], s:[2,39,13]}, F8:{n:[2,56,13], s:[2,40,13]},
};

const fn_key_norm = ['1','2','3','4','5','6','7','8'];
const fn_key_shift = ['!','"','#','$','%','&',"'",'('];
const enum VTEscapeModes {
	NORMAL = 0,
	ESC = 1,
	SEL_ROW = 2,
	SEL_COL = 3,
	VTAB = 4,
	VATTR = 5,
	HADDR = 6,
}
const enum VTEditCode {
	NONE,
	INS_CHAR_LINE,
	INS_CHAR_SCREEN,
}
class VTerm implements CharDevice {
	buffer = new Uint16Array(80*25);
	blink = false;
	blink_count = 0;
	char_blink = false;
	cursor_x = 0;
	cursor_y = 0;
	char_attr = 0;
	char_edit:VTEditCode = VTEditCode.NONE;
	line_draw = false;
	shift_aware = false;
	local_mode = false;
	rts = true;
	lok:HTMLInputElement;
	vctrl:HTMLButtonElement;
	canv:HTMLCanvasElement;
	ctx:CanvasRenderingContext2D| undefined;
	glc:WebGLRenderingContext | undefined;
	glv:GLVars | undefined;
	octx:OffscreenCanvasRenderingContext2D | CanvasRenderingContext2D | undefined;
	vbell?:HTMLElement;
	static columns = 80;
	static columnr = 79;
	static rows = 24;
	static rowb = 23;
	static vt_limit = VTerm.columns * VTerm.rows;
	static char_base = 0;
	static input_interval_rate = 20000;
	input_interval = 0;
	input_buf:number[] = [];
	import_buf:number[] = [];
	status_code:number[] = [];
	clear_status = true;
	input_control = false;
	carrier = false;
	mux:CharDevice | undefined;
	show_ctrl = false;
	esc_mode:VTEscapeModes = VTEscapeModes.NORMAL;
	esc_extra = 0;
	vbel_id = 0;
	vcontrol = false;
	ident:string;
	vt_ofs_canv: OffscreenCanvas | undefined;
	constructor(ident:string, container:HTMLDivElement) {
		const div_crt = container.children[0] as HTMLDivElement;
		const canv = container.children[1] as HTMLCanvasElement;
		if(canv.tagName != 'CANVAS') throw new Error(`invalid HTML for VTerm:${ident}`);
		const vctrl = div_crt.children[0] as HTMLButtonElement;
		this.vctrl = vctrl;
		this.vbell = div_crt.children[1] as HTMLSpanElement;
		const lok = (div_crt.children[2] as HTMLLabelElement).children[0] as HTMLInputElement;
		this.lok = lok;
		let fnkeys = [
		div_crt.children[3] as HTMLButtonElement,
		div_crt.children[4] as HTMLButtonElement,
		div_crt.children[5] as HTMLButtonElement,
		div_crt.children[6] as HTMLButtonElement,
		div_crt.children[7] as HTMLButtonElement,
		div_crt.children[8] as HTMLButtonElement,
		div_crt.children[9] as HTMLButtonElement,
		div_crt.children[10] as HTMLButtonElement];

		const self = this;
		this.ident = ident.padEnd(4).substring(0, 4);
		this.canv = canv;
		let glv:GLVars | undefined;
		if(vt_use_gl) {
			try {
				glv = init_gl(canv);
			} catch(exerr) { console.log(exerr); }
		}
		if(glv) {
			this.glv = glv;
		} else {
			const ctx = canv.getContext('2d') as CanvasRenderingContext2D;
			this.ctx = ctx;
			if(!vt_use_offscreen || window.OffscreenCanvas == undefined) {
				this.octx = ctx;
			} else {
				this.vt_ofs_canv = new OffscreenCanvas(640, 250);
				this.octx = this.vt_ofs_canv.getContext('2d', { willReadFrequently:true }) as OffscreenCanvasRenderingContext2D;
			}
			ctx.fillStyle = '#6ac';
			ctx.strokeStyle = '#6ac';
		}
		//@ts-ignore
		const sver = `v0.${window.cen_ts_version}`.padStart(6);
		const s1 = `   Centurion VI Simulator ${sver}   `;
		const s2 = ` Copyright (c) 2023 Meisaka Yukara `;
		const len = s2.length;
		let i = 40 - ((len / 2)|0);
		let k = 80 * 5;
		this.buffer[k+i] = 128;
		this.buffer[k+80+i] = 164;
		this.buffer[k+160+i] = 164;
		this.buffer[k+240+i] = 136; i++;
		for(let c = 0; c < len; c++) {
			this.buffer[k+i] = 160;
			this.buffer[k+80+i] = s1.charCodeAt(c);
			this.buffer[k+160+i] = s2.charCodeAt(c);
			this.buffer[k+240+i] = 160;
			i++;
		}
		this.buffer[k+i] = 132;
		this.buffer[k+80+i] = 164;
		this.buffer[k+160+i] = 164;
		this.buffer[k+240+i] = 140;
		//          |Mode  | SHIFT | LOCAL | AUX ~~~~~~~~~ |TEST: TERMINAL STATUS MESSAGE\r |CARRIER| SendRcv|
		const s3 = `.CONV  .|||||||||||||||| ${this.ident} .PASS:|s112312XYCR|R200 VT Emu\r|.       .        .`;
		for(let c = 0; c < s3.length; c++) {
			let n = s3.charCodeAt(c) | 0x100;
			if(n == 0x17C) n = 0x100;
			if(n == 0x12e) n = 0x1100;
			this.buffer[VTerm.vt_limit + c] = n;
		}
		this.make_status();
		for(let x = 0; x < this.status_code.length; x++) {
			let n = this.status_code[x] | 0x100;
			this.buffer[VTerm.vt_limit + 37 + x] = n;
		}
		this.cursor_y = 0;
		this.cursor_x = 0;
		canv.addEventListener('keypress', function(ev) {
			ev.preventDefault();
		});
		if(vctrl) vctrl.addEventListener('click', function(ev) {
			self.vcontrol = !self.vcontrol;
			style_if(this, 'active', self.vcontrol);
			canv.focus();
		});
		canv.addEventListener('keydown', function(ev) {
			if(self.key_input(ev))
				ev.preventDefault();
		});
		canv.addEventListener('keyup', function(ev) {
			ev.preventDefault();
		});
		if(fnkeys) for(let i = 0; i < fnkeys.length && i < 8; i++) {
			const norm = fn_key_norm[i];
			const shift = fn_key_shift[i];
			fnkeys[i].addEventListener('click', function(ev) {
				if(ev.shiftKey) self.send_fn(shift);
				else self.send_fn(norm);
				self.vcontrol = false;
				if(vctrl) vctrl.classList.remove('active');
			});
		}
		font_load.then(() => {
			this.update_screen();
			this.present_screen();
		});
	}
	key_input(ev:KeyboardEvent): boolean {
		this.clear_buffer();
		if (ev.key == 'PageDown') {
			this.canv.blur();
			return true;
		}
		if (ev.key == 'PageUp') {
			this.local_mode = !this.local_mode;
			this.update_statusline();
			this.present_screen();
			return true;
		}
		let vcc: KeyShift | undefined;
		if (ev.ctrlKey || this.vcontrol) {
			vcc = vtctrlkeys[ev.code];
			if (vcc !== undefined) {
				this.input_control = true;
			}
			this.vcontrol = false;
			if(this.vctrl) this.vctrl.classList.remove('active');
		} else if (ev.key.length == 1) {
			if (this.lok && this.lok.checked) {
				vcc = ev.key.toUpperCase().charCodeAt(0);
			} else {
				vcc = ev.key.charCodeAt(0);
			}
		} else {
			vcc = vtkeys[ev.code];
		}
		if (vcc == undefined) return false;
		if (typeof vcc == 'object' && !Array.isArray(vcc)) {
			vcc = ev.shiftKey ? vcc.s : vcc.n;
		}
		if (Array.isArray(vcc)) {
			for(let n = 0; n < vcc.length; n++) this.send(vcc[n]);
			this.check_send();
		} else if(typeof vcc == 'number') {
			this.send(vcc);
			this.check_send();
		}
		return true;
	}
	run(increment:number):void {
		if(this.import_buf.length > 0) {
			this.input_interval -= increment;
			if(this.input_interval < 1) {
				this.check_send();
			}
		}
	}
	private render_screen_gl() {
		if(this.glv == null) return;
		const gl = this.glv.ctx;
		gl.viewport(0, 0, this.canv.width, this.canv.height);
		let flr = this.blink ? 0.125 : 0.1875;
		gl.clearColor(flr, 0.0, 0.0, 0);
		if(vt_force_redraw) this.glv.tx_loaded = false;
		if(!this.glv.tx_loaded && vt_font_bmp) {
			gl.texImage2D(gl.TEXTURE_2D, 0, gl.RGBA, gl.RGBA, gl.UNSIGNED_BYTE, vt_font_bmp);
			this.glv.tx_loaded = true;
		}
		if(this.glv.vb_update) {
			let fd = this.glv.fd;
			let vcc = this.buffer[this.cursor_y * VTerm.columns + this.cursor_x];
			const ivr = CONFIG.vt_reverse ? 16 : 0;
			const rev = ((vcc & 0x1000) != 0 ? 16 : 0) ^ ivr;
			for(let i = 0; i < 16; i+=4) {
				fd[32000+i] = this.cursor_x + vtx_quad[i];
				fd[32001+i] = this.cursor_y + vtx_quad[i+1];
				fd[32002+i] = (this.blink ? 14:15) + rev + vtx_quad[i+2];
				fd[32003+i] = 15 + vtx_quad[i+3];
			}
			//gl.bufferSubData(gl.ARRAY_BUFFER, this.glv.vb_min * 16, this.glv.fd);
			gl.bufferData(gl.ARRAY_BUFFER, this.glv.fd, gl.DYNAMIC_DRAW);
			this.glv.vb_update = false;
		}
		//gl.clear(gl.COLOR_BUFFER_BIT);
		gl.useProgram(this.glv.p as WebGLProgram);
		// offset sizeof(u16)*elemperquad*quad [2*6*quad]
		gl.drawElements(gl.TRIANGLES, 25*80*6+6, gl.UNSIGNED_SHORT, 0);
		//gl.finish();
		// let er = gl.getError();
		// if(er != gl.NO_ERROR) console.warn('GL draw error:', er);
	}
	present_screen() {
		if(this.ctx && this.vt_ofs_canv)
			this.ctx.drawImage(this.vt_ofs_canv, 0, 0);
		else this.render_screen_gl();
	}
	update_screen() {
		if(this.octx)
			this.octx.clearRect(0, 0, this.canv.width, this.canv.height);
		for(let row = 0; row < VTerm.rows + 1; row++) { // updates the status line
			const vcy = row * vt_height;
			const vcra = row * VTerm.columns;
			let vcx = 0;
			for(let col = 0; col < VTerm.columns; col++) {
				this.render_cell(vcra + col, col, row, vcx, vcy);
				vcx += vt_width;
			}
		}
	}
	update_dirty() {
		//this.octx.clearRect(0, 0, this.canv.width, this.canv.height);
		for(let row = 0; row < VTerm.rows + 1; row++) { // updates the status line
			const vcy = row * vt_height;
			const vcra = row * VTerm.columns;
			let vcx = 0;
			for(let col = 0; col < VTerm.columns; col++) {
				const vca = vcra + col
				if((this.buffer[vca] & 0x8000) == 0)
					this.render_cell(vca, col, row, vcx, vcy);
				vcx += vt_width;
			}
		}
	}
	private check_cell(cellx:number, celly:number) {
		const vcx = cellx * vt_width;
		const vcy = celly * vt_height;
		const vca = celly * VTerm.columns + cellx;
		if((this.buffer[vca] & 0x8000) == 0)
			this.render_cell(vca, cellx, celly, vcx, vcy);
	}
	private update_cell(cellx:number, celly:number) {
		const vcx = cellx * vt_width;
		const vcy = celly * vt_height;
		this.render_cell(celly * VTerm.columns + cellx, cellx, celly, vcx, vcy);
	}
	private render_cell(vca:number, col:number, row:number, dx:number, dy:number) {
		let vcc = this.buffer[vca];
		if(vt_font_bmp == null) return; // unable to draw yet
		this.buffer[vca] = vcc | 0x8000;
		if((vcc & 0x400) != 0) vcc = 0x20;
		if((vcc & 0x200) != 0 && !this.char_blink) vcc = (vcc & 0x7f00) | 32;
		// attrib bits: . . U R . Z B H
		const ivs = vca >= VTerm.vt_limit ? 16 : 0;
		const ivr = CONFIG.vt_reverse ? 16 : 0;
		const rev = ((vcc & 0x1000) != 0 ? 16 : 0) ^ ivs ^ ivr;
		const half = (vcc & 0x100) >> 3;
		const vtfx = (vcc & 15) | rev | half;
		if(this.glv) {
			const fd = this.glv.fd;
			const dest = vca * 16;
			const under = (vcc & 0x2000) != 0 ? 16 : 0;
			const vtfy = ((vcc >> 4) & 15) + under;
			for(let i = 0; i < 16; i+=4) {
				fd[dest+i] = col + vtx_quad[i];
				fd[dest+i+1] = row + vtx_quad[i+1];
				fd[dest+i+2] = vtfx + vtx_quad[i+2];
				fd[dest+i+3] = vtfy + vtx_quad[i+3];
			}
			if(this.glv.vb_update) {
				if(vca < this.glv.vb_min)
					this.glv.vb_min = vca;
				if(vca > this.glv.vb_max)
					this.glv.vb_max = vca;
			} else {
				this.glv.vb_min = vca;
				this.glv.vb_max = vca;
				this.glv.vb_update = true;
			}
		} else if(this.octx) {
			const under = (vcc & 0x2000) != 0 ? 160 : 0;
			const vtfy = ((vcc >> 4) & 15) * 10 + under;
			this.octx.drawImage(vt_font_bmp, vtfx*8, vtfy, 8, 10, dx, dy, 8, 10);
			// cursor:
			if(this.blink && col == this.cursor_x && row == this.cursor_y) {
				this.octx.fillStyle = get_vt_style_color(CONFIG.vt_colors, rev != 0);
				this.octx.fillRect(dx, dy + 8, vt_width, 2);
			}
		}
	}
	// reset the cell if it's content is different
	private set_cell(vca:number, cellval:number) {
		cellval &= 0x7fff;
		if((this.buffer[vca] & 0x7fff) != cellval)
			this.buffer[vca] = cellval;
	}
	// change the cursor position and update visually
	private set_cursor(col:number, row:number) {
		if(col == this.cursor_x && row == this.cursor_y) return;
		const lastx = this.cursor_x;
		const lasty = this.cursor_y;
		this.cursor_x = col;
		this.cursor_y = row;
		if(this.glv) {
			this.check_cell(lastx, lasty);
			this.glv.vb_update = true;
		} else {
			this.update_cell(lastx, lasty);
			this.update_cell(this.cursor_x, this.cursor_y);
		}
	}
	update_blink() {
		this.blink = !this.blink;
		this.update_statusline();
		let do_screen_update = false;
		if(this.blink_count++ > 3) {
			this.char_blink = !this.char_blink;
			this.blink_count = 0;
			do_screen_update = true;
		}
		if (vt_force_redraw) {
			this.update_screen();
			this.present_screen();
			return;
		}
		if (do_screen_update) {
			for(let row = 0; row < VTerm.rows + 1; row++) { // updates the status line
				for(let col = 0; col < VTerm.columns; col++) {
					const vca = row * VTerm.columns + col;
					let vcc = this.buffer[vca];
					if((vcc & 0x200) != 0)
						this.buffer[vca] = vcc & 0x7fff;
				}
			}
			this.update_dirty();
		}
		this.update_cell(this.cursor_x, this.cursor_y);
		//this.update_statusline();
		this.present_screen();
	}
	chardec(c:number):number {
		if ((c < 32) || (c > 127)) return 0;
		return c - 32;
	}
	baud_status():string {
		return 'DIRECT 7E1';
	}
	make_status() {
		// a1=1 full duplex
		// a2=0 no echo
		// a3,4=1,1 even parity
		// 3,4=...  11 Even, 01 odd, 10 space, 00 mark
		// a5..8=0101 9600
		// baud 5678 switches
		// 4800 0001 : 7200 1001 : 9600 0101
		//  600 0010 : 1200 1010 : 1800 0110 : 2400 1110
		//   75 0000 :  110 1000 :  150 0100 :  300 1100
		// b1,2=0,0 CR
		// -> 01 CR ETX, 10, CR EOT, 00 CR, 11 invalid
		// b3=0 no auto LF
		// b4=1 auto scroll
		// b5=0 rs232
		// b6= (1=white on black,0=black on white) not reverse style
		// b7,8=1,0 lower with upper shift
		// 11 upper only, 10 low shift up, 00 up shift low
		// mode1 [1 loc diag auxon auxrdy grph keylock]
		// sw1 baud status [1 br3..0 p1,0]: 1 10 1011 =6B
		// sw2 status: 1 10 0000 =60
		// STX, mode1, sw1, sw2, sw3, err1, err2
		// cur x, cur y, cur data, CR [, EOT/ETX (if enabled)]

		// a fail status line: STX "PEWib@  " NUL CR
		// 02 50 45 57 69 62 40 20 20 00 0D
		// mode1 [50]: diag check on
		// sw1 [45]: 4800 odd or 110 space (not sure how to read these)
		// sw2 [57]: AutoLF, 60Hz, invalid termination setting
		// sw3 [69]: invalid shift/case setting, Parity channel enable, LineMode
		// err1 [62]: error check, loop check
		// err2 [40] not used
		// 20 20 cursor at top left, col 1, row 1, on a NUL char
		const s = this.status_code;
		s[0] = 2;
		s[1] = 0x50;
		s[2] = 0x6B;
		s[3] = 0x64;
		s[4] = 0x58;
		s[5] = 0x40;
		s[6] = 0x40;
		s[7] = this.cursor_x + 0x20;
		s[8] = this.cursor_y + 0x20;
		s[9] = this.buffer[this.cursor_x + this.cursor_y * VTerm.columns] & 0x7f;
		s[10] = 13;
	}
	set_status_message(msg:string):void {
		// TODO in the message field on the status line
		const stxt = msg.substring(0, 23);
		let x = 0;
		if(this.clear_status) {
			this.clear_status = false;
			for(; x < 7; x++) {
				this.set_cell(VTerm.vt_limit + 30 + x, 0x100);
			}
		}
		for(x = 0; x < stxt.length; x++) {
			let n = stxt.charCodeAt(x) | 0x100;
			this.set_cell(VTerm.vt_limit + 37 + x, n);
		}
		for(; x < 23; x++) {
			this.set_cell(VTerm.vt_limit + 37 + x, 0x100);
		}
		this.set_cell(VTerm.vt_limit + 62, 0x100);
	}
	update_statusline() {
		// updates the status line
		let shift = caps_lock || this.lok.checked;
		if(shift != this.shift_aware) {
			this.shift_aware = shift;
			const stxt = ' SHIFT ';
			for(let c = 0; c < stxt.length; c++) {
				let n = (shift ? stxt.charCodeAt(c) : 0) | 0x100;
				this.set_cell(VTerm.vt_limit + 8 + c, n);
			}
		}
		// mode (always) and shift
		this.set_cell(VTerm.vt_limit + 7, 0x1100);
		// shift and local
		this.set_cell(VTerm.vt_limit + 15, (this.shift_aware || this.local_mode) ? 0x1100 : 0x100);
		// local and aux (ignored)
		this.set_cell(VTerm.vt_limit + 23, this.local_mode ? 0x1100 : 0x100);
		if(this.local_mode) {
			let s = ' LOCAL ';
			for(let x = 0; x < s.length; x++)
				this.set_cell(VTerm.vt_limit + 16 + x, s.charCodeAt(x) | 0x100);
		} else {
			for(let x = 0; x < 7; x++)
				this.set_cell(VTerm.vt_limit + 16 + x, 0x100);
		}
		let carrier = this.mux != null
		if(carrier != this.carrier) {
			this.carrier = carrier;
			const stxt = 'CARRIER';
			for(let x = 0; x < stxt.length; x++) {
				this.set_cell(VTerm.vt_limit + 63 + x, (carrier ? stxt.charCodeAt(x) : 0) | 0x100);
			}
		}
		if(this.mux != null) {
			let s = this.mux.rts ? ' SEND   ' : ' RECEIVE';
			for(let x = 0; x < s.length; x++)
				this.set_cell(VTerm.vt_limit + 71 + x, s.charCodeAt(x) | 0x100);
		} else {
			for(let x = 0; x < 7; x++)
				this.set_cell(VTerm.vt_limit + 71 + x, 0x100);
		}
		const vcy = VTerm.rows * vt_height;
		const vcra = VTerm.vt_limit;
		let vcx = 0;
		for(let col = 0; col < VTerm.columns; col++) {
			const vca = vcra + col
			if((this.buffer[vca] & 0x8000) == 0)
				this.render_cell(vca, col, VTerm.rows, vcx, vcy);
			vcx += vt_width;
			//this.update_cell(col, VTerm.rows);
		}
	}
	scroll() {
		for(let r = 1; r < VTerm.rows; r++) {
			const celly = r - 1;
			const vcb = r * VTerm.columns;
			for(let col = 0; col < VTerm.columns; col++) {
				const vca = celly * VTerm.columns + col;
				this.set_cell(vca, this.buffer[vcb + col]);
			}
		}
		const end_row = VTerm.rows - 1;
		for(let vcx = 0; vcx < VTerm.columns; vcx++) {
			const vca = end_row * VTerm.columns + vcx;
			this.set_cell(vca, 32);
		}
		this.update_screen();
		this.present_screen();
	}
	advance_line() {
		if (this.cursor_y == VTerm.rows - 1) {
			this.scroll();
			return;
		} else {
			this.set_cursor(this.cursor_x, this.cursor_y+1);
		}
		this.present_screen();
	}
	/** moves the cursor forwards, presents the screen when done */
	advance_cursor() {
		if (this.cursor_x == VTerm.columns - 1) {
			if (this.cursor_y == VTerm.rows - 1) {
				this.set_cursor(0, this.cursor_y);
				this.scroll();
				return;
			}
			this.set_cursor(0, this.cursor_y + 1);
		} else {
			this.set_cursor(this.cursor_x + 1, this.cursor_y);
		}
		this.present_screen();
	}
	send_fn(a:string) {
		this.send(2);
		this.send(a.charCodeAt(0));
		this.send(13);
		this.check_send();
		this.canv.focus();
	}
	receive(c:number):void {
		const currow = this.cursor_y * VTerm.columns;
		const vca = currow + this.cursor_x;
		if(this.clear_status) {
			this.set_status_message('');
			this.update_statusline();
		}
		c = c & 127;
		if (this.esc_mode > VTEscapeModes.NORMAL) {
			const last_mode = this.esc_mode;
			this.esc_mode = VTEscapeModes.NORMAL;
			switch(last_mode) {
			case VTEscapeModes.SEL_ROW:
				this.esc_extra = c - 32;
				this.esc_mode = VTEscapeModes.SEL_COL;
				return;
			case VTEscapeModes.SEL_COL:
				c -= 32;
				if (c < VTerm.columns && this.esc_extra < VTerm.rows) {
					this.set_cursor(c, this.esc_extra);
					this.present_screen();
				}
				return;
			case VTEscapeModes.VTAB:
				c = c & 0x1f;
				if (c < VTerm.columns) {
					this.set_cursor(c, this.esc_extra);
					this.present_screen();
				}
				return;
			case VTEscapeModes.VATTR:
				// field bits
				// 0 1 u r m z b h
				// [m]ode: 0=var, 1=prot
				// [h]alf: 0=no effect, 1=half intensity
				// [b]link: 0=no effect, 1=blink
				// [z]ero: 0=no effect, 1=no intensity (blank to bg color)
				// * zero: overrides h/b settings
				// [r]everse: 0=no effect, 1=reverse bg/fg colors
				// [u]nderline: 0=no effect, 1=underline character
				// field types:
				// 64 110 0100  constant normal
				// 74 111 0100  constant reverse
				// 6c 110 1100  print-only
				// 7c 111 1100  print-only reverse
				if((c & 0x48) == 0x40) {
					this.char_attr = (c & 0x37) << 8;
				} else {
					console.log('vtt: unhandled attr', hex(c));
					this.set_status_message(`UKN ATTR=${hex(c)}`);
					this.clear_status = true;
				}
				return;
			case VTEscapeModes.HADDR:
				// convert to col address
				c = c & 0x7f;
				c = ((c >> 4) * 10) + (c & 0xf);
				if (c >= VTerm.columns) c = c - VTerm.columns;
				this.set_cursor(c, this.cursor_y);
				this.present_screen();
				return;
			}
			let limit;
			switch(c) {
			case 5: // transmit status message
				this.make_status();
				if(this.local_mode) {
					const stxt = 'STATUS'
					this.set_cell(VTerm.vt_limit + 30, 0x1100);
					this.clear_status = true;
					for(let x = 0; x < stxt.length; x++) {
						let n = stxt.charCodeAt(x) | 0x100;
						this.set_cell(VTerm.vt_limit + 31 + x, n);
					}
					for(let x = 0; x < this.status_code.length; x++) {
						let n = this.status_code[x] | 0x100;
						this.set_cell(VTerm.vt_limit + 37 + x, n);
					}
				} else {
					console.log('vtt: status');
					this.input_buf.push(...this.status_code);
					this.check_send();
				}
				break;
			case 48: // set vis attr
				this.esc_mode = VTEscapeModes.VATTR;
				break;
			case 49: // begin line drawing
				this.line_draw = true;
				return;
			case 50: // end line drawing
				this.line_draw = false;
				return;
			case 51: // begin transparent mode
			case 52: // end transparent mode
				console.log('vtt: unhandled transparent');
				this.set_status_message('NOT IMPL:TRNPRNT');
				this.clear_status = true;
				break;
			case 65: // ESC,A set aux port baud rate
				return;
			case 69: // ESC,E del char inline
				limit = VTerm.columnr;
				for (let q = this.cursor_x; q < limit; q++) {
					this.set_cell(currow + q, this.buffer[currow + q + 1]);
				}
				this.set_cell(currow + limit, 0x20);
				this.update_dirty();
				this.present_screen();
				return;
			case 101: // ESC,e del char from page
				limit = VTerm.vt_limit - 1;
				for (let q = vca; q < limit; q++) {
					this.set_cell(q, this.buffer[q + 1]);
				}
				this.set_cell(limit, 0x20);
				this.update_dirty();
				this.present_screen();
				return;
			case 70: // ESC,F ins char inline
				if(this.char_edit != VTEditCode.NONE) {
					this.char_edit = VTEditCode.NONE;
					this.set_status_message('');
				} else {
					this.char_edit = VTEditCode.INS_CHAR_LINE;
					this.set_status_message('INSERT');
				}
				return;
			case 102: // ESC,f ins char line
				if(this.char_edit != VTEditCode.NONE) {
					this.char_edit = VTEditCode.NONE;
					this.set_status_message('');
				} else {
					this.char_edit = VTEditCode.INS_CHAR_SCREEN;
					this.set_status_message('INSERT');
				}
				return;
			case 76: // ESC,L (el, or 108 l?) delete line
				limit = VTerm.vt_limit - VTerm.columns;
				for (let q = currow; q < limit; q++) {
					this.set_cell(q, this.buffer[q + VTerm.columns]);
				}
				for (let q = limit; q < VTerm.vt_limit; q++) {
					this.set_cell(q, 0x20);
				}
				this.update_dirty();
				this.set_cursor(0, this.cursor_y);
				this.present_screen();
				return;
			case 77: // ESC,M ins line
				limit = currow + VTerm.columns;
				for (let q = VTerm.vt_limit - 1; q >= limit; q--) {
					this.set_cell(q, this.buffer[q - VTerm.columns]);
				}
				for (let q = currow; q < limit; q++) {
					this.set_cell(q, 0x20);
				}
				this.update_dirty();
				this.set_cursor(0, this.cursor_y);
				this.present_screen();
				return;
			case 71: // ESC,G erase all unprotected data + home cursor
				limit = VTerm.vt_limit;
				for (let q = 0; q < limit; q++) {
					this.set_cell(q, 32);
				}
				this.update_dirty();
				this.set_cursor(0, 0);
				this.present_screen();
				return;
			case 75: // ESC,K erase unprotected from cursor to next field (or EOL if null form)
				limit = VTerm.columns;
				for (let q = this.cursor_x; q < limit; q++) {
					this.set_cell(currow + q, 32);
				}
				this.update_dirty();
				this.present_screen();
				return;
			case 79: // back tab: cursor to previous unprotected field
				break;
			case 82: // ESC,R enter forms mode
				console.log('vtt: unhandled Forms');
				this.set_status_message('NOT IMPL:FORMS');
				this.clear_status = true;
				break;
			case 88: // ESC,X print variable/print-only data to aux port
				break;
			case 89: // ESC,Y set cursor addr
				this.esc_mode = VTEscapeModes.SEL_ROW;
				break;
			case 90: // ESC,Z show next control code
				this.show_ctrl = true;
				return;
			case 107: // ESC,k erase unprotected from cursor to end of screen
				limit = VTerm.vt_limit;
				for (let q = vca; q < limit; q++) {
					this.set_cell(q, 32);
				}
				this.update_dirty();
				this.present_screen();
				return;
			case 115: // ESC,s reset
				// returns to conversational mode
				// aborts buffered transmission
				this.clear_buffer();
				// reply with "status message"
				// does not affect screen display
				this.char_edit = VTEditCode.NONE;
				return;
			case 120: // print all data to aux port
				break;
			default: break;
			}
			return;
		}
		if (this.show_ctrl) {
			this.show_ctrl = false;
		} else if (c < 32) {
			switch(c) {
			case 0: // NUL
				return;
			case 1: // SOH
				this.set_cursor(0, VTerm.rowb);
				break;
			case 6: // ACK
				this.advance_cursor();
				return;
			case 7: // BEL (TODO)
				if(this.vbell) this.vbell.classList.add('a');
				if (this.vbel_id > 0) {
					clearTimeout(this.vbel_id);
				}
				if(check_sound.checked) {
					if(wa == undefined) wa = wa_setup();
					wa_do_beep();
				}
				this.vbel_id = setTimeout(()=>{
					this.vbel_id = 0;
					if(this.vbell) this.vbell.classList.remove('a');
				}, 1000);
				//this.buffer[vca] = 7;
				return;
			case 8: // BS
			case 21:// NAK
				if (this.cursor_x > 0)
					this.set_cursor(this.cursor_x-1, this.cursor_y);
				else if(this.cursor_y > 0)
					this.set_cursor(VTerm.columnr, this.cursor_y-1);
				else
					this.set_cursor(VTerm.columnr, VTerm.rowb);
				break;
			case 9: // HT
				this.set_cursor(0, VTerm.rowb);
				break;
			case 10: // LF
				this.advance_line();
				return;
			case 11: // VT
				// next char & 0x1f is row address
				this.esc_mode = VTEscapeModes.VTAB;
				return;
			case 12: {// FF (clear)
				let limit = VTerm.vt_limit;
				for (let q = 0; q < limit; q++) {
					this.set_cell(q, 32);
				}
				this.update_dirty();
				this.set_cursor(0, 0);
				this.present_screen();
				return;
			}
			case 13: // CR
				this.set_cursor(0, this.cursor_y);
				break;
			case 16: // DLE (set horz address)
				// next char & 0x7f is converted to col address
				this.esc_mode = VTEscapeModes.HADDR;
				return;
			case 18: // DC4 (aux port on)
				console.log('vtt: unhandled DC4 ON');
				this.set_status_message('NOT IMPL:AUX');
				this.clear_status = true;
				break;
			case 20: // DC4 (aux port off)
				this.set_status_message('NOT IMPL:AUX');
				this.clear_status = true;
				break;
			case 26: // SUB
				if (this.cursor_y == 0) {
					this.set_cursor(this.cursor_x, VTerm.rowb);
				} else {
					this.set_cursor(this.cursor_x, this.cursor_y - 1);
				}
				break;
			case 27: // ESC
				this.esc_mode = VTEscapeModes.ESC;
				return;
			default:
				console.log('vtt: unhandled control code:', '^'+String.fromCharCode(64+c), `[${hex(c)}]`);
				return;
			}
			this.present_screen();
			return;
		}
		if (this.line_draw && c >= 64 && c < 108) {
			c += 64;
			c = (c & 0xfc) | (this.char_attr & 0xfc00) | ((c << 8) & 0x300);
		} else {
			c = c | this.char_attr;
		}
		if (this.char_edit == VTEditCode.INS_CHAR_LINE) {
			for(let q = currow + VTerm.columnr; q > vca; q--) {
				this.set_cell(q, this.buffer[q - 1]);
			}
		} else if(this.char_edit == VTEditCode.INS_CHAR_SCREEN) {
			for(let q = VTerm.vt_limit - 1; q > vca; q--) {
				this.set_cell(q, this.buffer[q - 1]);
			}
		}
		this.set_cell(vca, c);
		if(this.char_edit != VTEditCode.NONE) {
			// The *key* toggles this, but does the ESC code as well?
			//this.char_edit = VTEditCode.NONE;
			this.update_dirty();
		}
		this.advance_cursor();
	}
	get_dev(): CharDevice | undefined {
		return this.mux;
	}
	bind_dev(dev: CharDevice | undefined): void {
		this.mux = dev;
		this.clear_buffer();
		this.set_cts(dev?.rts || false);
	}
	can_receive(): boolean {
		return true;
	}
	set_cts(value: boolean): void {
		let s = value ? 'SEND   ' : 'RECEIVE';
		for(let x = 0; x < s.length; x++) this.set_cell(VTerm.vt_limit + 72 + x, s.charCodeAt(x) | 0x100);
	}
	clear_buffer() {
		this.input_buf.length = 0;
		this.import_buf.length = 0;
	}
	check_send() {
		if (this.mux == null) return;
		if (this.input_control ||
			(this.mux.can_receive() &&
				(!this.mux.emu_linked || this.mux.rts)
			)) {
			if (this.input_buf.length > 0) {
				this.input_interval = VTerm.input_interval_rate;
				let sv = this.input_buf.shift() as number;
				this.mux.receive(sv);
			} else {
				this.input_control = false;
				if(this.import_buf.length > 0 && this.input_interval < 1) {
					this.input_interval = VTerm.input_interval_rate;
					let sv = this.import_buf.shift() as number;
					this.mux.receive(sv);
				}
			}
		}
	}
	send(c:number) {
		if (this.local_mode) {
			this.receive(c);
			return;
		}
		if (this.clear_status) {
			this.set_status_message('');
			this.update_statusline();
			this.present_screen();
		}
		if (this.input_buf.length < 12)
			this.input_buf.push(c);
	}
	text_import(txt:string):void {
		let last = false;
		for(let c of txt) {
			let v = c.codePointAt(0) as number;
			if(v == 10) {
				if (last) {
					this.import_buf.push(10); // backslash + newline (linefeed)
				} else {
					this.import_buf.push(13); // typical Centurion newline
				}
				last = false;
			} else if (v == 92) { // backslash
				last = true;
			} else {
				if (last) this.import_buf.push(92);
				this.import_buf.push(v);
				last = false;
			}
		}
		this.check_send();
	}
}
const cx_crt = [
	new VTerm('CRT0', dc_crt0),
	new VTerm('CRT1', frame_crt1.content),
	new VTerm('CRT2', frame_crt2.content),
];
run_hw.push(cx_crt[0]);
run_hw.push(cx_crt[1]);
run_hw.push(cx_crt[2]);
if(cx_crt[0].glv && cx_crt[1].glv && cx_crt[2].glv) {
	console.log('VT using WebGL renderer');
} else {
	cx_crt[0].glv && console.warn('VT CRT0 using WebGL renderer');
	cx_crt[1].glv && console.warn('VT CRT1 using WebGL renderer');
	cx_crt[2].glv && console.warn('VT CRT2 using WebGL renderer');
	if(vt_use_offscreen) {
		console.log('VT rendered using OffscreenCanvas');
	} else {
		console.warn('VT rendered direct to Canvas');
	}
}

function console_text_import(txt:string):void {
	cx_crt[0].text_import(txt);
}
setInterval(function(){
	cx_crt[0].update_blink();
	if(frame_crt1.show) cx_crt[1].update_blink();
	if(frame_crt2.show) cx_crt[2].update_blink();
	if(vt_font_bmp != null) vt_force_redraw = false;
}, 125);

const init_program = '79 86 23 C8 E5 EC EC EF F2 EC E4 A1 8D 8A 00 71 80 01';
const program_rotl = '60 AA AA 60 AA AA 55 40 37 00 37 00 37 00 37 00 37 00 37 00 37 00 37 00 37 00 37 00 37 00 37 00 37 00 37 00 37 00 37 00 71 01 03';
const program_rotr = '60 AA AA 60 AA AA 55 40 36 00 36 00 36 00 36 00 36 00 36 00 36 00 36 00 36 00 36 00 36 00 36 00 36 00 36 00 36 00 36 00 71 01 03';
const programx_xassm = bload(`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
1YgYWPWIGNWIEFs6PxkIhWGlIUAQc/WLQAEU14AEc9NtopWIBjABXJX5AHgiW4gYtYgUUAZliBDa
wIRBMhUD63Mx2iIgWJAABVj1iBiQAYpZFwZ7MBTQc5+VQV0iAPVhQDI4xUHlYUAyORf3wIAjICAg
+ypzgjq1iBiViBK1iAh5AIkCCXvvFRt5AEYClYgWtYgSOLWIFjlRIBAHVYJmGV0VAjoJgGoBAgFl
CHQbAQICbQiFAYBI34AAAAAAAAAAAQIBTgiy9AAIItMCCW2ie8pzxmsBAgK8CwwoADYi29VBlSHz
HkUQ1UGFIYUh8xZdtaJBARYCRTBFASIAswN5AAAAAAAAAABFMxUF1aFBIwmVoUUzCeoBAgKCCxZY
AQICggsaVAAhIxF+YZVB1UFVJtVBOWeKYhQHFwp/YcABCX9hIjAJf2HA/wn6AQICawshZAF4CEMI
RAhXCGIIZAhnCGkIbAhvCHEIeAh7CIAIiAjDCNQI3wjkCQcJKAk3CUAJRglLCU4JUglXCWoJbwl7
CYwJjwmaCaMJqAmvCb8JxAnICc0J0AnVCd8J5AnmCegJ6gnsCe4J8AnyCfQJ9gn4CfoJ/An+CiIK
JwowCj+oACUjMn5hVVcAADBBORcEMEFzE2eeoAY4WRkDWVUg1UE5FgNnSiZ/YQnxAB8jV5VBbaK1
omUBGQ5QQNCgoMUCQSMVAz8Y95WhbQBloQm7AAMjdnEDJsqAiBY5USAQB1WCZhldFQI6CYBqAQIB
ZQh0GwECAm0IhQGASN+AAAAAAAAAAAB4JpxVugAAZlwAAgwAAHkDyQRJZlwAARIDYGZcAAEVA0KD
/CwQBcCA4QRALBEwkARhsQRPe3AESXtsBD+AAMAgShUFkP/1sxKQAALTDVEg0QRvUCCxAAB5AAAA
AARxkP/g0QRV9QHRBFf1AcCg5QHRBFz1AdEEXvUBMAFYAHgnFLMFZgtmBQQAAJP80AAIUCDQoKD1
AbMJg6nAIEoUGWYcAACT/MCg5QgIcxLaZhBmB9qJFvrVQQmQ//WxAACQAABc0AAAZlIBAAAAAFUi
FBKQAACxAAZQdgGTkAABsQAKcwWQAACzD9AAAGZcAQEBBAzD/BQPkAGTsQUBeAhDCkQKSgpNClQK
XApgCmMKZgprCm8KigqMCpIKlQqaCp4KowqsCswK4QrlCugLLgszC0kLVAtWC1wLYQuIC6kLwgvS
C90L6AvrC+0L7wvxC/ML9Qv3C/kL+wv9C/8MAQwDDAUMBwwKDBUMGAwkDC0MVAxXDFoMZgxsU4AC
AWUIdBsBAgJtCIUBgEjfgAAAAAAAAAAAWyeMAAZQdgGT0AAAZhjQAABmGGYFDAAAsQAA0AAAZhjQ
AABmGNZnAABxAAAAgQABAFcEbwAAAIIAAgBQBFMAAAAMwdPTzaCtoLausLWNAAzFztTF0qDUydTM
xY0AAFEBeAhDDHgMnAyfDKIMpwyqDLoMvwzQDNMM2gzfDOIM5QztDQkNGQ0hDSQNJw0sDS8NNg07
DUINRw1KDXANlg2hDaQNuw3KDdYN2Q3eDegN+w4DDgoOEg4XDhoOMQ47DkIORw5NDlQOYg5nDm0O
cA6DDpEOlA6eDqgOqw6xtwF4CEMOuQ7DDssO6A7uDwkPFA9aD2APbg9/D4cPmw+kD6wPsQ+3D8AP
yw/QD9UP4w/tD/IP9w/+EAMQDxAUEBkQIBAxEDkQPBBBEEQQTxBaEF0QZBBpEG4QhxCKEJUQmBCi
EK0QshDUENcQ5BDwEPQRABEKESURKBEyETm0AQIHhhZ05gECBzAWfDQBAgbDFql1AQIBzRaxaICA
AgFlCHQbAQICbQiFAYBI34AAAAAAAAAAAXgIQxE9EUARRRFOEVMRWhFqEW0RfxGIEZYR0BHaEeAR
8BH0EfcR/BIgEioSMBI4EjwSPxJRElcSbBJvEnQSdxJ5EnsSsRKzErUStxK5ErsSvRK/EsESwxLU
EwATJBM1EzwTQxNLE1ETVBNZE14TahNuE3ETdxN6E30TkgQBAgJtGFgeAQICbRhcGgECAnwYdvEB
AgG/GqV+AQIB9hwmxAF4CEMTqROwE7UTwBPHE9QT5hP3FBIUHhQhFDcUPRRJFE4UUxRYFF4UYxSe
FKMU5BT1FQ4VFRWdFaIVrxW/FcIVzhXVFewV9hYAFgMWBhYXFiEWJhZEFk4WWBZcFmYWgxaGFpMW
mBamFucW7xcLFxMXJRcrFzUXTRdYF2adgCAQMRA5EDwQQRBEEE8QWhBdEGQQaRBuEIcQihCVEJgQ
ohCtELIQ1BDXEOQQ8BD0EQARChElESgRMhE5tAECB4YWdOYBAgcwFnw0AQIGwxapdQECAc0WsWiA
gAIBZQh0GwECAm0IhQGASN+AAAAAAAAAAAF4CEMXghewGBsYOxhTGGEYaRh5GH0YgxiPGJ0Yohi6
GMMYzBjQGNQY3hkDGQ4ZEBkSGRQZRhlRGWAZZxlrGW4Z6RnyGf0aEBoSGhUaoBq9GsMayBrXGtwa
3hrkGu0a+Br6Gv0cDxwUHBkcHhwoHC4cPBw/HEUcSxxVHF5XASwIQxxnHHUcoRyjHKUcpxypHKsc
rxyxHLMctxy5HLscvRy/HMMcxRzHHM8c0x8blwECIUQBVkEBAiFrAPJ/AQ4hayFsIW4hciGAIbwi
riK3jwECItsH6BEBAiMRB60VAQIjESL7rAECIzIY9poBAiMyGbjXAQIjVwICfwECI3YFLzABAgDI
Jp5xAQIITCal3gECArwm3TwBAgKCJuJxAQICgibuZQECIzIm8ZEBAgK8JvMmAQICvCb4IQECArwn
TMwBAgsMJ09wAQIBBidWeQECAQYnZ2gBAgEGJ3FeAQIBJCd7NgECASQnjCUBAgEkJ5MeAQIAyieY
dAECAMonn20BAhq3J6JjgEjfgAAAAAAAAAABAgDoJ6VJAQIBBieqJQECCEonsNQBAghDJ7PYAS4j
diN3JqgmqiaxJrgmwibIJssmzybTJukm9Sb7JwAnCScOJ1InZCd2J4IniSe7J8X3AAAFLs2E1xrc
Gt4a5BrtGvga+hr9HA8cFBwZHB4cKBwuHDwcPxxFHEscVRxeVwEsCEMcZxx1HKEcoxylHKccqRyr
HK8csRyzHLccuRy7HL0cvxzDHMUcxxzPHNMfG5cBAiFEAVZBAQIhawDyfwEOIWshbCFuIXIhgCG8
Iq4it48BAiLbB+gRAQIjEQetFQECIxEi+6wBAiMyGPaaAQIjMhm41wECI1cCAn8BAiN2BS8wAQIA
yCaecQECCEwmpd4BAgK8Jt08AQICgibicQECAoIm7mUBAiMyJvGRAQICvCbzJgECArwm+CEBAgK8
J0zMAQILDCdPcAECAQYnVnkBAgEGJ2doAQIBBidxXgECASQnezYBAgEkJ4wlAQIBJCeTHgECAMon
mHQBAgDKJ59tAQIatyeiY4BI34AAAAAAAAAA`);
const enum NAMECON {
	CENT,
	MEI, WIKI,
}
const NB = String.fromCodePoint(0xa0);

function hexcs(s:string):string {
	if(!HEX_CONV) return s;
	if(name_conv == NAMECON.CENT) {
		return `X'${s}'`;
	}
	return '0x' + s;
}
function hexlist(v:number, l:number = 2) {
	if(v < 0) return '-'+ hexcs((-v).toString(16).toUpperCase().padStart(l,'0'));
	return hexcs(v.toString(16).toUpperCase().padStart(l,'0'));
}
/** required expression */
function hexlistc(v:number, l:number = 2) {
	if(v == 0) return '0';
	if(v < -31 && l==2) return hexcs((v&0xff).toString(16).toUpperCase().padStart(l,'0'));
	if(v < -255 && l==4) return hexcs((v&0xffff).toString(16).toUpperCase().padStart(l,'0'));
	if(v < -31) return '-'+ hexcs((-v).toString(16).toUpperCase().padStart(l,'0'));
	if(v < 0) return `-${-v}`;
	if(v > 31) return hexcs(v.toString(16).toUpperCase().padStart(l,'0'));
	return `${v}`;
}
/** required expression, with minus in parens */
function hexlistcrp(v:number, l:number = 2) {
	if(v == 0) return '0';
	if(v < -255 && l==4) return hexcs((v&0xffff).toString(16).toUpperCase().padStart(l,'0'));
	if(v < -31) return '(-'+ hexcs((-v).toString(16).toUpperCase().padStart(l,'0')) + ')';
	if(v < 0) return `(-${-v})`;
	if(v > 31) return hexcs(v.toString(16).toUpperCase().padStart(l,'0'));
	return `${v}`;
}
/** optional comma expression, with minus in parens */
function hexlistcp(v:number, l:number = 2) {
	if(v == 0) return '';
	if(v < -255 && l==4) return ','+ hexcs((v&0xffff).toString(16).toUpperCase().padStart(l,'0'));
	if(v < -31) return ',(-'+ hexcs((-v).toString(16).toUpperCase().padStart(l,'0')) + ')';
	if(v < 0) return `,(-${-v})`;
	if(v > 31) return ','+ hexcs(v.toString(16).toUpperCase().padStart(l,'0'));
	return `,${v}`;
}
function hexlistp(v:number, l:number = 2) {
	if(v == 0) return '';
	if(v < 0) return ' - '+ hexcs((-v).toString(16).toUpperCase().padStart(l,'0'));
	return ' + '+hexcs(v.toString(16).toUpperCase().padStart(l,'0'));
}
function hex(v:number, l:number = 2) {
	if(v < 0) return '-'+ ((-v).toString(16).toUpperCase().padStart(l,'0'));
	return v.toString(16).toUpperCase().padStart(l,'0');
}
function dec(v:number, l:number = 2) {
	if(v<0) '-'+(-v).toString(10).padStart(l,'0');
	return v.toString(10).padStart(l,'0');
}
function buftohex(buf:Uint8Array, offset:number=0, length?:number):string {
	let hs = '';
	const limit = buf.byteLength;
	if(length === undefined) {
		length = limit;
	}
	if(limit == 0) return hs;
	hs = buf[offset].toString(16).padStart(2,'0');
	if(limit == 1) return hs;
	for(let i = 1; i < length && i+offset < limit; i++) {
		hs += ' '+buf[i+offset].toString(16).padStart(2,'0')
	}
	return hs;
}
function bin(v:number, l:number) {
	return v.toString(2).padStart(l,'0');
}
/** treat 8 bit value as signed */
function sbyte(v:number):number {
	v = v & 0xff;
	if (v > 127) v -= 256;
	return v;
}
/** treat 16 bit value as signed */
function sword(v:number):number {
	v = v & 0xffff;
	if (v > 32768) v -= 65536;
	return v;
}
function nyb(c:number):string {
	return (c >> 4).toString(2).padStart(4,'0') + ' ' + (c&15).toString(2).padStart(4,'0');
}
function bit(v:number, b:number):number {
	return (v >> b) & 1;
}

// @ts-ignore
window.buftohex = buftohex;
// @ts-ignore
window.dec = dec;
// @ts-ignore
window.hex = hex;
// @ts-ignore
window.bin = bin;
// @ts-ignore
window.s_byte = sbyte;
// @ts-ignore
window.s_word = sword;
// @ts-ignore
window.nyb = nyb;
// @ts-ignore
window.bit = bit;
const ALU_F:{on:number,sym:string,ivr:boolean,ivs:boolean}[] = [
	{on:0,sym:'+',ivr:false,ivs:false},
	{on:0,sym:'+',ivr:true,ivs:false},
	{on:0,sym:'+',ivr:false,ivs:true},
	{on:1,sym:'|',ivr:false,ivs:false},
	{on:2,sym:'&',ivr:false,ivs:false},
	{on:2,sym:'&',ivr:true,ivs:false},
	{on:3,sym:'^',ivr:false,ivs:false},
	{on:3,sym:'^',ivr:true,ivs:false}
];

class ALU8 {
	in_data:number = 0;
	reg:number[] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
	regq:number = 0;
	y:number = 0;
	out_f:number = 0;
	carry_in:number = 0;
	half_carry_out:number = 0;
	main_carry_out:number = 0;
	sign:number = 0;
	over:number = 0;
	zero:number = 0;
	ram0:number = 0;
	ram7:number = 0;
	q0:number = 0;
	q7:number = 0;
	is_right:boolean = false;

	// save results to register(s)
	step(dst:number, sel_b:number) {
		switch(dst) {
		case 0: this.regq = this.y; break; // Q=
		case 1: break; // nop
		case 2: this.reg[sel_b] = this.y; break; // B=
		case 3: this.reg[sel_b] = this.y; break; // B=
		case 4: // B=F>>1 Q>>=1
			this.reg[sel_b] = (this.y >> 1) | (this.ram7 << 7);
			this.regq = (this.regq >> 1) | (this.q7 << 7);
			break;
		case 5: // B=F>>1
			this.reg[sel_b] = (this.y >> 1) | (this.ram7 << 7);
			break;
		case 6: // B=F<<1 Q<<=1
			this.reg[sel_b] = ((this.y << 1) | this.ram0) & 255;
			this.regq = ((this.regq << 1) | this.q0) & 255;
			break;
		case 7: // B=F<<1
			this.reg[sel_b] = ((this.y << 1) | this.ram0) & 255;
			break;
		}
	}
	// perform logic flow
	resolve_alu(alsrc:number, alfn:number, aldst:number, sel_a:number, sel_b:number) {
		const dsti = aldst & 7;
		const fn = ALU_F[alfn & 7];
		// TODO fn.iv
		const vals_1 = this.in_data;
		const vals_2 = this.reg[sel_a];
		const vals_3 = this.reg[sel_b];
		const vals_4 = this.regq;
		let val_r:number = 0;
		let val_s:number = 0;
		switch(alsrc & 7) {
		case 0: val_r = vals_2; val_s = vals_4; break;
		case 1: val_r = vals_2; val_s = vals_3; break;
		case 2: val_r = 0; val_s = vals_4; break;
		case 3: val_r = 0; val_s = vals_3; break;
		case 4: val_r = 0; val_s = vals_2; break;
		case 5: val_r = vals_1; val_s = vals_2; break;
		case 6: val_r = vals_1; val_s = vals_4; break;
		case 7: val_r = vals_1; val_s = 0; break;
		}
		val_r = (fn.ivr ? ~val_r : val_r) & 255;
		val_s = (fn.ivs ? ~val_s : val_s) & 255;
		let out = 0;
		switch(fn.on) { // [+ & | ⊻]
		case 0: // subtraction is just addition with inverted inputs
			out = val_r + val_s + this.carry_in;
			this.main_carry_out = (out > 255) ? 1 : 0;
			this.half_carry_out = (((val_r & 15) + (val_s & 15) + this.carry_in) > 15) ? 1 : 0;
			this.over = this.main_carry_out ^ ((((val_r & 127) + (val_s & 127) + this.carry_in) > 127) ? 1 : 0);
			break;
		case 1:
			out = val_r | val_s;
			this.half_carry_out = ((((val_r|val_s)&15)==15) ? 0 : 1) | this.carry_in;
			this.over = this.main_carry_out = (((val_r|val_s)==255) ? 0 : 1) | this.carry_in;
			break;
		case 2:
			out = val_r & val_s;
			this.half_carry_out = ((((val_r&val_s)&15)!=0) ? 1 : 0) | this.carry_in;
			this.over = this.main_carry_out = (((val_r&val_s)!=0) ? 1 : 0) | this.carry_in;
			break;
		case 3:
			out = val_r ^ val_s;
			break;
		}
		out &= 255;
		this.y = out;
		this.zero = (out == 0) ? 1 : 0;
		this.sign = (out > 127) ? 1 : 0;
		if (dsti == 2) {
			this.out_f = vals_2 & 255; // select A to the bus output
		} else {
			this.out_f = out;
		}
		this.is_right = (dsti & 2) == 0;
		if(dsti > 3) {
			if(this.is_right) {
				this.q0 = this.regq & 1;
				this.ram0 = out & 1;
			} else {
				this.q7 = (this.regq >> 7) & 1;
				this.ram7 = (out >> 7) & 1;
			}
		}
	}
}
class ALU {
	src:number = 0;
	aop:number = 0;
	dst:number = 0;
	sel_a:number = 0;
	sel_b:number = 0;
	in_data:number = 0;
	reg:number[] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
	regq:number = 0;
	y:number = 0;
	out_f:number = 0;
	carry_in:number = 0;
	carry_out:number = 0;
	sign:number = 0;
	over:number = 0;
	zero:number = 0;
	ram0:number = 0;
	ram3:number = 0;
	q0:number = 0;
	q3:number = 0;
	is_shift:boolean = false;
	is_right:boolean = false;

	// save results to register(s)
	step() {
		const dst = this.dst & 7;
		const ib = this.sel_b&15;
		switch(dst) {
		case 0: this.regq = this.y; break; // Q=
		case 1: break; // nop
		case 2: this.reg[ib] = this.y; break; // B=
		case 3: this.reg[ib] = this.y; break; // B=
		case 4: // B=F>>1 Q>>=1
			this.reg[ib] = (this.y >> 1) | (this.ram3 << 3);
			this.regq = (this.regq >> 1) | (this.q3 << 3);
			break;
		case 5: // B=F>>1
			this.reg[ib] = (this.y >> 1) | (this.ram3 << 3);
			break;
		case 6: // B=F<<1 Q<<=1
			this.reg[ib] = ((this.y << 1) | this.ram0) & 15;
			this.regq = ((this.regq << 1) | this.q0) & 15;
			break;
		case 7: // B=F<<1
			this.reg[ib] = ((this.y << 1) | this.ram0) & 15;
			break;
		}
	}
	// perform logic flow
	resolve_alu() {
		const dsti = this.dst & 7;
		const fn = ALU_F[this.aop & 7];
		const ia = this.sel_a&15;
		const ib = this.sel_b&15;
		// TODO fn.iv
		const vals_1 = this.in_data;
		const vals_2 = this.reg[ia];
		const vals_3 = this.reg[ib];
		const vals_4 = this.regq;
		let val_r:number = 0;
		let val_s:number = 0;
		switch(this.src & 7) {
		case 0: val_r = vals_2; val_s = vals_4; break;
		case 1: val_r = vals_2; val_s = vals_3; break;
		case 2: val_r = 0; val_s = vals_4; break;
		case 3: val_r = 0; val_s = vals_3; break;
		case 4: val_r = 0; val_s = vals_2; break;
		case 5: val_r = vals_1; val_s = vals_2; break;
		case 6: val_r = vals_1; val_s = vals_4; break;
		case 7: val_r = vals_1; val_s = 0; break;
		}
		val_r = (fn.ivr ? ~val_r : val_r) & 15;
		val_s = (fn.ivs ? ~val_s : val_s) & 15;
		let out = 0;
		switch(fn.on) { // [+ & | ⊻]
		case 0: // subtraction is just addition with inverted inputs
			out = val_r + val_s + this.carry_in;
			this.carry_out = (out > 15) ? 1 : 0;
			this.over = this.carry_out ^ ((((val_r & 7) + (val_s & 7) + this.carry_in) > 7) ? 1 : 0);
			break;
		case 1:
			out = val_r | val_s;
			this.over = this.carry_out = (((val_r|val_s)==15) ? 0 : 1) | this.carry_in;
			break;
		case 2:
			out = val_r & val_s;
			this.over = this.carry_out = (((val_r&val_s)!=0) ? 1 : 0) | this.carry_in;
			break;
		case 3:
			out = val_r ^ val_s;
			break;
		}
		out &= 15;
		this.y = out;
		this.zero = (out == 0) ? 1 : 0;
		this.sign = (out > 7) ? 1 : 0;
		if (dsti == 2) {
			this.out_f = vals_2 & 15; // select A to the bus output
		} else {
			this.out_f = out;
		}
		this.is_shift = dsti > 3;
		this.is_right = (dsti & 2) == 0;
		if(this.is_shift) {
			if(this.is_right) {
				this.q0 = this.regq & 1;
				this.ram0 = out & 1;
			} else {
				this.q3 = (this.regq >> 3) & 1;
				this.ram3 = (out >> 3) & 1;
			}
		}
	}
	// debug/trace string
	static trace_str(srci:number,fni:number,dsti:number,ia:number,ib:number,sq_str:string,sr_str:string,f_str:string,d_str:string,carry:string) {
		const vals_2 = `r${dec(ia,2)}`;
		const vals_3 = `r${dec(ib,2)}`;
		let val_r:string;
		let val_s:string;
		let val_rn:number;
		let val_sn:number;
		const show_f = f_str.length > 0;
		if(show_f) {
			f_str += '= ';
		}
		switch(srci & 7) {
		default:
		case 0: val_rn = 3+ia; val_r = vals_2; val_sn = 2; val_s = 'Q'; break;
		case 1: val_rn = 3+ia; val_r = vals_2; val_sn = 3+ib; val_s = vals_3; break;
		case 2: val_rn = 0; val_r = '0'; val_sn = 2; val_s = 'Q'; break;
		case 3: val_rn = 0; val_r = '0'; val_sn = 3+ib; val_s = vals_3; break;
		case 4: val_rn = 0; val_r = '0'; val_sn = 3+ia; val_s = vals_2; break;
		case 5: val_rn = 1; val_r = d_str; val_sn = 3+ia; val_s = vals_2; break;
		case 6: val_rn = 1; val_r = d_str; val_sn = 2; val_s = 'Q'; break;
		case 7: val_rn = 1; val_r = d_str; val_sn = 0; val_s = '0'; break;
		}
		let dst:string;
		switch(dsti & 7) {
		default:
		case 0: dst = `${f_str}Q= `; break;
		case 1: dst = f_str; break;
		case 2: dst = `${f_str}${show_f?vals_2:''}, ${vals_3}=  `; break;
		case 3: dst = `${f_str}${vals_3}= `; break;
		case 4: dst = `${sq_str}>>Q, ${sr_str}>>${vals_3}= ${f_str}`; break;
		case 5: dst = `${sr_str}>>${vals_3}= ${f_str}`; break;
		case 6: dst = `Q<<${sq_str}, ${vals_3}<<${sr_str}= ${f_str}`; break;
		case 7: dst = `${vals_3}<<${sr_str}= ${f_str}`; break;
		}
		const fn = ALU_F[fni];
		let fdesc:string;
		if(!show_f && dsti == 1) {
			fdesc = '';
		} else switch(fn.on) {
		case 0:
			if(carry == '0') {
				if(fn.ivr) {
					if(val_rn == 0) val_r = '1';
					fdesc = `${val_s} - ${val_r}`;
				} else if(fn.ivs) {
					if(val_sn == 0) val_s = '1';
					fdesc = `${val_r} - ${val_s}`;
				} else {
					if(val_rn == 0) fdesc = val_s;
					else if(val_sn == 0) fdesc = val_r;
					else fdesc = `${val_r} + ${val_s}`;
				}
			} else if(carry == '1') {
				if(fn.ivr) {
					if(val_rn == 0) fdesc = val_s;
					else fdesc = `${val_s} - ${val_r}`;
				} else if(fn.ivs) {
					if(val_sn == 0) fdesc = val_r;
					else fdesc = `${val_r} - ${val_s}`;
				} else {
					if(val_rn == 0) fdesc = `${val_s} +1`;
					else if(val_sn == 0) fdesc = `${val_r} +1`;
					else fdesc = `${val_r} + ${val_s} +1`;
				}
			} else {
				if(fn.ivr) {
					if(val_rn == 0) val_r = '1';
					fdesc = `${val_s} - ${val_r} + ${carry}`;
				} else if(fn.ivs) {
					if(val_sn == 0) val_s = '1';
					fdesc = `${val_r} - ${val_s} + ${carry}`;
				} else {
					fdesc = `${val_r} + ${val_s} + ${carry}`;
				}
			}
			break;
		default:
		case 1: // or
			if(val_rn == 0 && !fn.ivr) fdesc = `${fn.ivs?'~':''}${val_s}`;
			else if(val_sn == 0 && !fn.ivs) fdesc = `${fn.ivr?'~':''}${val_r}`;
			else fdesc = `${fn.ivr?'~':''}${val_r} ${fn.sym} ${fn.ivs?'~':''}${val_s}`;
			break;
		case 2: // and
			if((val_rn == 0 && !fn.ivr) || (val_sn == 0 && !fn.ivs)) fdesc = '0';
			else if(val_rn == 0 && fn.ivr) fdesc = `${fn.ivs?'~':''}${val_s}`;
			else if(val_sn == 0 && fn.ivs) fdesc = `${fn.ivr?'~':''}${val_r}`;
			else fdesc = `${fn.ivr?'~':''}${val_r} ${fn.sym} ${fn.ivs?'~':''}${val_s}`;
			break;
		case 3: // xor
			if(val_sn == val_rn && !fn.ivr) fdesc = '0';
			else if(val_sn == 0) fdesc = `${fn.ivr?'~':''}${val_r}`;
			else if(val_rn == 0 && fn.ivr) fdesc = `~${val_s}`;
			else fdesc = `${fn.ivr?'~':''}${val_r} ${fn.sym} ${val_s}`;
			break;
		}
		return `o${srci}${fni}${dsti} ${dst}${fdesc}`;
	}
}

const FN_SEQ_SN = ['P','R','S','D']; // 'uPC','AHR','STK','DIR'
const FN_SEQ_FE = ['POP','---','PSH','   ']; // FE:0 | (PUSH:1/POP:0) << 1

class Sequencer {
	p:number = 0;
	h:number = 0;
	sf:[number,number,number,number] = [0,0,0,0];
	sp:number = 0;
	output:number = 0;
	next:number = 0; // incrementer output to pc
	reset() {
		this.p = 0;
		this.h = 0;
		this.sf[0] = 0;
		this.sf[1] = 0;
		this.sf[2] = 0;
		this.sf[3] = 0;
		this.sp = 0;
		this.output = 0;
		this.next = 0;
	}
	resolve(cin:boolean, sel_s:number, d:number, or:number, zero:boolean):boolean {
		let out = 0;
		switch(sel_s & 3) {
		case 0: out = this.p; break;
		case 1: out = this.h; break;
		case 2: out = this.sf[this.sp]; break;
		case 3: out = d; break;
		}
		out = zero ? 0 : (out | or) & 15;
		this.output = out;
		if (cin) {
			if (out >= 15) {
				this.next = 0;
				return true;
			} else {
				this.next = out + 1;
				return false;
			}
		}
		this.next = out;
		return false;
	}
	commit(fc:number):void {
		if (fc == 0) {
			this.sp = (this.sp + 1) & 3;
		} else if (fc == 2) {
			this.sp = (this.sp - 1) & 3;
			this.sf[this.sp] = this.p;
		}
		this.p = this.next;
	}
}

const FN_8X02 = [
	'TSK','INC','BTL','POP','BSR','PLP','BRT','RST'
];
const FN_8X02_C = [
	'SkipIf','Inc   ','RetnIf','Return','BrSRIf','PshInc','BrchIf','Reset '
];
const FN_8X02_N = [
	'Inc','Inc','PopInc','Return','Inc','PushPInc','Inc','Reset '
];
const FN_8X02_A = [
	'Skip','Inc','Return','Return','BranchSub','PushPInc','BranchTo','Reset '
];
class Sequencer8X02 {
	p:number = 0;
	sf:[number,number,number,number] = [0,0,0,0];
	sp:number = 0;
	reset():void {
		this.p = 0;
	}
	commit(actrl:number, branch:number, test:boolean):void { // rising clock edge
		// load the multiplexor into the address register
		let next:number = 0;
		switch(actrl) {
		case 0: next = this.p + (test ? 2 : 1); break;
		case 1: next = this.p + 1; break;
		case 2: // Branch to loop
			this.sp = (this.sp - 1) & 3;
			if (test) {
				next = this.sf[this.sp];
			} else {
				next = this.p + 1;
			}
			break;
		case 3: // POP return from subroutine
			this.sp = (this.sp - 1) & 3;
			next = this.sf[this.sp];
			break;
		case 4: // Branch to subroutine
			if(test) {
				this.sf[this.sp] = this.p + 1;
				this.sp = (this.sp + 1) & 3;
				next = branch;
			} else {
				next = this.p + 1;
			}
			break;
		case 5: // Push for looping:
			this.sf[this.sp] = this.p;
			this.sp = (this.sp + 1) & 3;
			next = this.p + 1;
			break;
		case 6: next = (test ? branch : this.p + 1); break;
		case 7: break; // next = 0
		}
		this.p = next & 0x3ff;
	}
}

function seqencer_selftest() {
	function seqencer_initial() {
		const v = new Sequencer();
		v.p = 2;
		v.output = 0;
		v.h = 4;
		v.sf[0] = 6;
		v.sf[1] = 8;
		v.sf[2] = 10;
		v.sf[3] = 12;
		return v;
	}
	function seqencer_display(v:Sequencer) {
		const ilu = ['Z','Z+1','J','J+1','K','K+1','Ra','Ra+1','Rb','Rb+1','Rc','Rc+1','Rd','Rd+1','D','D+1'];
		console.log('seq', 'pc',ilu[v.p], 'h',ilu[v.h], 'stk0', ilu[v.sf[v.sp]], 'stk1', ilu[v.sf[(v.sp + 1) & 3]], 'stk2', ilu[v.sf[(v.sp + 2) & 3]], 'stk3', ilu[v.sf[(v.sp + 3) & 3]], 'out', ilu[v.output]);
	}
	let test = seqencer_initial();
	test.resolve(true, 0, 14, 0, false);
	test.commit(0);
	seqencer_display(test);
	test = seqencer_initial();
	test.resolve(true, 0, 14, 0, false);
	test.commit(2);
	seqencer_display(test);
	test = seqencer_initial();
	test.resolve(true, 0, 14, 0, false);
	test.commit(1);
	seqencer_display(test);

	test = seqencer_initial();
	test.resolve(true, 1, 14, 0, false);
	test.commit(0);
	seqencer_display(test);
	test = seqencer_initial();
	test.resolve(true, 1, 14, 0, false);
	test.commit(2);
	seqencer_display(test);
	test = seqencer_initial();
	test.resolve(true, 1, 14, 0, false);
	test.commit(1);
	seqencer_display(test);

	test = seqencer_initial();
	test.resolve(true, 2, 14, 0, false);
	test.commit(0);
	seqencer_display(test);
	test = seqencer_initial();
	test.resolve(true, 2, 14, 0, false);
	test.commit(2);
	seqencer_display(test);
	test = seqencer_initial();
	test.resolve(true, 2, 14, 0, false);
	test.commit(1);
	seqencer_display(test);

	test = seqencer_initial();
	test.resolve(true, 3, 14, 0, false);
	test.commit(0);
	seqencer_display(test);
	test = seqencer_initial();
	test.resolve(true, 3, 14, 0, false);
	test.commit(2);
	seqencer_display(test);
	test = seqencer_initial();
	test.resolve(true, 3, 14, 0, false);
	test.commit(1);
	seqencer_display(test);
}
// @ts-ignore
window.seqencer_selftest = seqencer_selftest;

interface BPLDev {
	dev: MemAccess,
	base: number,
}
class Backplane implements MemAccess {
	decode_hi:BPLDev[] = [];
	decode_io:IOAccess[] = [];
	constructor() {
	}
	readmeta(address: number): number {
		let aindex = address >> 8;
		let dev = this.decode_hi[aindex];
		if(dev) {
			return dev.dev.readmeta(address - dev.base);
		}
		return MEMSTAT.OPEN;
	}
	writemeta(address: number, value: number): void {
		let aindex = address >> 8;
		let dev = this.decode_hi[aindex];
		if(dev) {
			dev.dev.writemeta(address - dev.base, value);
			if ((address >= dis_ppc) && (address < dis_ppc_end)) {
				dis_meminval = show_dis;
			}
			if ((address >= memv_begin) && (address < memv_end)) {
				memv_after = show_mem;
			}
		}
	}
	configio(id:number, m:IOAccess) {
		this.decode_io[id] = m;
	}
	clearmemory(base:number, sz:number = 256) {
		let aval = base & 0x3ff00;
		let atarget = aval + sz;
		while (aval < atarget) {
			let aindex = aval >> 8;
			delete this.decode_hi[aindex];
			aval += 256;
		}
	}
	configmemory(base:number, m:MemAccess, sz:number = 256) {
		let aval = base & 0x3ff00;
		let atarget = aval + sz; // TODO
		let dev:BPLDev = {
			dev: m,
			base: aval,
		};
		while (aval < atarget) {
			let aindex = aval >> 8;
			if (this.decode_hi[aindex]) {
				//throw new Error('backplane overlap');
			}
			this.decode_hi[aindex] = dev;
			aval += 256;
		}
	}
	is_interrupt(cpl:number):boolean {
		for(let i = 0; i < this.decode_io.length; i++) {
			let dev = this.decode_io[i];
			if (dev.is_interrupt() && (dev.getlevel() > cpl)) return true;
		}
		return false;
	}
	ack_interrupt(cpl:number):number {
		for(let dev of this.decode_io) {
			if (dev.is_interrupt() && (dev.getlevel() > cpl)) {
				dev.acknowledge();
				return dev.getlevel();
			}
		}
		return 0;
	}
	reset() {
		for (let dev of this.decode_io) {
			dev.reset();
		}
	}
	readbyte(address:number):number {
		let aindex = address >> 8;
		let dev = this.decode_hi[aindex];
		if(dev) {
			let v = dev.dev.readbyte(address - dev.base);
			return v;
		}
		return 0x00;
	}
	writebyte(address:number, value:number):void {
		let aindex = address >> 8;
		let dev = this.decode_hi[aindex];
		if(dev) {
			dev.dev.writebyte(address - dev.base, value);
			if ((address >= dis_ppc) && (address < dis_ppc_end)) {
				dis_meminval = show_dis;
			}
			if ((address >= memv_begin) && (address < memv_end)) {
				memv_after = show_mem;
			}
		}
	}
}
const bpl = new Backplane();
interface DMAControl {
	read():number;
	write(value:number):void;
	end():void;
}

interface DMADevice {
	dma_request:boolean;
	dma_mask:number;
	dma_select(enable:boolean, dev:number):void;
	dma_step(ctrl:DMAControl):void;
}

interface ILevelRegisters {
	level: number; base: number;
	a: number, b: number,
	x: number, y: number, z: number,
	s: number, c: number, p: number,
	al: number, bl: number,
	xl: number, yl: number, zl: number,
	sl: number, cl: number, pl: number,
	au: number, bu: number,
	xu: number, yu: number, zu: number,
	su: number, cu: number, pu: number,
}
function LevelRegisters(level: number, rf: Uint8Array) {
	const base = level * 16;
	const regfile = rf;
	return Object.defineProperties({level, base}, {
		a :{get () { return (regfile[base] << 8) | regfile[base+1]; },
			set(v: number) {regfile[base] = (v >> 8) & 255; regfile[base+1] = v & 255; }},
		b :{get () { return (regfile[base+2] << 8) | regfile[base+3]; },
			set(v: number) {regfile[base+2] = (v >> 8) & 255; regfile[base+3] = v & 255; }},
		x :{get () { return (regfile[base+4] << 8) | regfile[base+5]; },
			set(v: number) {regfile[base+4] = (v >> 8) & 255; regfile[base+5] = v & 255; }},
		y :{get () { return (regfile[base+6] << 8) | regfile[base+7]; },
			set(v: number) {regfile[base+6] = (v >> 8) & 255; regfile[base+7] = v & 255; }},
		z :{get () { return (regfile[base+8] << 8) | regfile[base+9]; },
			set(v: number) {regfile[base+8] = (v >> 8) & 255; regfile[base+9] = v & 255; }},
		s :{get () { return (regfile[base+10] << 8) | regfile[base+11]; },
			set(v: number) {regfile[base+10] = (v >> 8) & 255; regfile[base+11] = v & 255; }},
		c :{get () { return (regfile[base+12] << 8) | regfile[base+13]; },
			set(v: number) {regfile[base+12] = (v >> 8) & 255; regfile[base+13] = v & 255; }},
		p :{get () { return (regfile[base+14] << 8) | regfile[base+15]; },
			set(v: number) {regfile[base+14] = (v >> 8) & 255; regfile[base+15] = v & 255; }},
		al:{get () { return regfile[base+1]; }, set(v: number) {regfile[base+1] = v; }},
		bl:{get () { return regfile[base+3]; }, set(v: number) {regfile[base+3] = v; }},
		xl:{get () { return regfile[base+5]; }, set(v: number) {regfile[base+5] = v; }},
		yl:{get () { return regfile[base+7]; }, set(v: number) {regfile[base+7] = v; }},
		zl:{get () { return regfile[base+9]; }, set(v: number) {regfile[base+9] = v; }},
		sl:{get () { return regfile[base+11]; }, set(v: number) {regfile[base+11] = v; }},
		cl:{get () { return regfile[base+13]; }, set(v: number) {regfile[base+13] = v; }},
		pl:{get () { return regfile[base+15]; }, set(v: number) {regfile[base+15] = v; }},
		ah:{get () { return regfile[base]; }, set(v: number) {regfile[base] = v; }},
		bh:{get () { return regfile[base+2]; }, set(v: number) {regfile[base+2] = v; }},
		xh:{get () { return regfile[base+4]; }, set(v: number) {regfile[base+4] = v; }},
		yh:{get () { return regfile[base+6]; }, set(v: number) {regfile[base+6] = v; }},
		zh:{get () { return regfile[base+8]; }, set(v: number) {regfile[base+8] = v; }},
		sh:{get () { return regfile[base+10]; }, set(v: number) {regfile[base+10] = v; }},
		ch:{get () { return regfile[base+12]; }, set(v: number) {regfile[base+12] = v; }},
		ph:{get () { return regfile[base+14]; }, set(v: number) {regfile[base+14] = v; }},
		au:{get () { return regfile[base]; }, set(v: number) {regfile[base] = v; }},
		bu:{get () { return regfile[base+2]; }, set(v: number) {regfile[base+2] = v; }},
		xu:{get () { return regfile[base+4]; }, set(v: number) {regfile[base+4] = v; }},
		yu:{get () { return regfile[base+6]; }, set(v: number) {regfile[base+6] = v; }},
		zu:{get () { return regfile[base+8]; }, set(v: number) {regfile[base+8] = v; }},
		su:{get () { return regfile[base+10]; }, set(v: number) {regfile[base+10] = v; }},
		cu:{get () { return regfile[base+12]; }, set(v: number) {regfile[base+12] = v; }},
		pu:{get () { return regfile[base+14]; }, set(v: number) {regfile[base+14] = v; }},
	}) as ILevelRegisters;
}

const CC_V = 128;
const CC_NV = 127;
const CC_M = 64;
const CC_NM = 191;
const CC_F = 32;
const CC_NF = 223;
const CC_L = 16;
const CC_NL = 239;

class Tracer {
	list:LTrace[] = [];
	count = 0;
	add(op:string, wh:number):LTrace {
		let c = this.count++;
		if(this.list.length < this.count) {
			const t = {op, wh};
			this.list.push(t);
			return t;
		} else {
			const t = this.list[c];
			t.op = op; t.wh = wh;
			delete t.tk;
			delete t.param;
			return t;
		}
	}
}
interface ICCPU {
	can_step:boolean;
	step(dbg:boolean):void;
	showstate(in_halt:boolean):void;
	reset():void;
}

function mcsetup() {

const s0 = new Sequencer();
const s1 = new Sequencer();
const s2 = new Sequencer();
const aluc= new ALU8();
let hsl_reg:number[] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
let hsl_regq:number = 0;
let mcpc = 0; // not a "true" register, simulates the microcode pipeline registers
let alu_flag = 0;
let ccr_f = 0;
let ccr_l = 0;
let ccr_m = 0;
let ccr_v = 0;
let ccr_fa = 0;
let ccr_la = 0;
let ccr_ma = 0;
let ccr_va = 0;
const regfile = new Uint8Array(256);
const pagetb = new Uint8Array(256);
let workaddr = 0;
let memaddr = 0;
let addr0a = 0;
let addr1a = 0;
let addr2a = 0;
let addr3a = 0;
let addr4a = 0;
let addr5a = 0;
let addr6a = 0;
let addr7a = 0;
let addr8a = 0;
let addr9a = 0;
let addr10a = 0;
let addr11a = 0;
let addr12a = 0;
let addr13a = 0;
let addr14a = 0;
let addr15a = 0;
let memdata_in = 0;
let memdata_out = 0;
let resetting:boolean = true;
let physaddr = 0;
let busctl = 0;
let sysctl = 0;
let abtac = 0;
let sys_write_latch = false;
let sys_read_in = false;
let cycles = 0;
let rtc = false;
let rtphase = 0;
let rtlast = 0;
let f12a = 0;
let f12b = 0;
let b15a = 1;
let dma_12 = 0;
let dma_sources:DMADevice[] = [];
let dma_current:undefined|DMADevice = undefined;
let swap = 0;
let result = 0;
let level = 0;
let level0a = 0;
let level1a = 0;
let level2a = 0;
let level3a = 0;
let reqlevel = 0;
let rir = 0;
let rdr = 0;
let pta = 0;
let pta1a = 0;
let pta2a = 0;
let pta3a = 0;
// memory access state:
let pindex = 0;
let pgram = 0;
let pgaddr = 0;
let is_mmio = 0;
let is_regmmio = 0;
let notpgbit = 0;
let is_mem = 0;

const vmbreak = new Uint8Array(65536);
type BreakFunction = (mode?:number, vaddress?:number, paddress?:number)=>boolean;
const break_list:(null | BreakFunction)[] = [
	null,
	function() { return true; }
];

const mpscache:{
	dp_sel:number,
	x_e6:number,
	x_k11:number,
	x_h11:number,
	x_e7:number,
	k9_en:boolean,
	k9_sel:number,
	mpconst_m6:number,
	j12_sel:number,
	j11_en:number,
	j11_sel:number,
	j13_sel:number,
	j10_en:number,
	j10_sel:number,
	k13_sel:number,
	seq_d0:number,
	seq_d1:number,
	seq_d2:number,
	seq_fci:number,
	seq0_si:number,
	seq12_s0i:number,
	seq2_si_k6b:number,
	seq1_si_k6dc:number,
	seq_branch:number,
	rir0:number,
	x_f6h6:number,
	x_c14_sel:boolean,
	aluc_s:number,
	aluc_f:number,
	aluc_d:number,
	busctld:number,
	busctla:number,
	busctlset:number,
	busctlmask:number,
	aluc_b:number,
	aluc_a:number,
}[] = [];

function loadcache() {
	for(let ro = 0; ro < 0x800; ro++) {
		const v6 = /*A*/uc.k[ro]; // MSB
		const v5 = /*B*/uc.f[ro];
		const v4 = /*C*/uc.h[ro];
		const v3 = /*D*/uc.l[ro];
		const v2 = /*E*/uc.m[ro];
		const v1 = /*F*/uc.j[ro];
		const v0 = /*H*/uc.e[ro]; // LSB
		const c0 = (v3 << 24) | (v2 << 16) | (v1 << 8) | v0;
		const c1 = (v6 << 16) | (v5 << 8) | v4;
		uc.c0[ro] = c0;
		uc.c1[ro] = c1;

		const dp_sel = v0 & 15;
		const x_e6 = (v0 >> 4) & 7;
		const x_k11 = (v0 >> 7) | ((v1 & 3) << 1);
		const x_h11 = (v1 >> 2) & 7;
		const x_e7 = (v1 >> 5) & 3;
		const k9_en = (v1>>7)&1;
		const k9_sel = v2 & 7;
		const mpconst_m6 = v2 ^ 0xff; // goes through a 74ls240
		const j12_sel = v2 & 3;
		const j11_en = (v2>>2)&1;
		const j11_sel = (v2>>3) & 3;
		const j13_sel = (v2>>4) & 3;
		const j10_en = (v2>>5)&1;
		const j10_sel = ((v2>>6) & 3) | ((v3&1) << 2);
		const k13_sel = (v2>>6) & 3;
		const seq_d0 = v2 & 15;
		const seq_d1 = v2 >> 4;
		const seq_d2 = v3 & 7;
		const seq_fci = (v3 >> 3) & 3; // TODO verify FE/PUP
		const seq0_si = (v3 >> 5) & 3;
		const seq12_s0i = (v3>>7)&1; // TODO verify
		const seq2_si_k6b = seq12_s0i | ((v4&1) << 1); // TODO verify
		const seq1_si_k6dc = seq12_s0i | (2 ^ (2 & (v6>>5) & ((v4<<1) ^ 2)));
		const seq_branch = (v4>>1)&1;
		const rir0 = (v6>>5)&1;
		const x_f6h6 = (v6 >> 3) & 3;
		const x_c14_sel = (v6>>7)&1/* !=0 */;
		const aluc_s = (v4>>2) & 7;
		const aluc_f = (v4>>5) & 7;
		const aluc_d = v5 & 7;
		const busctld = (v5>>3)&1;
		const busctla = (v5>>4) & 7;
		const busctlset = busctld << busctla;
		const busctlmask = (1 << busctla) ^ 255;
		const aluc_b = (v5>>3) & 15;
		const aluc_a = ((v6<<1)|(v5>>7)) & 15;

		mpscache[ro] = {
			dp_sel,
			x_e6,
			x_k11,
			x_h11,
			x_e7,
			k9_en: k9_en == 0,
			k9_sel,
			mpconst_m6,
			j12_sel,
			j11_en,
			j11_sel,
			j13_sel,
			j10_en,
			j10_sel,
			k13_sel,
			seq_d0,
			seq_d1,
			seq_d2,
			seq_fci,
			seq0_si: 3^seq0_si,
			seq12_s0i,
			seq2_si_k6b: 3^seq2_si_k6b,
			seq1_si_k6dc: 3^seq1_si_k6dc,
			seq_branch,
			rir0,
			x_f6h6,
			x_c14_sel: x_c14_sel!=0,
			aluc_s,
			aluc_f,
			aluc_d,
			busctld,
			busctla,
			busctlset,
			busctlmask,
			aluc_b,
			aluc_a,
		};
	}
}
loadcache();
class MCCPU implements ICCPU {
	can_step = true;
	trace = new Tracer();
	trace_enable = false;
	registers = [
		LevelRegisters(0, regfile), LevelRegisters(1, regfile),
		LevelRegisters(2, regfile), LevelRegisters(3, regfile),
		LevelRegisters(4, regfile), LevelRegisters(5, regfile),
		LevelRegisters(6, regfile), LevelRegisters(7, regfile),
		LevelRegisters(8, regfile), LevelRegisters(9, regfile),
		LevelRegisters(10, regfile), LevelRegisters(11, regfile),
		LevelRegisters(12, regfile), LevelRegisters(13, regfile),
		LevelRegisters(14, regfile), LevelRegisters(15, regfile),
	];
	get cc():number {
		return (ccr_v?CC_V:0)|(ccr_m?CC_M:0)|(ccr_f?CC_F:0)|(ccr_l?CC_L:0);
	}
	set cc(value:number) {
		ccr_v = (value & CC_V)!=0?1:0;
		ccr_m = (value & CC_M)!=0?1:0;
		ccr_f = (value & CC_F)!=0?1:0;
		ccr_l = (value & CC_L)!=0?1:0;
	}
	get reg() { return this.registers[level]; }
	get level() { return level; }
	set level(value:number) { level = value & 15; }
	get map() { return pta; }
	set map(value:number) { pta = value & 7; };
	get pc() {
		if(this.at_boundry) return memaddr;
		return last_pc;
	}
	get at_boundry() { return mcpc == 0x101 || mcpc == 0x100; }
	set_pc(va:number):void {
		if(!this.at_boundry) {
			throw new Error("unsupported state");
		}
		memaddr = va & 65535;
		mempt_set();
	}
	get page_ram() { return pagetb; }
	change_virtual_break(old_f:null | number | BreakFunction, new_f:BreakFunction) {
		let o;
		if(typeof new_f != 'function') {
			throw new Error('new_f must be a function');
		}
		if(typeof old_f == 'number') {
			o = old_f | 0;
			if(o < 0 || o > 255) throw new Error('Invalid function ID');
			old_f = break_list[o];
			if(old_f == null) throw new Error('Invalid function ID');
		} else if (typeof old_f == 'function') {
			o = break_list.indexOf(old_f);
			if(o < 1 || o > 255) throw new Error('Invalid function ID');
		} else {
			throw new Error('Invalid break function or function ID');
		}
		new_f(-1, 0, 0);
		break_list[o] = new_f;
	}
	add_virtual_break(address:number, f:null | number | BreakFunction):number {
		let i;
		if(typeof address != 'number') throw new Error('Invalid address');
		if(address < 0 || address > 65535) throw new Error('Invalid address');
		if(vmbreak[address] != 0) throw new Error('Address already set');
		if(typeof f == 'number') {
			i = f | 0;
			if(i < 0 || i > 255) throw new Error('Invalid break point');
			f = break_list[i];
			if(f == null) throw new Error('Invalid break point');
		} else if (typeof f == 'function') {
			i = break_list.indexOf(f);
		} else {
			throw new Error('Invalid break function or function ID');
		}
		if(i == -1) {
			i = break_list.indexOf(null, 1);
			if(i == -1) i = break_list.length;
			if(i > 255) throw new Error('Too many break points');
			f(-1, address, 0);
			break_list[i] = f;
		}
		vmbreak[address] = i;
		return i;
	}
	remove_break_at(address: number) {
		vmbreak[address] = 0;
	}
	remove_break(f:null | number | BreakFunction) {
		let i:number;
		if(f == null) return;
		if(typeof f == 'number') {
			i = f | 0;
			if(i < 2 || i > 255) throw new Error('Invalid break point');
			if(break_list[i] == null) return;
		} else if (typeof f == 'function') {
			i = break_list.indexOf(f);
		} else {
			throw new Error('Invalid break function or function ID');
		}
		if(i > -1 && i != 1) break_list[i] = null;
	}
	step = step;
	hsstep = hsstep;
	hspre = hspre;
	hsend = hsend;
	showstate = showstate;
	reset = reset;
	dma_register = dma_register;
	dma_request = dma_request;
	dma_int(dev:DMADevice, en:boolean) {
		const n = dev.dma_mask ^ 0xffffffff;
		dma_12 = (dma_12 & n) | (en ? dev.dma_mask : 0);
	}
	dma_end = false;
	get physaddr() { return physaddr; }
	get memaddr() { return memaddr; }
	parity = 0
	memfault = 0
}
const mco = new MCCPU();

function dma_selection(enable:boolean, dev:number):void {
	for(let i = 0; i < dma_sources.length; i++) {
		const device = dma_sources[i];
		device.dma_select(enable, dev);
	}
}

function reset() {
	s0.reset();
	s1.reset();
	s2.reset();
	mcpc = 0;
	result = 0;
	swap = 0;
	level = 0;
	sysctl = 0;
	busctl = 0;
	resetting = true;
	sys_write_latch = false;
	sys_read_in = false;
	mco.parity = 0;
	dma_12 = 0;
	cycles = 0;
	bpl.reset();
	dma_selection(false, 0);
	while(dma_current != undefined) {
		dma_control.end();
	}
}

const enum CCR {
	CARRY = 1, L = 1, BIT_L = 0,
	OVER = 2, F = 2, BIT_F = 1,
	SIGN = 4, M = 4, BIT_M = 2,
	ZERO = 8, V = 8, BIT_V = 3,
};

function showstate(in_halt:boolean) {
	if(show_int) {
		let mcp = s2.output.toString(16) + s1.output.toString(16) + s0.output.toString(16);
		let mpc = s2.p.toString(16) + s1.p.toString(16) + s0.p.toString(16);
		let mhr = s2.h.toString(16) + s1.h.toString(16) + s0.h.toString(16);
		let mstk = '';
		let msp0 = s0.sp, msp1 = s1.sp, msp2 = s2.sp;
		let fl = alu_flag;
		let malu1 = hex(aluc.regq, 2) +
		` ${hex(fl,2)} ${(fl&0x20)!=0?'L':'-'}${(fl&0x10)!=0?'H':'-'}${(fl&8)!=0?'C':'-'}${(fl&4)!=0?'V':'-'}${(fl&2)!=0?'S':'-'}${(fl&1)!=0?'Z':'-'}`;
		let malu2 = '';
		let malu3 = '';
		for(let i=0;i<4;i++) {
			mstk += s2.sf[msp2].toString(16) + s1.sf[msp1].toString(16) + s0.sf[msp0].toString(16) + ' ';
			msp0 = (msp0 - 1) & 3;
			msp1 = (msp1 - 1) & 3;
			msp2 = (msp2 - 1) & 3;
		}
		for(let i=0;i<8;i++) {
			malu2 += hex(aluc.reg[i], 2) + ' ';
			malu3 += hex(aluc.reg[i+8], 2) + ' ';
		}
		mcs_alu.innerText = malu1;
		mcs_alu2.innerText = malu2;
		mcs_alu3.innerText = malu3;
		mcs_p.innerText = `${mcp} ${mpc} ${mhr}`;
		mcs_s.innerText = mstk;
		mcr_res.innerText = hex(result, 2);
		mcr_swap.innerText = hex(swap, 2);
		mcr_level.innerText = hex(level, 1);
		mcr_rfir.innerText = hex(rir);
		mcr_rfdr.innerText = hex(rdr);
		mcr_pta.innerText = hex(pta, 1);
		mcr_dat_in.innerText = hex(memdata_in);
		mcr_dat_out.innerText = hex(memdata_out);
		const bc = busctl;
		const sc = sysctl;
		mcr_bus.innerText = `${(bc&1)!=0?'I':'-'} ${(bc&128)!=0?'DMA':'---'
		} ${(bc&16)!=0?'DA':'--'} ${(bc&4)!=0?'--':'CE'
		} ${(bc&8)!=0?'U':'D'} ${(bc&32)!=0?'PO':'PE'
		} ${(bc&64)!=0?'PFE':'---'}${(bc&2)!=0?' !AdrH':''}`;
		mcr_sys.innerText = `DV${sc&3} ${(sc&4)>0?'TE':'--'
		}${(sc&8)!=0?' !Map':''} ${(sc&16)!=0?'R':'H'
		} ${(sc&32)!=0?'--':'TR'} ${(sc&64)!=0?'A':'-'
		} ${(sc&128)!=0?'IA':'--'}`;
		mcr_addr.innerText = `${hex(workaddr, 4)} ${hex(memaddr, 4)
		} ${((pgram & 128) != 0 ? '*' : '.')}${hex(physaddr, 5)}`;
	}
	
	if(show_reg) {
		let sindex = 0;
		for(let rindex = 0;rindex < 256;rindex += 32) {
			for(let i=0;i<32;i+=2) {
				let reg = (regfile[rindex + i] << 8) | regfile[rindex + i+1];
				if(reg != mcr_file_v[sindex]) {
					mcr_file_v[sindex] = reg;
					mcr_file[sindex].innerText = hex(reg, 4);
				}
				sindex++;
			}
		}
	}

	const is_running = (sysctl & 16) != 0;
	style_if(fp_runhalt[0],'a',is_running); // run
	style_if(fp_runhalt[1],'a',!is_running); // halt

	style_if(fp_ext[0],'active',run_step);
	style_if(fp_ext[2],'a',mco.memfault != 0);

	cx_map.clearRect(0, 0, cv_map.width, cv_map.height);
	cx_addr.clearRect(0, 0, cv_addr.width, cv_addr.height);
	const baseline = 22;

	let hrr2 = run_rate >> 1;
	if (in_halt) {
		hrr2 = 0;
		abtac = (sysctl & 64) != 0 ? 1 : 0;
		ccr_fa = ccr_f;
		ccr_la = ccr_l;
		ccr_ma = ccr_m;
		ccr_va = ccr_v;
		pta1a = pta & 1;
		pta2a = (pta >> 1) & 1;
		pta3a = (pta >> 2) & 1;
		addr0a = memaddr & 1;
		addr1a = (memaddr>>1) & 1;
		addr2a = (memaddr>>2) & 1;
		addr3a = (memaddr>>3) & 1;
		addr4a = (memaddr>>4) & 1;
		addr5a = (memaddr>>5) & 1;
		addr6a = (memaddr>>6) & 1;
		addr7a = (memaddr>>7) & 1;
		addr8a = (memaddr>>8) & 1;
		addr9a = (memaddr>>9) & 1;
		addr10a = (memaddr>>10) & 1;
		addr11a = (memaddr>>11) & 1;
		addr12a = (memaddr>>12) & 1;
		addr13a = (memaddr>>13) & 1;
		addr14a = (memaddr>>14) & 1;
		addr15a = (memaddr>>15) & 1;
		level0a = level & 1;
		level1a = (level>>1) & 1;
		level2a = (level>>2) & 1;
		level3a = (level>>3) & 1;
	}
	let hrr1 = hrr2 >> 1;
	let hrr05 = hrr1 >> 1;
	let hrr3 = hrr2 + hrr1;
	function ledcolor(v:number):string {
		if (v > hrr2) {
			if (v > hrr3) {
				return '#ff3232';
			} else if(v > hrr2 + hrr05) {
				return '#c01c1c';
			} else return '#a81c1c';
		} else if (v > hrr1) {
			if(v > hrr1 + hrr05) return '#901c1c';
			else return '#701c1c';
		} else if(v > hrr05) {
			return '#400c0c';
		} else return '#200c0c';
	}
	function drawaddr(v:number, x:number, t:string) {
		if (v > 0) {
			cx_addr.fillStyle = ledcolor(v);
			cx_addr.fillRect(x, 0, 12, 30);
		}
		cx_addr.fillStyle = '#aeaeae';
		cx_addr.fillText(t, x + 2, baseline);
	}
	function drawfill(v:number, x:number, t:string) {
		if (v > 0) {
			cx_map.fillStyle = ledcolor(v);
			cx_map.fillRect(x, 0, 16, 30);
		}
		cx_map.fillStyle = '#aeaeae';
		cx_map.fillText(t, x + 2, baseline);
	}
	drawaddr(addr15a, 0, '8');
	drawaddr(addr14a, 12, '4');
	drawaddr(addr13a, 24, '2');
	drawaddr(addr12a, 36, '1');
	drawaddr(addr11a, 50, '8');
	drawaddr(addr10a, 62, '4');
	drawaddr(addr9a, 74, '2');
	drawaddr(addr8a, 86, '1');
	drawaddr(addr7a, 100, '8');
	drawaddr(addr6a, 112, '4');
	drawaddr(addr5a, 124, '2');
	drawaddr(addr4a, 136, '1');
	drawaddr(addr3a, 150, '8');
	drawaddr(addr2a, 162, '4');
	drawaddr(addr1a, 174, '2');
	drawaddr(addr0a, 186, '1');
	drawfill(level3a, 10, '8');
	drawfill(level2a, 26, '4');
	drawfill(level1a, 42, '2');
	drawfill(level0a, 58, '1');
	if (abtac > 0) {
		cx_map.fillStyle = ledcolor(abtac);
		cx_map.fillRect(80, 0, 48, 30);
	}
	cx_map.fillStyle = '#aeaeae';
	cx_map.fillText('ABT', 88, baseline);
	drawfill(pta3a, 130, '4');
	drawfill(pta2a, 146, '2');
	drawfill(pta1a, 162, '1');
	drawfill(ccr_fa, 178, 'F');
	drawfill(ccr_la, 194, 'L');
	drawfill(ccr_ma, 210, 'M');
	drawfill(ccr_va, 226, 'V');

	abtac = 0;
	ccr_va = 0; ccr_fa = 0; ccr_la = 0; ccr_ma = 0;
	pta1a = 0; pta2a = 0; pta3a = 0;
	addr15a = 0; addr14a = 0; addr13a = 0; addr12a = 0;
	addr11a = 0; addr10a = 0; addr9a  = 0; addr8a  = 0;
	addr7a  = 0; addr6a  = 0; addr5a  = 0; addr4a  = 0;
	addr3a  = 0; addr2a  = 0; addr1a  = 0; addr0a  = 0;
	level0a = 0; level1a = 0; level2a = 0; level3a = 0;

	const ptindex = pta << 5;
	if(show_page) {
		for (let k = 0; k < 4; k++) {
			let pgt = '';
			const psubindex = ptindex | (k << 3);
			for (let i = 0; i < 8; i++) {
				const page = pagetb[psubindex | i];
				const pf = (page & 128) != 0;
				pgt += (pf ? '*':'.') + hex((page & 127) << 3, 3) + ' ';
			}
			mcpage[k].innerText = pgt;
		}
	}
}

///////////////////////////////// Microcode stepping ////////////////////////////////////

// fast delay:
// 3ec 40 1B FFF8 92 800D orig
//     40 23 FFF8 fc 800D fast
// 3ed 40 23 7E11E1E00D orig
//     40 1b 7E11E1E00D fast
// uc.f[0x3ec] = 0x23;
// uc.m[0x3ec] = 0x01;
// uc.f[0x3ed] = 0x1b;

function mempt_set() {
	pindex = ((memaddr >> 11) & 31) | (pta << 5);
	pgram = pagetb[pindex];
	const pgaddr7 = pgram & 127;
	pgaddr = pgaddr7 | (((pgaddr7 & 112) == 112) ? 128 : 0);
	is_mmio = ((pgram & 253) == 253) ? 0 : 1;
	const is_reg = ((pgaddr7 == 0) && ((memaddr & 1792) == 0)) ? 0 : 1;
	is_regmmio = (is_reg & is_mmio) ^ 1;
	notpgbit = (pgram >> 7) ^ 1;
	is_mem = (is_reg & notpgbit) ^ 1;
	physaddr = (pgaddr7 << 11) | (memaddr & 0x7ff);
}

function dma_register(device:DMADevice):void {
	device.dma_mask = 1 << dma_sources.length;
	dma_sources.push(device);
}

const dma_control:DMAControl = {
	read():number {
		let v = bpl.readbyte(physaddr);
		const count_up = (busctl & 8)!=0;
		workaddr = (workaddr + (count_up?1:-1)) & 0xffff;
		memaddr = (memaddr + (count_up?1:-1)) & 0xffff;
		mempt_set();
		return v;
	},
	write(value:number):void {
		bpl.writebyte(physaddr, value);
		const count_up = (busctl & 8)!=0;
		workaddr = (workaddr + (count_up?1:-1)) & 0xffff;
		memaddr = (memaddr + (count_up?1:-1)) & 0xffff;
		mempt_set();
	},
	end():void {
		if(dma_current) dma_current.dma_request = false;
		dma_current = undefined;
		for(let i = 0; i < dma_sources.length; i++) {
			const device = dma_sources[i];
			if(device.dma_request) {
				dma_current = device;
				break;
			}
		}
	}
};
function dma_request():number {
	if (dma_current) {
		return 1;
	}
	for(let i = 0; i < dma_sources.length; i++) {
		const device = dma_sources[i];
		if(device.dma_request) {
			dma_current = device;
			return 1;
		}
	}
	return 0;
}

function hspre() {
	for(let i = 0; i < 16; i++) {
		hsl_reg[i] = aluc.reg[i];
	}
	hsl_regq = aluc.regq;
}
function hsend() {
	for(let i = 0; i < 16; i++) {
		aluc.reg[i] = hsl_reg[i];
	}
	aluc.regq = hsl_regq
}
// this function is a variant that favours speed
function hsstep() {

	const mci = mpscache[mcpc];

	const intena = (busctl & 1) != 0;
	const sysint = reqlevel;
	const dmaint = intena && (level < 2) && (dma_12 != 0);
	const count_up = (busctl & 8)!=0;

	if(mcpc == 0x101) {
		last_pc = memaddr;
		last_map = pta;
	}
	if ((run_step && (mcpc == 0x101)) || mclisting[mcpc].bp) {
		if(handle_break()) return;
	}

	let is_jsr = 0;
	if (mci.k9_en) {
		switch(mci.k9_sel) {
		case 0: /* TODO f12b */ is_jsr = 1; break;
		case 1: /* rir.0 nor 4 */
			is_jsr = ((rir | (rir >> 4)) & 1)^1; break;
		case 2: /* rir.0 */ is_jsr = rir & 1; break;
		case 3: /* mmio/reg */
			is_jsr = is_regmmio; break;
		case 4: /* REG/pbit */ is_jsr = is_mem; break;
		case 5: /* DMA P2.13 */ is_jsr = dma_request(); break;
		case 6: /* TODO B15A */ is_jsr = b15a ^ 1; break;
		case 7: /* TODO F13->H13A any INT */
			is_jsr = dma_request();
			if (dmaint || (intena && bpl.is_interrupt(level))) {
				is_jsr = 1;
			}
			if (rtc && ((sysctl & 0x4) != 0)) {
				is_jsr = 1;
			}
			break;
		}
	}
	// branch and condition selectors
	let seq_or = 0;

	// seqencer control
	let seq0_s = mci.seq0_si;
	let seq1_s = mci.seq1_si_k6dc;
	let seq2_s = mci.seq2_si_k6b;
	let seq_fc = mci.seq_fci;
	if(is_jsr != 0) {
		seq0_s = 3;
		seq1_s = 3;
		seq2_s = 3;
		seq_fc &= 2;
	}

	let datapath = 0;
	// Data Path Control
	switch(mci.dp_sel) {
	case 0: case 4: // R_SWP ⇒ DP
		datapath = swap; break;
	case 1: case 5: // R_REG(d13) ⇒ DP
		datapath = rdr; break;
	case 2: case 6: // R_ADM(rawH) ⇒ DP
		datapath = ((memaddr >> 8) & 255) ^ 0xf0; break;
	case 3: case 7: // R_ADL ⇒ DP
		datapath = memaddr & 255; break;
	case 8: // R_AddrPH ⇒ DP
		datapath = pgaddr; break;
	case 9: // CCR:sense ⇒ DP
		// sense_switch inverted on bus
		datapath = ((ccr_l << 4) | (ccr_f << 5) | (ccr_m << 6) | (ccr_v << 7) | sense_switch) ^ 0xf0 /* sense sw */; break;
	case 10: // R_SysDLatch ⇒ DP
		datapath = memdata_in; break;
	case 11: // R_H14 ⇒ DP // TODO rest of H14? beware invertions
		datapath = (level << 4) | 4 |
		(resetting ? 2 : 0) | notpgbit |
		(dmaint ? 8 : 0);
		if(resetting) resetting = false;
		break;
	case 12: // R_DLI (int7..4:dipsw3..1[RHI]:RTINT) ⇒ DP
		datapath = ((sysint & 15) << 4) | dswitch | ((rtc && ((sysctl & 0x4) != 0)) ? 1 : 0);
		break;
	case 13: // RCnst MCv2 ⇒ DP
		datapath = mci.mpconst_m6;
		break;
	// __ncE N/C
	// __ncF N/C
	}

	let hsl_y:number = 0;
	let hsl_carry_in:number = 0;
	let hsl_main_carry_out:number = 0; // bit 1<<3

	switch(mci.x_f6h6) {
	case 0: hsl_carry_in = 0; break;
	case 1: hsl_carry_in = 1; break;
	case 2: hsl_carry_in = (alu_flag >> 3) & 1; break;
	case 3: hsl_carry_in = 0; break;
	}
	//hsl_resolve_alu(mci.aluc_s, mci.aluc_f, mci.aluc_d, mci.aluc_a, mci.aluc_b);
	// perform logic flow
	const fn = ALU_F[mci.aluc_f];
	let val_r:number = 0;
	let val_s:number = 0;
	switch(mci.aluc_s) {
	case 0: val_r = hsl_reg[mci.aluc_a]; val_s = hsl_regq; break;
	case 1: val_r = hsl_reg[mci.aluc_a]; val_s = hsl_reg[mci.aluc_b]; break;
	case 2: val_r = 0; val_s = hsl_regq; break;
	case 3: val_r = 0; val_s = hsl_reg[mci.aluc_b]; break;
	case 4: val_r = 0; val_s = hsl_reg[mci.aluc_a]; break;
	case 5: val_r = datapath; val_s = hsl_reg[mci.aluc_a]; break;
	case 6: val_r = datapath; val_s = hsl_regq; break;
	case 7: val_r = datapath; val_s = 0; break;
	}
	val_r = fn.ivr ? 255^val_r : val_r;
	val_s = fn.ivs ? 255^val_s : val_s;
	//let out = 0;
	switch(fn.on) { // [+ & | ⊻]
	case 0: // subtraction is just addition with inverted inputs
		hsl_y = val_r + val_s + hsl_carry_in;
		hsl_main_carry_out = (hsl_y > 255) ? 8 : 0;
		break;
	case 1: hsl_y = val_r | val_s; break;
	case 2: hsl_y = val_r & val_s; break;
	case 3: hsl_y = val_r ^ val_s; break;
	default: hsl_y = 0;
	}
	hsl_y &= 255;

	let data_f: number;
	if (mci.x_h11 == 6) {// Select MAPROM to F
		data_f = uc.map[datapath];
	} else if (mci.aluc_d == 2) {
		data_f = hsl_reg[mci.aluc_a] & 255; // select A to the bus output
	} else {
		data_f = hsl_y;
	}
	let hsl_ram0:number = 0;
	let hsl_ram7:number = 0;
	let hsl_q0:number = 0;
	let hsl_q7:number = 0;
	if(mci.aluc_d > 3) {
		if((mci.aluc_d & 2) == 0) {
			hsl_q0 = hsl_regq & 1;
			hsl_ram0 = hsl_y & 1;
			// >> 3.h.0 >> 3.l.0 >>
			switch(mci.x_f6h6) { // h6.Za
			case 0: hsl_ram7 = hsl_y&128; break;
			case 1: hsl_ram7 = ((alu_flag << 4) & 128); break;
			case 2: hsl_ram7 = hsl_q0<<7; break;
			case 3: hsl_ram7 = hsl_main_carry_out<<4; break;
			}
			hsl_q7 = hsl_ram0<<7;
		} else {
			hsl_q7 = hsl_regq & 128;
			hsl_ram7 = hsl_y & 128;
			// << 3.h.0 << 3.l.0 <<
			switch(mci.x_f6h6) { // h6.Zb
			case 0: break;
			case 1: hsl_q0 = ((alu_flag >> 3) & 1); break;
			case 2: hsl_q0 = hsl_y>>7; break;
			case 3: hsl_q0 = 1; break;
			}
			hsl_ram0 = hsl_q7 >> 7;
		}
	}
	// uses ALU flags, so must be after comb logic resolve
	if (mci.seq_branch == 0) {
		switch(mci.j13_sel) {
		case 0: // |1 IF ALUF.S, |2 IF ALUF.Z
			seq_or |= ((alu_flag & 2)!=0 ?1:0);
			seq_or |= ((alu_flag & 1)!=0 ?2:0);
			break;
		case 1: // |1 IF ALUF.H, |2 IF ALUF.V
			seq_or |= ((alu_flag & 16)!=0 ?1:0);
			seq_or |= ((alu_flag & 4)!=0 ?2:0);
			break;
		case 2: // |1 IF ~pbit, |2 IF ~MMIO
			seq_or |= notpgbit | (is_mmio << 1);
			break;
		case 3: break; // nop
		}

		switch(mci.k13_sel) { // mind the strange order of OR2/3 (|4 |8)
		case 0: // |4 IF INT_EN, |8 IF CCR.Carry (Link)
			if (intena) seq_or |= 4;
			if (ccr_l != 0) seq_or |= 8;
			break;
		case 1: // |4 IF DMA_INT, |8 IF INT_REQ
			if (!dmaint) seq_or |= 4;
			if (!(intena && bpl.is_interrupt(level))) seq_or |= 8;
			break;
		case 2: // |4 IF MEM_INT, |8 IF DMA_REQ
			//seq_or |= 4; // TODO typically low
			if (!dma_request()) seq_or |= 8;
			break;
		case 3: break; // nop
		}
	}

	let rindex;
	if (mci.x_c14_sel) {
		rindex = (rir & 15) | (level << 4);
	} else {
		rindex = rir & 255;
	}
	// rindex bit 0, this is technically a NOR
	// but can be handled as needed because this is the only reference
	rindex = rindex | mci.rir0; // I elected to not invert it, since the debug dump would have anyways

	////////////////////////////// rising clock edge /////////////////////////////

	const prevwork = workaddr;
	const prevflag = alu_flag;
	switch(mci.x_k11) {
	case 0: break; // nop
	case 1: mco.dma_end = false; break; // L13A_SET
	case 2: // ?K11_2
		if ((mci.busctlset == 128) && ((sysctl & 128) == 0)) {
			reqlevel = bpl.ack_interrupt(level);
		}
		if ((mci.busctlmask == 127) && ((sysctl & 128) == 128)) {
			reqlevel = 0;
		}
		sysctl = (sysctl & mci.busctlmask) | mci.busctlset;
		if(mci.busctla < 2) dma_selection((busctl & 128)!=0, sysctl & 3);
		break;
	case 3: // BusCtl
		busctl = (busctl & mci.busctlmask) | mci.busctlset;
		if(mci.busctla == 7) dma_selection((busctl & 128)!=0, sysctl & 3);
		mco.parity = (busctl >> 5) & 1;
		break;
	case 4: // REG_WR
		regfile[rindex] = result;
		break;
	case 5: // PTR_WR
		pagetb[pindex] = result;
		mempt_set();
		break;
	case 6: // WADL_WR
		if (mci.x_e6 == 5) {
			workaddr = (workaddr & 0xff00) | (memaddr & 0xff);
		} else {
			workaddr = (workaddr & 0xff00) | result;
		}
		break;
	case 7: // BusD_WR
		memdata_out = data_f;
		sys_write_latch = true;
		break;
	}

	// timer
	cycles++;
	if(cycles >= 2000 && CONFIG.cpu[2] == 1 && (sysctl & 0x20) != 0) {
		let n = Date.now();
		cycles = 0;
		if(n >= rtlast) {
			rtphase++;
			rtc = true;
			if(rtphase == 15) {
				rtphase = 0;
				rtlast += 12;
			} else {
				rtlast += 17;
			}
			if(n > rtlast + 1000) {
				rtlast = Date.now();
			}
		}
	}
	if (cycles >= 83333) {
		cycles = 0;
		if (CONFIG.cpu[2] == 0 && (sysctl & 0x20) != 0) {
			rtc = true;
			rtlast = Date.now();
		}
	}
	if ((sysctl & 0x20) == 0) {
		rtc = false;
	}

	rdr = regfile[rindex];

	switch(mci.x_e7) {
	case 0: break; // nop
	case 1: break; // TODO: BusReady
	case 2: // ALUFlag_LD
	{
		let hsl_over:number = 0;/* bit 1<<2 */
		let hsl_half_carry_out:number = 0; // bit 1<<4
		switch(fn.on) { // [+ & | ⊻]
		case 0:
			hsl_half_carry_out = (((val_r & 15) + (val_s & 15) + hsl_carry_in) > 15) ? 1<<4 : 0;
			if(((val_r & 127) + (val_s & 127) + hsl_carry_in) > 127) {
				hsl_over = (hsl_main_carry_out ^ 8)>>1;
			} else {
				hsl_over = hsl_main_carry_out>>1;
			}
			break;
		case 1:
			hsl_half_carry_out = (hsl_y&15)==15 ? hsl_carry_in<<4 : 16;
			if(hsl_y==255) {
				hsl_over = hsl_carry_in<<2;
				hsl_main_carry_out = hsl_carry_in<<3;
			} else {
				hsl_over = 4;
				hsl_main_carry_out = 8;
			}
			break;
		case 2:
			hsl_half_carry_out = (hsl_y&15)!=0 ? 16 : (hsl_carry_in<<4);
			if(hsl_y!=0) {
				hsl_over = 4;
				hsl_main_carry_out = 8;
			} else {
				hsl_over = hsl_carry_in<<2;
				hsl_main_carry_out = hsl_carry_in<<3;
			}
			break;
		}
		alu_flag = ((hsl_y == 0) ? 1 : 0) | (hsl_y > 127 ? 2:0) | hsl_over |
		hsl_main_carry_out | hsl_half_carry_out | ((prevflag & 1) << 5);
		break;
	}
	case 3: // DataRD
		if (sys_write_latch) {
			memdata_in = memdata_out;
		} else if(sys_read_in) {
			mco.memfault = 0;
			memdata_in = bpl.readbyte(physaddr);
			if ((busctl & 0x40) != 0) {
				b15a = mco.memfault ^ 1;
			} else {
				b15a = 1;
			}
		}
		sys_write_latch = false;
		sys_read_in = false;
		break;
	}

	let c = s0.resolve(true, seq0_s, mci.seq_d0, seq_or, false);
	c = s1.resolve(c, seq1_s, mci.seq_d1, 0, false);
	s2.resolve(c, seq2_s, mci.seq_d2, 0, false);
	s0.commit(seq_fc);
	s1.commit(seq_fc);
	s2.commit(seq_fc);

	if (((busctl & 20) == 16) && dma_current != null) {
		if(!dma_current.dma_request) {
			dma_control.end();
		} else {
			dma_current.dma_step(dma_control);
		}
		if(workaddr == 0xffff) mco.dma_end = true;
	}
	switch(mci.x_h11) {
	case 0: break; // nop
	case 1: // RD_START /* TODO */
		sys_read_in = true;
		break;
	case 2: // WT_START /* TODO */
		bpl.writebyte(physaddr, memdata_out);
		break;
	case 3: // WorkAddr_LDH
		if (mci.x_e6 == 5) {
			workaddr = (workaddr & 0x00ff) | (memaddr & 0xff00);
		} else {
			workaddr = (workaddr & 0x00ff) | (result << 8);
		}
		break;
	case 4: // WorkAddr_Count
		workaddr = (workaddr + (count_up?1:-1)) & 0xffff;
		break;
	case 5: // MemAddr_Count
		memaddr = (memaddr + (count_up?1:-1)) & 0xffff;
		mempt_set();
		break;
	case 6: break; // F=MapROM - handled farther above
	case 7: // NibSwap
		swap = ((datapath << 4) | (datapath >> 4)) & 255;
		break;
	}

	switch(mci.x_e6) {
	// no case 0
	case 1: result = data_f; break; // F⇒Result
	case 2: rir = data_f; break; // F⇒RIdx
	case 3: level = data_f >> 4; break; // F⇒Level
	case 4: pta = data_f & 7; mempt_set(); break; // F⇒PTA
	case 5: memaddr = prevwork; mempt_set(); break; // ASwap
	case 6: // SEQ_RE
		s0.h = data_f & 15;
		s1.h = (data_f >> 4) & 15;
		break;
	case 7: // conditions register
		switch(mci.j12_sel) {
		case 0: break;
		case 1:
			ccr_v = prevflag & 1;
			ccr_m = (prevflag >> 1) & 1;
			break;
		case 2:
			ccr_v = (result >> 7) & 1;
			ccr_m = (result >> 6) & 1;
			break;
		case 3:
			ccr_v = (prevflag & (prevflag >> 5)) & 1;
			ccr_m = (prevflag >> 1) & 1;
			break;
		}
		if (mci.j11_en == 0) {
			switch(mci.j11_sel | (prevflag & 0x4)) {
			case 0: ccr_f = (result >> 5) & 1; break;
			case 1: ccr_f = 1; break;
			case 2: break;
			case 3: ccr_f = 0; break;
			case 4: ccr_f = (result >> 5) & 1; break;
			case 5: ccr_f = 1; break;
			case 6: break;
			case 7: ccr_f = 1; break;
			}
		} else {
			ccr_f = 0;
		}
		if (mci.j10_en == 0) {
			switch(mci.j10_sel) {
			case 0: break;
			case 1: ccr_l = ccr_l ^ 1; break;
			case 2: ccr_l = (prevflag >> 3) & 1; break;
			case 3: ccr_l = 1; break;
			case 4: ccr_l = (result >> 4) & 1; break;
			case 5: ccr_l = hsl_ram7 >> 7; break;
			case 6: ccr_l = hsl_ram0; break;
			case 7: ccr_l = hsl_q0; break;
			}
		} else {
			ccr_l = 0;
		}
		break;
	}
	abtac += (sysctl >> 6) & 1;
	ccr_la += ccr_l;
	ccr_fa += ccr_f;
	ccr_ma += ccr_m;
	ccr_va += ccr_v;
	pta1a += pta & 1;
	pta2a += (pta >> 1) & 1;
	pta3a += (pta >> 2) & 1;
	addr0a += memaddr & 1;
	addr1a += (memaddr>>1) & 1;
	addr2a += (memaddr>>2) & 1;
	addr3a += (memaddr>>3) & 1;
	addr4a += (memaddr>>4) & 1;
	addr5a += (memaddr>>5) & 1;
	addr6a += (memaddr>>6) & 1;
	addr7a += (memaddr>>7) & 1;
	addr8a += (memaddr>>8) & 1;
	addr9a += (memaddr>>9) & 1;
	addr10a += (memaddr>>10) & 1;
	addr11a += (memaddr>>11) & 1;
	addr12a += (memaddr>>12) & 1;
	addr13a += (memaddr>>13) & 1;
	addr14a += (memaddr>>14) & 1;
	addr15a += (memaddr>>15) & 1;
	level0a += level & 1;
	level1a += (level>>1) & 1;
	level2a += (level>>2) & 1;
	level3a += (level>>3) & 1;

	//hsl_step(mci.aluc_d, mci.aluc_b);
	// save results to register(s)
	switch(mci.aluc_d) {
	case 0: hsl_regq = hsl_y; break; // Q=
	case 1: break; // nop
	case 2: hsl_reg[mci.aluc_b] = hsl_y; break; // B=
	case 3: hsl_reg[mci.aluc_b] = hsl_y; break; // B=
	case 4: // B=F>>1 Q>>=1
		hsl_reg[mci.aluc_b] = (hsl_y >> 1) | hsl_ram7;
		hsl_regq = (hsl_regq >> 1) | hsl_q7;
		break;
	case 5: // B=F>>1
		hsl_reg[mci.aluc_b] = (hsl_y >> 1) | hsl_ram7;
		break;
	case 6: // B=F<<1 Q<<=1
		hsl_reg[mci.aluc_b] = ((hsl_y << 1) | hsl_ram0) & 255;
		hsl_regq = ((hsl_regq << 1) | hsl_q0) & 255;
		break;
	case 7: // B=F<<1
		hsl_reg[mci.aluc_b] = ((hsl_y << 1) | hsl_ram0) & 255;
		break;
	}
	mcpc = ((s2.output << 8) | (s1.output << 4) | (s0.output)) & 0x7ff;

	run_hshw_steps();
	run_once = false;
}

function step(debug_output:boolean = false) {

	const mci = mpscache[mcpc];

	const intena = (busctl & 1) != 0;
	const intreq = intena && bpl.is_interrupt(level); // inverted on bus
	const sysint = reqlevel;
	const dmaint = intena && (level < 2) && (dma_12 != 0);
	const count_up = (busctl & 8)!=0;

	let is_jsr = 0;
	if (mci.k9_en) {
		switch(mci.k9_sel) {
		case 0: /* TODO f12b */ is_jsr = 1; break;
		case 1: /* rir.0 nor 4 */
			is_jsr = ((rir | (rir >> 4)) & 1)^1; break;
		case 2: /* rir.0 */ is_jsr = rir & 1; break;
		case 3: /* TODO: double check this (mmio/reg addressed) */
			is_jsr = is_regmmio; break;
		case 4: /* REG/pbit */ is_jsr = is_mem; break;
		case 5: /* DMA P2.13 */ is_jsr = dma_request(); break;
		case 6: /* TODO B15A */ is_jsr = b15a ^ 1; break;
		case 7: /* TODO F13->H13A any INT */
			is_jsr = dma_request();
			if (intreq || dmaint) {
				is_jsr = 1;
			}
			if (rtc && ((sysctl & 0x4) != 0)) {
				is_jsr = 1;
			}
			break;
		}
	}
	// branch and condition selectors
	let seq_or = 0;

	// seqencer control
	let seq0_s = mci.seq0_si;
	let seq1_s = mci.seq1_si_k6dc;
	let seq2_s = mci.seq2_si_k6b;
	let seq_fc = mci.seq_fci;
	if(is_jsr != 0) {
		seq0_s = 3;
		seq1_s = 3;
		seq2_s = 3;
		seq_fc &= 2;
	}

	let datapath = 0;
	// Data Path Control
	switch(mci.dp_sel) {
	case 0: case 4: // R_SWP ⇒ DP
		datapath = swap; break;
	case 1: case 5: // R_REG(d13) ⇒ DP
		datapath = rdr; break;
	case 2: case 6: // R_ADM(rawH) ⇒ DP
		datapath = ((memaddr >> 8) & 255) ^ 0xf0; break;
	case 3: case 7: // R_ADL ⇒ DP
		datapath = memaddr & 255; break;
	case 8: // R_AddrPH ⇒ DP
		datapath = pgaddr; break;
	case 9: // CCR:sense ⇒ DP
		// inverted on bus
		datapath = ((ccr_l << 4) | (ccr_f << 5) | (ccr_m << 6) | (ccr_v << 7) | sense_switch) ^ 0xf0 /* sense sw */; break;
	case 10: // R_SysDLatch ⇒ DP
		datapath = memdata_in; break;
	case 11: // R_H14 ⇒ DP // TODO rest of H14? beware invertions
		datapath = (level << 4) | 4 |
		(resetting ? 2 : 0) | notpgbit |
		(dmaint ? 8 : 0);
		break;
	case 12: // R_DLI (int7..4:dipsw3..1[RHI]:RTINT) ⇒ DP
		datapath = ((sysint & 15) << 4) | dswitch | ((rtc && ((sysctl & 0x4) != 0)) ? 1 : 0);
		break;
	case 13: // RCnst MCv2 ⇒ DP
		datapath = mci.mpconst_m6;
		break;
	// __ncE N/C
	// __ncF N/C
	}

	aluc.in_data = datapath;

	switch(mci.x_f6h6) {
	case 0: aluc.carry_in = 0; break;
	case 1: aluc.carry_in = 1; break;
	case 2: aluc.carry_in = (alu_flag >> 3) & 1; break;
	case 3: aluc.carry_in = 0; break;
	}
	aluc.resolve_alu(mci.aluc_s, mci.aluc_f, mci.aluc_d, mci.aluc_a, mci.aluc_b);
	let h6a = 0, h6b = 0;
	switch(mci.x_f6h6) {
	case 0: h6a = aluc.sign; h6b = 0; break;
	case 1: h6a = h6b = ((alu_flag >> 3) & 1); break;
	case 2: h6a = aluc.q0; h6b = aluc.sign; break;
	case 3: h6a = aluc.main_carry_out; h6b = 1; break;
	}
	if (aluc.is_right) {
		// >> 3.h.0 >> 3.l.0 >>
		aluc.q7 = aluc.ram0;
		aluc.ram7 = h6a; // h6.Za
	} else {
		// << 3.h.0 << 3.l.0 <<
		aluc.q0 = h6b; // h6.Zb
		aluc.ram0 = aluc.q7;
	}
	let data_f = aluc.out_f;
	if (mci.x_h11 == 6) {// Select MAPROM to F
		data_f = uc.map[datapath];
	}

	// uses ALU flags, so must be after comb logic resolve
	if (mci.seq_branch == 0) {
		switch(mci.j13_sel) {
		case 0: // |1 IF ALUF.S, |2 IF ALUF.Z
			seq_or |= ((alu_flag & 2)!=0 ?1:0);
			seq_or |= ((alu_flag & 1)!=0 ?2:0);
			break;
		case 1: // |1 IF ALUF.H, |2 IF ALUF.V
			seq_or |= ((alu_flag & 16)!=0 ?1:0);
			seq_or |= ((alu_flag & 4)!=0 ?2:0);
			break;
		case 2: // |1 IF ~pbit, |2 IF ~MMIO
			seq_or |= notpgbit | (is_mmio << 1);
			break;
		case 3: break; // nop
		}

		switch(mci.k13_sel) { // mind the strange order of OR2/3 (|4 |8)
		case 0: // |4 IF INT_EN, |8 IF CCR.Carry (Link)
			if (intena) seq_or |= 4; // TODO: trace
			if (ccr_l != 0) seq_or |= 8;
			break;
		case 1: // |4 IF DMA_INT, |8 IF INT_REQ
			if (!dmaint) seq_or |= 4; // TODO verify these work
			if (!intreq) seq_or |= 8; // TODO?
			break;
		case 2: // |4 IF MEM_INT, |8 IF DMA_REQ
			//seq_or |= 4; // typically low
			if (!dma_request()) seq_or |= 8; // typically high if no DMA connection
			break;
		case 3: break; // nop
		}
	}

	let rindex;
	if (mci.x_c14_sel) {
		rindex = (rir & 15) | (level << 4);
	} else {
		rindex = (rir & 255);
	}
	// rindex bit 0, this is technically a NOR
	// but can be handled as needed because this is the only reference
	rindex = (rindex | mci.rir0); // I elected to not invert it, since the debug dump would have anyways

	let c = s0.resolve(true, seq0_s, mci.seq_d0, seq_or, false);
	c = s1.resolve(c, seq1_s, mci.seq_d1, 0, false);
	s2.resolve(c, seq2_s, mci.seq_d2, 0, false);

	////////////////////////////// rising clock edge /////////////////////////////

	const prevwork = workaddr;
	const prevflag = alu_flag;

	if (!debug_output) {
		if (mcpc == 0x101) {
			dis_adrinval = show_dis;
			last_pc = memaddr;
			last_map = pta;
			let bfn = break_list[vmbreak[memaddr]];
			if(bfn != null && bfn(0, memaddr, physaddr) && handle_break()) debug_output = true;
		}
		if ((run_step && (mcpc == 0x101)) || mclisting[mcpc].bp) {
			if(handle_break()) debug_output = true;
		}
	}
	if (debug_output) {
		if(!show_uop) return;
		let debug = mc_listing(mcpc, datapath, data_f, aluc.y);
		mcs_op.innerText = debug.seq;
		mcs_op_alu.innerText = debug.rdr +' '+ debug.alu +' '+ debug.bus;
		return;
	}

	if(mci.dp_sel == 11) resetting = false;

	switch(mci.x_k11) {
	case 0: break; // nop
	case 1: mco.dma_end = false; break; // L13A_SET
	case 2: // ?K11_2
		// DMA device select updates
		// if ((mci.busctlset == 1) && ((sysctl & 1) == 0)) {
		// 
		// }
		// if ((mci.busctlset == 2) && ((sysctl & 2) == 0)) {
		// 
		// }
		if ((mci.busctlset == 128) && ((sysctl & 128) == 0)) {
			reqlevel = bpl.ack_interrupt(level);
			//console.log('IACK:', level,'->',reqlevel);
		}
		if ((mci.busctlmask == 127) && ((sysctl & 128) == 128)) {
			reqlevel = 0;
		}
		sysctl = (sysctl & mci.busctlmask) | mci.busctlset;
		if(mci.busctla < 2) dma_selection((busctl & 128)!=0, sysctl & 3);
		break;
	case 3: // BusCtl
		if ((mci.busctlset == 0x20) && ((busctl & 0x20) == 0)) {
			//console.log('MEM:TEST');
			mco.parity = 1;
		}
		if ((mci.busctlmask == 0xdf) && ((busctl & 0x20) != 0)) {
			//console.log('MEM:NOTEST');
			mco.parity = 0;
		}
		busctl = (busctl & mci.busctlmask) | mci.busctlset;
		if(mci.busctla == 7) dma_selection((busctl & 128)!=0, sysctl & 3);
		break;
	case 4: // REG_WR
		regfile[rindex] = result;
		break;
	case 5: // PTR_WR
		pagetb[pindex] = result;
		mempt_set();
		break;
	case 6: // WADL_WR
		if (mci.x_e6 == 5) {
			workaddr = (workaddr & 0xff00) | (memaddr & 0xff);
		} else {
			workaddr = (workaddr & 0xff00) | result;
		}
		break;
	case 7: // BusD_WR
		memdata_out = data_f;
		sys_write_latch = true;
		break;
	}

	// timer
	cycles++;
	if (cycles >= 83333 && CONFIG.cpu[2] < 2) {
		cycles = 0;
		if ((sysctl & 0x20) != 0) {
			rtc = true;
		}
	}
	if ((sysctl & 0x20) == 0) {
		rtc = false;
	}

	rdr = regfile[rindex];

	switch(mci.x_e7) {
	case 0: break; // nop
	case 1: break; // TODO: BusReady
	case 2: // ALUFlag_LD
		alu_flag = aluc.zero |
		(aluc.sign << 1) | (aluc.over << 2) |
		(aluc.main_carry_out << 3) | (aluc.half_carry_out << 4) | ((prevflag & 1) << 5);
		break;
	case 3: // DataRD
		if (sys_write_latch) {
			memdata_in = memdata_out;
		} else if(sys_read_in) {
			mco.memfault = 0;
			memdata_in = bpl.readbyte(physaddr);
			if(mco.trace_enable) {
				mco.trace.add('LD', memaddr);
			}
			if ((busctl & 0x40) != 0) {
				b15a = mco.memfault ^ 1;
			} else {
				b15a = 1;
			}
		}

		sys_write_latch = false;
		sys_read_in = false;
		break;
	}

	s0.commit(seq_fc);
	s1.commit(seq_fc);
	s2.commit(seq_fc);

	if (((busctl & 20) == 16) && dma_current != null) {
		if(!dma_current.dma_request) {
			dma_control.end();
		} else {
			dma_current.dma_step(dma_control);
		}
		if(workaddr == 0xffff) mco.dma_end = true;
	}
	switch(mci.x_h11) {
	case 0: break; // nop
	case 1: { // RD_START /* TODO */
		let bfn = break_list[vmbreak[memaddr]];
		bfn != null && bfn(1, memaddr, physaddr) && handle_break();
		sys_read_in = true;
		break;
	}
	case 2: { // WT_START /* TODO */
		let bfn = break_list[vmbreak[memaddr]];
		bfn != null && bfn(2, memaddr, physaddr) && handle_break();
		bpl.writebyte(physaddr, memdata_out);
		if(mco.trace_enable) {
			mco.trace.add('WT', memaddr);
		}
		break;
	}
	case 3: // WorkAddr_LDH
		if (mci.x_e6 == 5) {
			workaddr = (workaddr & 0x00ff) | (memaddr & 0xff00);
		} else {
			workaddr = (workaddr & 0x00ff) | (result << 8);
		}
		break;
	case 4: // WorkAddr_Count
		workaddr = (workaddr + (count_up?1:-1)) & 0xffff;
		break;
	case 5: // MemAddr_Count
		memaddr = (memaddr + (count_up?1:-1)) & 0xffff;
		mempt_set();
		break;
	case 6: break; // F=MapROM - handled farther above
	case 7: // NibSwap
		swap = ((datapath << 4) | (datapath >> 4)) & 255;
		break;
	}

	switch(mci.x_e6) {
	case 0: break; // nop case 0
	case 1: result = data_f; break; // F⇒Result
	case 2: rir = data_f; break; // F⇒RIdx
	case 3: level = data_f >> 4; break; // F⇒Level
	case 4: pta = data_f & 7; mempt_set(); break; // F⇒PTA
	case 5: memaddr = prevwork; mempt_set(); break; // ASwap
	case 6: // SEQ_RE
		s0.h = data_f & 15;
		s1.h = (data_f >> 4) & 15;
		break;
	case 7: // conditions register
		// alu_flag:
		//  LHCVSZ
		//  543210
		// L<<3 F<<2 M<<1 V<<0
		switch(mci.j12_sel) {
		case 0:
			break;
		case 1:
			ccr_v = prevflag & 1;
			ccr_m = (prevflag >> 1) & 1;
			break;
		case 2:
			ccr_v = (result >> 7) & 1;
			ccr_m = (result >> 6) & 1;
			break;
		case 3:
			ccr_v = (prevflag & (prevflag >> 5)) & 1;
			ccr_m = (prevflag >> 1) & 1;
			break;
		}
		if (mci.j11_en == 0) {
			switch(mci.j11_sel | (prevflag & 0x4)) {
			case 0: ccr_f = (result >> 5) & 1; break;
			case 1: ccr_f = 1; break;
			case 2: break;
			case 3: ccr_f = 0; break;
			case 4: ccr_f = (result >> 5) & 1; break;
			case 5: ccr_f = 1; break;
			case 6: break;
			case 7: ccr_f = 1; break;
			}
		} else {
			ccr_f = 0;
		}
		if (mci.j10_en == 0) {
			switch(mci.j10_sel) {
			case 0: break;
			case 1: ccr_l = ccr_l ^ 1; break;
			case 2: ccr_l = (prevflag >> 3) & 1; break;
			case 3: ccr_l = 1; break;
			case 4: ccr_l = (result >> 4) & 1; break;
			case 5: ccr_l = aluc.ram7; break;
			case 6: ccr_l = aluc.ram0; break;
			case 7: ccr_l = aluc.q0; break;
			}
		} else {
			ccr_l = 0;
		}
		break;
	}
	abtac += (sysctl >> 6) & 1;
	ccr_la += ccr_l;
	ccr_fa += ccr_f;
	ccr_ma += ccr_m;
	ccr_va += ccr_v;
	pta1a += pta & 1;
	pta2a += (pta >> 1) & 1;
	pta3a += (pta >> 2) & 1;
	addr0a += memaddr & 1;
	addr1a += (memaddr>>1) & 1;
	addr2a += (memaddr>>2) & 1;
	addr3a += (memaddr>>3) & 1;
	addr4a += (memaddr>>4) & 1;
	addr5a += (memaddr>>5) & 1;
	addr6a += (memaddr>>6) & 1;
	addr7a += (memaddr>>7) & 1;
	addr8a += (memaddr>>8) & 1;
	addr9a += (memaddr>>9) & 1;
	addr10a += (memaddr>>10) & 1;
	addr11a += (memaddr>>11) & 1;
	addr12a += (memaddr>>12) & 1;
	addr13a += (memaddr>>13) & 1;
	addr14a += (memaddr>>14) & 1;
	addr15a += (memaddr>>15) & 1;
	level0a += level & 1;
	level1a += (level>>1) & 1;
	level2a += (level>>2) & 1;
	level3a += (level>>3) & 1;

	aluc.step(mci.aluc_d, mci.aluc_b);
	mcpc = ((s2.output << 8) | (s1.output << 4) | (s0.output)) & 0x7ff;

	run_hshw_steps();

	run_once = false;
}

return mco;
}
const mcsim = mcsetup();
selsim = mcsim;
selcdsp = mcsim;
//@ts-ignore
window.cpu = mcsim;

class RemCPU implements ICCPU {
	can_step = true;
	/** [0]: V M F L . map */
	sscr = 0;
	/** [1]: current run level */
	level = 0;
	/** [2]: address pre-mmio */
	memaddr = 0;
	/** [3]: 18 bit bus address */
	physaddr = 0;
	/** [4w]: bus data/status update:
	 * * data[0..7]
	 * * parityfault[8]
	 * * is_write[9]
	 * * is_preempt[10]
	 * * is_timeout[11]
	 */
	sys_data = 0;
	memfault = 0;
	/** [5w]: divisor for time averages */
	run_count = 0;
	/** bit time average for:
	 * * [6b,7w]: address[0..15]
	 * * [8b,9w]: level[16..19]
	 * * [10b,11w]: map[24..26] abort[23] LFMV[24..27] */
	ledac = new Uint32Array(28);
	/** [12row, 13sparse]: the CPU register file RAM */
	regfile = new Uint8Array(256);
	/** [14row, 15sparse]: the CPU page map RAM */
	pagetb = new Uint8Array(256);
	/** [16]: address setup register */
	workaddr = 0;
	/** [17]: result transfer register */
	result = 0;
	/** [18]: register file index register */
	rir = 0;
	/** [19]: register file read buffer */
	rdr = 0;
	/** [20]: datapath nibble swap */
	swap = 0;
	/** [21]: ALU flags register */
	alu_flag = 0;
	/** [22]: machine status 1: dma/address flags, int ena */
	busctl = 0;
	/** [23]: machine status 2: dma dev,status,timer,int ack */
	sysctl = 0;
	/** [24]: page ram output (P10, incl bit 7) */
	pgram = 0;
	/** [25]: sequencer output (P8) */
	seq_out = 0;
	/** [26]: datapath value */
	datapath = 0;
	/** [27]: DMA bus status */
	dma_status = 0;
	/** [28]: microinstruction register (hw only) */
	micro_op0 = 0; // lower 32
	micro_op1 = 0; // upper 24
	/** [30] sequencer mpc (intern/emu only) */
	seq_p = 0;
	/** [31] sequencer hold (intern/emu only) */
	seq_h = 0;
	/** [32] sequencer stack (intern/emu only) */
	seq_sp = 0;
	seq_sf = [0,0,0,0];
	/** [33] ALU Q register (emu/hw cached) */
	alu_q = 0;
	/** [34] ALU RAM registers (emu/hw cached) */
	alu_r = new Uint8Array(16);
	/** [35] data write register */
	memdata_out = 0;
	/** [36] data read latch */
	memdata_in = 0;
	// buffers for net
	cmdbuf = new Uint8Array(4);
	decode_bytes(data: Uint8Array, offset = 0):void {
		const len = data.byteLength;
		while(offset < len) {
			let c = data[offset++];
			switch(c) {
			case 0: this.sscr = data[offset++]; break;
			case 1: this.level = data[offset++]; break;
			case 2: this.memaddr = (data[offset] << 8) | data[offset+1]; offset+=2; break;
			case 3: this.physaddr = (data[offset] << 16) | (data[offset+1] << 8) | data[offset+2]; offset+=3; break;
			case 6:
				this.run_count = 255;
				for(let i = 0; i < 16;i++) {
					this.ledac[i] = data[offset];
					offset++;
				}
				break;
			case 8:
				for(let i = 16; i < 20;i++) {
					this.ledac[i] = data[offset];
					offset++;
				}
				break;
			case 10:
				for(let i = 20; i < 28;i++) {
					this.ledac[i] = data[offset];
					offset++;
				}
				break;
			case 12:
			{
				let row = data[offset++];
				for(let i = 0; i < 16; i++) {
					this.regfile[row|i] = data[offset++];
				}
			}
			case 16: this.workaddr = (data[offset] << 8) | data[offset+1]; offset+=2; break;
			case 17: this.result = data[offset++]; break;
			case 18: this.rir = data[offset++]; break;
			case 19: this.rdr = data[offset++]; break;
			case 20: this.swap = data[offset++]; break;
			case 21: this.alu_flag = data[offset++]; break;
			case 22: this.busctl = data[offset++]; break;
			case 23: this.sysctl = data[offset++]; break;
			case 24: this.pgram = data[offset++]; break;
			case 25: this.seq_out = (data[offset] << 8) | data[offset+1]; offset+=2; break;
			case 26: this.datapath = data[offset++]; break;
			case 30: this.seq_p = (data[offset] << 8) | data[offset+1]; offset+=2; break;
			case 31: this.seq_h = (data[offset] << 8) | data[offset+1]; offset+=2; break;
			case 32:
				this.seq_sp = data[offset++];
				this.seq_sf[0] = (data[offset] << 8) | data[offset+1]; offset+=2;
				this.seq_sf[1] = (data[offset] << 8) | data[offset+1]; offset+=2;
				this.seq_sf[2] = (data[offset] << 8) | data[offset+1]; offset+=2;
				this.seq_sf[3] = (data[offset] << 8) | data[offset+1]; offset+=2;
				break;
			case 33: this.alu_q = data[offset++]; break;
			case 34:
				for(let i = 0; i < 16;i++) {
					this.alu_r[i] = data[offset++];
				}
				break;
			case 35: this.memdata_out = data[offset++]; break;
			case 36: this.memdata_in = data[offset++]; break;
			default: return;
			}
		}
	}
	step(dbg: boolean): void {
		if(active_connection == null || !net_provides_rc) return;
		const cmd = this.cmdbuf
		if(dbg) {
			cmd[0] = 11; // half step (for next state)
		} else {
			cmd[0] = 9; // steps == 1, sync step
			this.can_step = false; // wait for reply
			// steps > 1
			/*
			cmd[0] = 13; // step N
			cmd[1] = 1;
			active_connection.socket.send(cmd);
			cmd[0] = 10; // get state
			*/
		}
		active_connection.socket.send(cmd);
	}
	showstate(in_halt: boolean): void {
		const sscr = this.sscr;
		const memaddr = this.memaddr;
		const level = this.level;
		const ledac = this.ledac;

		if(show_int) {
			let mstk = '';
			let msp = this.seq_sp;
			let fl = this.alu_flag;
			let malu1 =
			`${hex(this.alu_q, 2)} ${hex(fl,2)} ${(fl&0x20)!=0?'L':'-'}${(fl&0x10)!=0?'H':'-'}${(fl&8)!=0?'C':'-'}${(fl&4)!=0?'V':'-'}${(fl&2)!=0?'S':'-'}${(fl&1)!=0?'Z':'-'}`;
			let malu2 = '';
			let malu3 = '';
			for(let i=0;i<4;i++) {
				mstk += hex(this.seq_sf[msp], 3) + ' ';
				msp = (msp - 1) & 3;
			}
			for(let i=0;i<8;i++) {
				malu2 += hex(this.alu_r[i], 2) + ' ';
				malu3 += hex(this.alu_r[i+8], 2) + ' ';
			}
			mcs_alu.innerText = malu1;
			mcs_alu2.innerText = malu2;
			mcs_alu3.innerText = malu3;
			mcs_p.innerText = `${hex(this.seq_out, 3)} ${hex(this.seq_p, 3)} ${hex(this.seq_h, 3)}`;
			mcs_s.innerText = mstk;
			mcr_res.innerText = hex(this.result, 2);
			mcr_swap.innerText = hex(this.swap, 2);
			mcr_level.innerText = hex(level, 1);
			mcr_rfir.innerText = hex(this.rir);
			mcr_rfdr.innerText = hex(this.rdr);
			mcr_pta.innerText = hex(sscr & 7, 1);
			mcr_dat_in.innerText = hex(this.memdata_in);
			mcr_dat_out.innerText = hex(this.memdata_out);
			const bc = this.busctl;
			const sc = this.sysctl;
			mcr_bus.innerText = `${(bc&1)!=0?'I':'-'} ${(bc&128)!=0?'DMA':'---'
			} ${(bc&16)!=0?'DA':'--'} ${(bc&4)!=0?'--':'CE'
			} ${(bc&8)!=0?'U':'D'} ${(bc&32)!=0?'PO':'PE'
			} ${(bc&64)!=0?'PFE':'---'}${(bc&2)!=0?' !AdrH':''}`;
			mcr_sys.innerText = `DV${sc&3} ${(sc&4)>0?'TE':'--'
			}${(sc&8)!=0?' !Map':''} ${(sc&16)!=0?'R':'H'
			} ${(sc&32)!=0?'--':'TR'} ${(sc&64)!=0?'A':'-'
			} ${(sc&128)!=0?'IA':'--'}`;
			mcr_addr.innerText = `${hex(this.workaddr, 4)} ${hex(memaddr, 4)
			} ${((this.pgram & 128) != 0 ? '*' : '.')}${hex(this.physaddr, 5)}`;
		}

		if(show_reg) {
			let sindex = 0;
			for(let rindex = 0;rindex < 256;rindex += 32) {
				for(let i=0;i<32;i+=2) {
					let reg = (this.regfile[rindex + i] << 8) | this.regfile[rindex + i+1];
					if(reg != mcr_file_v[sindex]) {
						mcr_file_v[sindex] = reg;
						mcr_file[sindex].innerText = hex(reg, 4);
					}
					sindex++;
				}
			}
		}

		const is_running = (this.sysctl & 16) != 0;
		style_if(fp_runhalt[0],'a',is_running); // run
		style_if(fp_runhalt[1],'a',!is_running); // halt

		style_if(fp_ext[0],'active',run_step);
		style_if(fp_ext[2],'a',this.memfault != 0);

		cx_map.clearRect(0, 0, cv_map.width, cv_map.height);
		cx_addr.clearRect(0, 0, cv_addr.width, cv_addr.height);
		const baseline = 22;

		let hrr2 = this.run_count >> 1;
		let hrr1 = hrr2 >> 1;
		let hrr05 = hrr1 >> 1;
		let hrr3 = hrr2 + hrr1;
		function ledcolor(v:number):string {
			if (v > hrr2) {
				if (v > hrr3) {
					return '#ff3232';
				} else if(v > hrr2 + hrr05) {
					return '#c01c1c';
				} else return '#a81c1c';
			} else if (v > hrr1) {
				if(v > hrr1 + hrr05) return '#901c1c';
				else return '#701c1c';
			} else if(v > hrr05) {
				return '#400c0c';
			} else return '#200c0c';
		}
		function drawaddr(v:number, x:number, t:string) {
			if (v > 0) {
				cx_addr.fillStyle = ledcolor(v);
				cx_addr.fillRect(x, 0, 12, 30);
			}
			cx_addr.fillStyle = '#aeaeae';
			cx_addr.fillText(t, x + 2, baseline);
		}
		function drawfill(v:number, x:number, t:string) {
			if (v > 0) {
				cx_map.fillStyle = ledcolor(v);
				cx_map.fillRect(x, 0, 16, 30);
			}
			cx_map.fillStyle = '#aeaeae';
			cx_map.fillText(t, x + 2, baseline);
		}
		drawaddr(ledac[15], 0, '8');
		drawaddr(ledac[14], 12, '4');
		drawaddr(ledac[13], 24, '2');
		drawaddr(ledac[12], 36, '1');
		drawaddr(ledac[11], 50, '8');
		drawaddr(ledac[10], 62, '4');
		drawaddr(ledac[9], 74, '2');
		drawaddr(ledac[8], 86, '1');
		drawaddr(ledac[7], 100, '8');
		drawaddr(ledac[6], 112, '4');
		drawaddr(ledac[5], 124, '2');
		drawaddr(ledac[4], 136, '1');
		drawaddr(ledac[3], 150, '8');
		drawaddr(ledac[2], 162, '4');
		drawaddr(ledac[1], 174, '2');
		drawaddr(ledac[0], 186, '1');
		drawfill(ledac[19], 10, '8');
		drawfill(ledac[18], 26, '4');
		drawfill(ledac[17], 42, '2');
		drawfill(ledac[16], 58, '1');
		if (ledac[23] > 0) {
			cx_map.fillStyle = ledcolor(ledac[23]);
			cx_map.fillRect(80, 0, 48, 30);
		}
		cx_map.fillStyle = '#aeaeae';
		cx_map.fillText('ABT', 88, baseline);
		drawfill(ledac[22], 130, '4');
		drawfill(ledac[21], 146, '2');
		drawfill(ledac[20], 162, '1');
		drawfill(ledac[25], 178, 'F');
		drawfill(ledac[24], 194, 'L');
		drawfill(ledac[26], 210, 'M');
		drawfill(ledac[27], 226, 'V');

		const ptindex = (sscr << 5) & 0xe0;
		if(show_page) {
			for (let k = 0; k < 4; k++) {
				let pgt = '';
				const psubindex = ptindex | (k << 3);
				for (let i = 0; i < 8; i++) {
					const page = this.pagetb[psubindex | i];
					const pf = (page & 128) != 0;
					pgt += (pf ? '*':'.') + hex((page & 127) << 3, 3) + ' ';
				}
				mcpage[k].innerText = pgt;
			}
		}
	}
	reset(): void {
		if(active_connection == null || !net_provides_rc) return;
		const cmd = this.cmdbuf
		cmd[0] = 12;
		active_connection.socket.send(cmd);
	}
}
const remcpu = new RemCPU();
const mixcpu:ICCPU = {
	get can_step() {
		return remcpu.can_step;
	},
	step(dbg:boolean) {
		remcpu.step(dbg);
		mcsim.step(dbg);
	},
	reset() {
		remcpu.reset();
		mcsim.reset();
	},
	showstate(in_halt: boolean) {
		mcsim.showstate(in_halt);
	}
};

const FN_K9 = [
	' 0BusAct  ', // if RDIN or WTIN have been asserted by the CPU
	' 1RInor04 ',
	' 2RI0     ',
	' 3AdIOReg ',
	' 4AdRegPGR', // need to recheck the logic on this one to give it a better name
	' 5DMAReq  ', // DMA port, request start
	' 6MemFault', // Memory parity error, must be enabled via BusCtl bit 6
	' 7IntCheck' // this one needs a better name (checks multiple interrupt lines)
];
const FN_F6 = ['0','1','AF.C','0'];
const FN_H6A = ['alu.s','AF.C','q0','alu.c'];
const FN_H6B = ['0','AF.C','alu.s','1'];
const FN_J12B = ['.','Z','RS.V','LZ'];
const FN_J12A = ['.','S','RS.M','S'];
const FN_J11 = ['RS.F','1','.','alu.o','RS.F','1','.','alu.o'];
const FN_J10 = ['.','~','C','0','RS.L','alu.7','alu.0/Q7','alu.Q0'];
const FV_E6 = [
	'','RS','RI','Level',
	'Map','','SeqRH',''
];
const FN_H11 = [
	'','RDIN','WTIN','WH=RS',
	'WCount','MACount','CROM','NibSwap'];
const FN_E7 = ['','BusReady','','BusRead'];
const FN_D45 = [
	'SwapR','RDR','MAH','MAL','SwapR','RDR','MAH','MAL',
	'PA','CCRSense','DatIn','LevelH14','IrqLDipT',''/*Const*/,'',''];
const FN_M13 = ['P2.3','P2.4','RTC','CROMDis','FP.Run','RTC.R','FP.ABT','IntAck'];
const FN_F11 = ['IntEN','AddrToSys','DMACountDIS','AddrU/D','AddrCtlSel','ParityTest','ParityEN','DMA.EN'];

function mc_listing(address:number, datapath?:number, data_f?:number, alu_y?:number, flow?:FlowTrace) {

	const c0 = uc.c0[address];
	const c1 = uc.c1[address];

	const dp_sel = c0 & 15;
	const x_e6 = (c0>>4) & 7;
	const x_k11 = (c0>>7) & 7;
	const x_h11 = (c0>>10) & 7;
	const x_e7 = (c0>>13) & 3;
	const k9_en = ((c0>>15)&1) == 0;
	const v2 = (c0 >> 16) & 255;
	const k9_sel = v2 & 7;
	const mpconst_m6 = v2 ^ 0xff; // goes through a 74ls240
	const j12_sel = v2 & 3;
	const j11_en = (c0>>18)&1;
	const j11_sel = (c0>>19) & 3;
	const j13_sel = (c0>>20) & 3;
	const j10_en = (c0>>21)&1;
	const j10_sel = (c0>>22) & 7;
	const k13_sel = (c0>>22) & 3;
	const seqjmp = (c0>>16) & 0x7ff; // for debug output
	const seq_fci = (c0>>27) & 3; // FE/PUP
	const seq0_si = (c0>>29) & 3;
	const seq12_s0i = (c0>>31)&1;
	const seq2_si_k6b = seq12_s0i | ((c1&1) << 1);
	const seq1_si_k6dc = seq12_s0i | (2 ^ (2 & (c1>>21) & ((c1<<1) ^ 2)));
	const seq_branch = (c1>>1)&1;
	const rir0 = (c1>>21)&1;
	const x_f6h6 = (c1>>19) & 3;
	const x_c14_sel = ((c1>>23)&1)!=0;
	const aluc_s = (c1>>2) & 7;
	const aluc_f = (c1>>5) & 7;
	const aluc_d = (c1>>8) & 7;
	const busctld = (c1>>11)&1;
	const busctla = (c1>>12) & 7;
	const aluc_b = (c1>>11) & 15;
	const aluc_a = (c1>>15) & 15;

	const k9_fn = (!k9_en ? '' : FN_K9[k9_sel]);
	if(k9_en && flow) {
		flow.branches.push({address:seqjmp, is_push:true, source:[k9_fn]});
	}
	const seq0_s = 3^seq0_si;
	const seq1_s = 3^seq1_si_k6dc;
	const seq2_s = 3^seq2_si_k6b;
	const seq_fc = seq_fci;

	let pc = (address + 1) & 0x7ff;
	let next = pc;
	let d_mask = 0;
	let r_mask = 0;
	let s_mask = 0;
	switch(seq0_s) {
		case 1: r_mask |= 0xf; break;
		case 2: s_mask |= 0xf; break;
		case 3: d_mask |= 0xf; break;
	}
	switch(seq1_s) {
		case 1: r_mask |= 0xf0; break;
		case 2: s_mask |= 0xf0; break;
		case 3: d_mask |= 0xf0; break;
	}
	switch(seq2_s) {
		case 2: s_mask |= 0xf00; break;
		case 3: d_mask |= 0xf00; break;
	}
	next = (pc & ((d_mask | r_mask | s_mask) ^ 0xfff)) | (seqjmp & d_mask);
	if(flow) {
		flow.next = next;
		flow.stack_mask = s_mask;
		flow.reg_mask = r_mask;
		if(seq_fc == 0) { flow.stack_op = true; flow.stack_push = false; } // POP
		if(seq_fc == 2) { flow.stack_op = true; flow.stack_push = true; } // PUSH PC
	}
	let d_branch = '';
	if (seq_branch == 0) {
		let d_branch0 = '';
		let d_branch1 = '';
		let d_branch2 = '';
		let d_branch3 = '';
		switch(j13_sel) {
		case 0:
			if ((next | 1) != next) d_branch0 = 'AF.S';
			if ((next | 2) != next) d_branch1 = 'AF.Z';
			break;
		case 1:
			if ((next | 1) != next) d_branch0 = 'AF.H';
			if ((next | 2) != next) d_branch1 = 'AF.V';
			break;
		case 2:
			if ((next | 1) != next) d_branch0 = '~pbit ';
			if ((next | 2) != next) d_branch1 = '~MMIO ';
			break;
		case 3: break; // nop
		}
		switch(k13_sel) {
		case 0:
			if ((next | 4) != next) d_branch2 = 'IntEna ';
			if ((next | 8) != next) d_branch3 = 'CCR.L  ';
			break;
		case 1:
			if ((next | 4) != next) d_branch2 = 'DMAInt';
			if ((next | 8) != next) d_branch3 = 'IntReq';
			break;
		case 2:
			if ((next | 4) != next) d_branch2 = 'MemInt ';
			if ((next | 8) != next) d_branch3 = 'DMAReq ';
			break;
		case 3: break; // nop
		}
		if(flow) {
			let mask = 0;
			if(d_branch0.length != 0) mask |= 1;
			if(d_branch1.length != 0) mask |= 2;
			if(d_branch2.length != 0) mask |= 4;
			if(d_branch3.length != 0) mask |= 8;
			for(let i = 1; i < 16; i++) {
				if((i & mask) != i) continue;
				if((next | i) != next) {
					let br = [];
					if ((next | (i&1)) != next) br.push(d_branch0);
					if ((next | (i&2)) != next) br.push(d_branch1);
					if ((next | (i&4)) != next) br.push(d_branch2);
					if ((next | (i&8)) != next) br.push(d_branch3);
					flow.branches.push({ address: next | i, source: br });
				}
			}
		}
		if(d_branch0.length != 0) d_branch += '|1:' + d_branch0;
		if(d_branch1.length != 0) d_branch += '|2:' + d_branch1;
		if(d_branch2.length != 0) d_branch += '|4:' + d_branch2;
		if(d_branch3.length != 0) d_branch += '|8:' + d_branch3;
	}
	let mcd_d45 = FN_D45[dp_sel];
	if(dp_sel == 13) {
		mcd_d45 += `#${hex(mpconst_m6)}`;
	} else if(datapath != undefined) {
		mcd_d45 += `(${hex(datapath)})`;
	}
	let disp_f = FV_E6[x_e6];
	let mck11 = '';
	switch(x_k11) {
	case 1: mck11 = 'DMAEndReset'; break;
	case 2: mck11 = `SysCtl.${FN_M13[busctla]}=${busctld}`; break;
	case 3: mck11 = `BusCtl.${FN_F11[busctla]}=${busctld}`; break;
	case 4: mck11 = `REG[${x_c14_sel?'Lv':''}RI${rir0!=0?'1':' '}]=RS`; break;
	case 5: mck11 = 'Page=RS'; break;
	case 6: mck11 = 'WL=RS'; break;
	case 7: if(disp_f.length == 0) disp_f = 'DatOut'; else disp_f = 'DatOut= ' + disp_f;
		break;
	}
	let mch11 = FN_H11[x_h11];
	if(x_h11 == 6) { // TODO F=MapROM[DP] ignore ALU F
		mch11 = `${disp_f}=${mch11}[${mcd_d45}]`;
		disp_f = '';
	}
	if(x_h11 == 7) { // NibSwap uses DP
		mch11 = `${mch11}(${mcd_d45})`;
	}
	let mce6 = '';
	// e6[0] nop, e6[1..4] load from F, e6[6] maybe load from F
	if(x_e6 == 5) { // MemAddr=WorkAddr, WorkAddr loads use MemAddr instead
		if(x_h11 == 3 && x_k11 == 6) { // IF Swap Enabled: WorkAddr=MemAddr
			mce6 = 'MA<=>W';
			mch11 = '';
			mck11 = '';
		} else { // an 8 bit only swap!?
			if(x_k11 == 6) {
				mce6 = 'MAH=WH';
				mck11 = 'WL<=>MAL';
			} else if(x_h11 == 3) {
				mce6 = 'MAL=WL';
				mch11 = 'WH<=>MAH';
			} else {
				mce6 = 'MA=W';
			}
		}
	}

	// if right shift (aluc_d & 2) == 0: FN_H6A[x_f6h6] >> RAM7, RAM0>>Q7
	// if left shift: (aluc_d & 2) != 0: FN_H6B[x_f6h6] >> Q0, Q7>>RAM0
	let mcsh_r;
	let mcsh_q;
	if((aluc_d & 2) == 0) {
		mcsh_r = FN_H6A[x_f6h6];
		mcsh_q = 'R.0';
	} else {
		mcsh_q = FN_H6B[x_f6h6];
		mcsh_r = 'Q.7';
	}
	let d_ccr = '';
	if(x_e7==2) { // ALUFlag_LD
		d_ccr = ' => AF';
		if(disp_f.length == 0) disp_f = '_';
	}
	const lh = ALU.trace_str(aluc_s, aluc_f, aluc_d, aluc_a, aluc_b,
		mcsh_q, mcsh_r, disp_f, mcd_d45, FN_F6[x_f6h6]);

	// CCR load
	if(x_e6 == 7) {
		d_ccr += ` V=${FN_J12B[j12_sel]} M=${FN_J12A[j12_sel]
		} F=${j11_en ? '0' : FN_J11[j11_sel]} L=${j10_en ? '0' : FN_J10[j10_sel]}`;
	}

	let mce7 = FN_E7[x_e7];
	if((rir0!=0) && (x_e7 != 0)) {
		mce7 += '+E7S';
	}
	let mcbus = mck11;
	if(mch11.length > 0) {
		if(mcbus.length > 0) mcbus += ', ' + mch11;
		else mcbus = mch11;
	}
	if(mce6.length > 0) {
		if(mcbus.length > 0) mcbus += ', ' + mce6;
		else mcbus = mce6;
	}
	if(mce7.length > 0) {
		if(mcbus.length > 0) mcbus += ', ' + mce7;
		else mcbus = mce7;
	}
	return {
		seq: `${hex(address,3)}:${hex(c1,6)}${hex(c0,8)
	} ${FN_SEQ_SN[seq2_s]}${FN_SEQ_SN[seq1_s]}${FN_SEQ_SN[seq0_s]
	} ${FN_SEQ_FE[seq_fc]} [${hex(seqjmp,3)}>${hex(next,3)}] ${k9_fn} ${d_branch}`,
		alu: (alu_y != undefined) ? `${lh} (${hex(data_f as number,2)}:${hex(alu_y,2)})${d_ccr}` : `${lh}${d_ccr}`,
		rdr: `RDR[${x_c14_sel?'Lv':'  '}RI${rir0!=0?'1':' '}]`,
		bus: mcbus
	};
}

const listmax = 100;
interface AssmListing {
	a_ref:number;
	v_ref:number;
	pre:HTMLDivElement;
	addrp:HTMLDivElement;
	addrv:HTMLSpanElement;
	hex:HTMLSpanElement;
	ascii:HTMLDivElement;
	inst:HTMLSpanElement;
	param:HTMLSpanElement;
	line:HTMLSpanElement;
	comm:HTMLSpanElement;
}
const listing:AssmListing[] = [];
interface MicroListing {
	line: HTMLDivElement;
	left: HTMLDivElement;
	mc1: HTMLDivElement;
	mc2: HTMLDivElement;
	mc3: HTMLDivElement;
	bp: boolean;
	bpc: HTMLInputElement;
	flow: FlowTrace;
}
interface FlowBranch {
	address: number,
	source?: string[],
	is_push?: true,
}
interface FlowFrom {
	from: number,
	origin?: number,
}
interface FlowTrace {
	id: number,
	reached: boolean,
	processed: boolean,
	from: FlowFrom[],
	from_main: string[],
	next: number,
	stack_op: boolean
	stack_push: boolean,
	stack_mask: number,
	reg_mask: number,
	frame?: FlowFrame[],
	frame_ref?: number,
	branches: FlowBranch[],
}
interface FlowFrame {
	ret: number,
	orig: number,
	entry: number,
}
function markflow(target:FlowTrace, source:FlowTrace, marker?:string):boolean {
	target.reached = true;
	if(marker != undefined) {
		marker = marker;
	} else if(source.from_main.length > 0) {
		marker = source.from_main[0];
	}
	if(marker != undefined && !target.from_main.includes(marker)) {
		target.from_main.push(marker);
	}
	if(!target.from.find((v)=>v.from == source.id)) {
		let f = undefined;
		if(source.frame != undefined) {
			f = source.frame.find((v)=>v.ret == target.id);
		}
		if(f) target.from.push({from:source.id, origin:f.orig});
		else target.from.push({from:source.id});
	}
	return !target.processed;
}
function flow_frame(target:MicroListing, from:FlowTrace, is_stk:boolean, pushframe?:FlowFrame):boolean {
	let proc_flag = false;
	if(pushframe != undefined && target.flow.frame_ref !== undefined) { // pre-processed chain
		const poplisting = mclisting[target.flow.frame_ref];
		const popflow = poplisting.flow;
		const popframe = popflow.frame; // the frame containing a POP
		if(popframe) {
			const is_refpop = popflow.stack_op && !popflow.stack_push;
			if(is_refpop) {
				// copy pasta? or common function?
				let r = pushframe.ret;
				popframe.push(pushframe);
				r = (popflow.next & (popflow.stack_mask ^ 0xfff)) | (r & popflow.stack_mask);
				// the return point flows from the end of the call
				const retflow = mclisting[r].flow;
				proc_flag = markflow(retflow, popflow);
				//const frame = from.frame;
				//if(frame) { // if the entry point is also a PUSH/CALL, move it's frames to the return point
				//	delete from.frame;
				//	retflow.frame = frame;
				//	frame.forEach((v)=>{mclisting[v.entry].flow.frame_ref = retflow.id;});
				//}
			} else {
				popframe.push(pushframe);
			}
		}
	} else if(pushframe != undefined) { // push a new frame
		target.left.classList.add('stk');
		//console.log('NEW FRAME', hex(from.id,3), hex(target.flow.id,3), hex(pushframe.orig,3));
		if(target.flow.frame == undefined) {
			target.flow.frame = [pushframe];
		} else {
			target.flow.frame.push(pushframe);
			console.log('FRAME OVERLAP', hex(from.id,3), hex(target.flow.id,3), hex(pushframe.orig,3))
		}
	} else if(from.frame != undefined && (!is_stk || pushframe)) { // move existing frame along a chain
		if(target.flow.processed) {
			const frame = from.frame;
			delete from.frame;
			if(target.flow.frame == undefined) {
				console.log('MOVE FRAME (PROC!)', hex(from.id,3), hex(target.flow.id,3));
				target.flow.frame = frame;
			} else {
				console.log('MERGE FRAME (PROC!)', hex(from.id,3), hex(target.flow.id,3));
			}
			frame.forEach((v)=>{mclisting[v.entry].flow.frame_ref = target.flow.id;});
		} else if(target.flow.frame == undefined) {
			//console.log('MOVE FRAME', hex(from.id,3), hex(target.flow.id,3));
			const frame = from.frame;
			delete from.frame;
			target.flow.frame = frame;
			frame.forEach((v)=>{mclisting[v.entry].flow.frame_ref = target.flow.id;});
		} else {
			const tframe = target.flow.frame;
			// from.frame.forEach((v)=>{
			// 	if(!tframe.ret.includes(v)) tframe.ret.push(v);
			// });
			// frame.entry.forEach((v)=>{
			// 	mclisting[v].flow.frame_ref = target.flow.id;
			// 	if(!tframe.entry.includes(v)) tframe.entry.push(v);
			// });
			console.warn('mc frame merge at', hex(target.flow.id,3));
		}
	}
	return proc_flag;
}
function microcfa() {
	let proc_flag = false;
	mclisting[0].flow.reached = true;
	mclisting[0].flow.from_main = ['Reset'];
	mclisting[0x100].flow.from_main = ['PreFetch'];
	mclisting[0x101].flow.from_main = ['Fetch'];
	for(let kb = 0; kb < 256; kb++) {
		let sfl = mclisting[0x100 | uc.map[kb]].flow;
		sfl.reached = true;
		sfl.from_main.push('Op'+hex(kb));
	}
	let decent = 4096;
	
	/////
	while(proc_flag) {
		proc_flag = false;
		for (let i = 0; i < 2048; i++) {
			const listobj = mclisting[i];
			const flow = listobj.flow;
			let pf = false;
			if(flow.reached && !flow.processed) {
				flow.processed = true;
				listobj.left.classList.add('mcrec');
				const frame:FlowFrame[]|undefined = flow.frame;
				const is_push = flow.stack_op && flow.stack_push;
				const is_pop = flow.stack_op && !flow.stack_push;
				if(flow.next != i && flow.stack_mask == 0 && flow.reg_mask == 0) {
					const tn = mclisting[flow.next];
					const tf = tn.flow;
					if(is_push) {
						pf = flow_frame(tn, flow, true, { ret: (i + 1) & 0x7ff, orig:i, entry:tf.id });
					} else {
						pf = flow_frame(tn, flow, flow.stack_op);
					}
					if(pf) proc_flag = true;
					if(markflow(tf, flow)) proc_flag = true;
				} else if(is_pop && flow.stack_mask != 0) {
					// return to stack
					if(frame != undefined) {
						console.log('RETURN', hex(i,3));
						for(let k = 0; k < frame.length; k++) {
							let r = frame[k].ret;
							const retorigin = mclisting[frame[k].orig].flow
							r = (flow.next & (flow.stack_mask ^ 0xfff)) | (r & flow.stack_mask);
							const retflow = mclisting[r].flow;
							// if the entry point is also a PUSH/CALL, move it's frames to the return point
							//frame.forEach((v)=>{mclisting[v.entry].flow.frame_ref = retflow.id;});
							const origframe = retorigin.frame;
							// if the return origin was carrying a frame
							if(origframe) {
								delete retorigin.frame;
								retflow.frame = origframe;
								if(retflow.processed) console.warn('RETURN ORIGIN ALREADY PROCESSED');
								origframe.forEach((v)=>{mclisting[v.entry].flow.frame_ref = retflow.id;});
							}
							if(markflow(retflow, flow)) proc_flag = true;
						}
					} else {
						console.log('UNTRACED RETURN', hex(i,3));
					}
				} else if(flow.reg_mask != 0) {
					const r_base = flow.next & (flow.reg_mask ^ 0xfff);
					console.log('AHR JMP',hex(i,3),hex(r_base,3),hex(flow.reg_mask,3));
					// TODO
				}
				let br = flow.branches;
				let clearflow = false;
				for(let b = 0; b < br.length; b++) {
					const n = br[b];
					const brlisting = mclisting[n.address];
					const brflow = brlisting.flow;
					if(n.is_push) {
						if(flow_frame(brlisting, flow, true, { ret: (i + 1) & 0x7ff, orig:i, entry:brflow.id }))
							proc_flag = true;
					} else {
						if(flow_frame(brlisting, flow, false))
							proc_flag = true;
						clearflow = true;
						flow.frame = frame;
					}
					if(n.source != undefined) {
						if(markflow(brflow, flow, n.source[0]))
							proc_flag = true;
					} else {
						if(markflow(brflow, flow))
							proc_flag = true;
					}
				}
				if(clearflow) {
					delete flow.frame;
				}
			}
		}
	}
	for (let i = 0; i < 2048; i++) {
		const listobj = mclisting[i];
		const flow = listobj.flow;
		if(!flow.reached) continue;
		let br = '';
		for(let i = 0; i < flow.branches.length; i++) {
			let branch = flow.branches[i];
			if(branch.source) br += `[${hex(branch.address,3)} ${branch.source.join(' & ')}]`;
			else br += `[${hex(branch.address,3)}]`;
		}
		let f = [];
		for(let i = 0; i < flow.from_main.length; i++) {
			let v = flow.from_main[i];
			f.push(v);
		}
		for(let i = 0; i < flow.from.length; i++) {
			let v = flow.from[i];
			if(v.origin != undefined) {
				f.push(`${hex(v.origin, 3)}>${hex(v.from, 3)}`);
			} else f.push(hex(v.from, 3));
		}
		let fr = '';
		if(flow.frame_ref !== undefined) {
			fr += ` retn:${hex(flow.frame_ref, 3)}`;
		}
		if(flow.frame) {
			fr += flow.frame.map((v)=>`<ret:${hex(v.ret,3)} ent:${hex(v.entry,3)} o:${hex(v.orig,3)}>`).join(';');
		}
		listobj.mc3.innerText = `next:${hex(flow.next,3)}/${hex(flow.stack_mask,3)} from:${f.join(',')}${fr} ${br}`;
	}
}
//@ts-ignore
window.run_microcode_cfa = microcfa;
(function(){
	for (let i = 0; i < listmax; i++) {
		const listnode = document.createElement('div');
		const item:AssmListing = {
			a_ref: 0,
			v_ref: 0,
			pre: document.createElement('div'),
			addrp: document.createElement('div'),
			addrv: document.createElement('span'),
			line: document.createElement('div'),
			hex: document.createElement('span'),
			ascii: document.createElement('div'),
			inst: document.createElement('span'),
			param: document.createElement('span'),
			comm: document.createElement('span')
		}
		listnode.appendChild(item.pre);
		listnode.appendChild(item.line);
		item.line.classList.add('line');
		item.addrp.addEventListener('click', function() {
			console.log('bpt', hex(item.a_ref,5));
			let v = bpl.readmeta(item.a_ref);
			v ^= MEMSTAT.ACC_BRK;
			bpl.writemeta(item.a_ref, v);
			show_disasm();
		});
		item.line.appendChild(item.addrv);
		item.line.appendChild(item.hex);
		item.line.appendChild(item.inst);
		item.line.appendChild(item.param);
		item.line.appendChild(item.comm);
		listing.push(item);
		d_listing.appendChild(listnode);
		d_listinga.appendChild(item.addrp);
		d_listingc.appendChild(item.ascii);
	}
	for (let i = 0; i < 2048; i++) {
		const listnode = document.createElement('div');
		listnode.classList.add('regs');
		const leftnode = document.createElement('div');
		const rightnode = document.createElement('div');
		const addrnode = document.createElement('div');
		const bpnode = document.createElement('div');
		addrnode.innerHTML = `&#x03bc;Op ${hex(i,3)}`;
		leftnode.appendChild(addrnode);
		leftnode.appendChild(bpnode);
		const bplnode = document.createElement('label');
		const bpcnode = document.createElement('input');
		bpcnode.type = 'checkbox';
		bplnode.appendChild(bpcnode);
		bplnode.append('break');
		bpnode.appendChild(bplnode);
		listnode.appendChild(leftnode);
		listnode.appendChild(rightnode);
		const listobj:MicroListing = {
			line: listnode,
			left: leftnode,
			mc1: document.createElement('div'),
			mc2: document.createElement('div'),
			mc3: document.createElement('div'),
			bp: false,
			bpc: bpcnode,
			flow: {
				id: i,
				reached: false,
				processed: false,
				from: [],
				from_main: [],
				branches: [],
				next: 0,
				stack_op: false,
				stack_push: false,
				stack_mask: 0,
				reg_mask: 0,
			}
		};
		bpcnode.addEventListener('click', function(ev) {
			const lst = listobj;
			lst.bp = this.checked;
		});
		listobj.mc1.classList.add('mcc');
		listobj.mc2.classList.add('mcc');
		listobj.mc3.classList.add('mcc');
		rightnode.appendChild(listobj.mc1);
		rightnode.appendChild(listobj.mc2);
		rightnode.appendChild(listobj.mc3);
		let lo = mc_listing(i, undefined, undefined, undefined, listobj.flow);
		listobj.mc1.innerText = lo.seq;
		listobj.mc2.innerText = `${lo.rdr}, ${lo.bus}${lo.bus.length>0?', ':''}${lo.alu}`;
		mclisting.push(listobj);
		d_micro.appendChild(listnode);
	}
	
})();
let last_memv_line = -1;
function update_memview(is_scroll = false) {
	const mem_con = frame_memory.content;
	const col_a = mem_con.children[1] as HTMLDivElement;
	const col_d = mem_con.children[2] as HTMLDivElement;
	const col_t = mem_con.children[3] as HTMLDivElement;
	if(memory_elem.length == 0) {
		mem_con.addEventListener('scroll', function() {
			update_memview(true);
		});
		for(let i = 0; i < 32; i++) {
			const node_a = document.createElement('div');
			const node_d = document.createElement('div');
			const node_t = document.createElement('div');
			const line = {a:node_a, d:node_d, t:node_t};
			col_a.appendChild(node_a);
			col_d.appendChild(node_d);
			col_t.appendChild(node_t);
			memory_elem.push(line);
		}
	}
	const line_height = 22;
	const line_limit = 16384 - 32;
	let lines = (mem_con.scrollTop / line_height) | 0;
	if(lines > line_limit) lines = line_limit;
	if(is_scroll && last_memv_line == lines) return;
	last_memv_line = lines;
	memv_begin = lines * 16;
	memv_end = (lines + 32) * 16;
	let ofs = (lines * line_height);
	let top = `${ofs}px`;
	col_a.style.top = top;
	col_d.style.top = top;
	col_t.style.top = top;
	for(let i = 0; i < 32; i++) {
		const e = memory_elem[i];
		let n = (lines + i) * 16;
		e.a.innerText = hex(n, 5);
		let c = bpl.readmeta(n) & 255;
		let hs = hex(c);
		let ts:string;
		if(c > 159 && c < 255) {
			ts = String.fromCharCode(c & 127);
		} else {
			ts = '.';
		}
		for(let b = 1; b < 16; b++) {
			c = bpl.readmeta(n + b) & 255;
			hs += ' ' + hex(c);
			if(c > 159 && c < 255) {
				ts += String.fromCharCode(c & 127);
			} else {
				ts += '.';
			}
		}
		e.d.innerText = hs;
		e.t.innerText = ts;
	}
}
function update_microlist() {
	for (let i = 0; i < 2048; i++) {
		const m = mclisting[i];
		m.bpc.checked = m.bp;
	}
}
const disk_origin_date = -2209161600000;
const days_to_date = 86400000;
const disk_file_types = [
	{i:0,t:'D',x:'RAW'},
	{i:1,t:'B',x:'BIN'},
	{i:2,t:'A',x:'TXT'},
	{i:3,t:'C',x:'BIN'},
	{i:4,t:'E',x:'BIN'},
	{i:5,t:'L',x:'VOL'},
	{i:6,t:'I',x:'RAW'},
	{i:7,t:'S',x:'RAWS'},
	{i:8,t:'Q',x:'RAWQ'},
	{i:9,t:'X',x:'FILE9'},
	{i:10,t:'X',x:'FILE10'},
	{i:11,t:'X',x:'FILE11'},
	{i:12,t:'X',x:'FILE12'},
	{i:13,t:'X',x:'FILE13'},
	{i:14,t:'X',x:'FILE14'},
	{i:15,t:' ',x:'FILE15'},
];
function fmt_disk_date(dts:number) {
	let d = '';
	if(dts != 0) {
		let fe_dts = disk_origin_date + (days_to_date * dts);
		d = (new Date(fe_dts)).toISOString().substring(0,10);
	}
	return d;
}
function u24(data:Uint8Array, ofs:number) {
	return (data[ofs] << 16) | (data[ofs + 1] << 8) | data[ofs + 2];
}
function fixed_str(data:Uint8Array, ofs:number, count:number) {
	let s = '';
	for(let i = 0; i < count; i++) {
		let c = data[ofs + i] & 127;
		if(c == 0) return s;
		if(c < 32) {
			switch(c) {
			case 10: s += '\\n'; break;
			case 13: s += '\\r'; break;
			default:
				s += '^' + hex(data[ofs + i]);
			}
		} else s += String.fromCharCode(c);
	}
	return s;
}

interface FSDirEntry {
	name: string,
	map_sect: number, map_index: number,
	ft: {i:number, t:string, x:string},
	attr: number,
	date: number,
	ual_base: number,
	loadaddr: number,
	cls: number,
	fsi: number,
	fsi_shift: number,
	fsi_str: string,
	length: number,
	t_len: string,
	s_len: string,
	ual?: number[],
}
class DiskVol {
	image: DiskImage;
	buf1 = new Uint8Array(400);
	view1: DataView;
	buf_ual = new Uint8Array(400);
	view_ual: DataView;
	name: string = '';
	status: string = '';
	max_sector_ofs: number;
	max_sector: number;
	guarded = true;
	sys_date = 0;
	reorg_date = 0;
	reorg_errors = 0;
	ual_sector = 0;
	dir_offset = 0;
	vrec_extra = '';
	key = 100;
	directory: (FSDirEntry | string)[] = [];
	constructor(image: DiskImage) {
		this.image = image;
		this.view1 = new DataView(this.buf1.buffer);
		this.view_ual = new DataView(this.buf_ual.buffer);
		this.max_sector_ofs = image.backing_data.byteLength;
		this.max_sector = (this.max_sector_ofs / image.stride) | 0;
	}
	read_media_sector(sector: number, buf: Uint8Array) {
		let offset = sector * this.image.stride;
		for(let i = 0; i < 400; i++) buf[i] = this.image.data[offset+i];
	}
	read_ual_sectors(entry: FSDirEntry) {
		if(entry.ual) return entry.ual;
		this.read_media_sector(entry.map_sect + this.ual_sector, this.buf_ual);
		let sectors: number[] = [];
		let ofs = entry.map_index + 6;
		let ual_limit = 0;
		while((++ual_limit) < 100 && sectors.length < entry.length) {
			let si = u24(this.buf_ual, ofs);
			if(si == 0xffffff) {
				entry.ual = sectors;
				break;
			}
			if(si > 0x800000) {
				si = this.view_ual.getUint16(ofs) ^ 0xffff;
				ofs = this.view_ual.getUint8(ofs + 2) * 3;
				this.read_media_sector(si + this.ual_sector, this.buf_ual);
			} else {
				sectors.push(si);
				ofs += 3;
			}
		}
		return sectors;
	}
	private get_dir_ent(entry: number, ual_sect: number): FSDirEntry | null | string {
		const fe_name = fixed_str(this.buf1, entry, 10);
		const fe_map_index = this.buf1[entry + 10] * 3;
		const fe_map_sect = this.view1.getUint16(entry + 11, false);
		const fe_ft = disk_file_types[this.buf1[entry + 13] & 0xf];
		const fe_attr = this.buf1[entry + 13];
		const fe_date = this.view1.getUint16(entry + 14, false);
		const fm_base = ual_sect + fe_map_sect;
		if(fm_base >= this.max_sector || fe_map_index >= 396) {
			return `${fe_name} ${fe_ft.t} <BAD:${hex(fe_map_sect,4)}:${hex(fe_map_index)}> ${fmt_disk_date(fe_date)}`;
		}
		this.read_media_sector(fm_base, this.buf_ual);
		const fm_length = this.view_ual.getUint16(fe_map_index, false) + 1;
		const fm_begin_ptr = this.view_ual.getUint16(fe_map_index + 2, false);
		const fm_shift = this.buf_ual[fe_map_index + 4];
		const fm_cls = this.buf_ual[fe_map_index + 5];
		// u16 file length - 1 (zero length not allowed)
		// u16 entrypoint (typically 0x8000)
		// u8 FSI = 1 << thisval: File size increment, a # of sectors
		// u8 file class: typically 0xff and not used
		// i24[]: file usage allocation list:
		//  positive values are a start sector #, points at FSI# sectors
		//   the next UAL entry will immediately follow
		//   up to 8.5 GB of storage can be addressed.
		//  negative values:
		//   -1, end of file allocation
		//   else, reinterpret as:
		//    u16: next UAL sector ^ 0xffff
		//    u8: FAL index, multiply by 3, then use as offset into next UAL sector
		//    index should not exceed 132 (byte offset 396)
		//    next UAL sector numbers are relative to start of UAL
		if(fm_shift > 15) {
			const fm_6 = u24(this.buf_ual, fe_map_index + 6);
			return `${fe_name} ${fe_ft.t}:${hex(fe_attr)} <BAD:${hex(fe_map_sect,4)}:${hex(fe_map_index)}> <${hex(fm_length,4)}:${hex(fm_begin_ptr,4)}:${hex(fm_shift)}:${hex(fm_cls)}:${hex(fm_6,6)}>`;
		}
		return {
			name: fe_name,
			map_sect: fe_map_sect, map_index: fe_map_index,
			ft: fe_ft,
			attr: fe_attr,
			date: fe_date,
			ual_base: fm_base,
			loadaddr: fm_begin_ptr,
			cls: fm_cls,
			fsi: 1 << fm_shift,
			fsi_shift: fm_shift,
			fsi_str: DiskViewer.fsi_s[fm_shift],
			length: fm_length,
			t_len: `${fm_length >> 4}T`.padStart(4),
			s_len: `${fm_length & 15}S`.padStart(3)
		};
	}
	decode_image() {
		this.read_media_sector(14, this.buf1);
		let mcr = '';
		const disk6_flag = (this.buf1[8] << 8) | this.buf1[9];
		let disk_vol_pre = 0;
		let disk_vol_ofs = 16;
		this.sys_date = (this.buf1[0] << 8) | this.buf1[1];
		const disk_guard = (this.buf1[2] << 8) | this.buf1[3];
		this.guarded = disk_guard != 0x4321;
		if(disk6_flag == 0xffff) {
			let disk_key = (this.buf1[6] << 8) | this.buf1[7];
			disk_key ^= 0xffff;
			disk_key = ((disk_key >> 1) | (disk_key << 15)) & 0xffff;
			disk_key ^= 0x8db1;
			this.key = disk_key;
			let dvo = this.buf1[5];
			disk_vol_pre = ((this.buf1[4]^dvo) << 8) | dvo;
			disk_vol_pre ^= 0x3cb1;
			disk_vol_ofs = (disk_vol_pre + disk_key) & 0xfff;
			disk_vol_ofs <<= 4;
		}
		this.dir_offset = disk_vol_ofs;
		for(let i = 8; i < 12; i++) {
			mcr += hex(this.buf1[i]);
		}
		this.vrec_extra = mcr;
		this.read_media_sector(disk_vol_ofs, this.buf1);
		this.reorg_date = this.view1.getUint16(10, false);
		this.reorg_errors = this.view1.getUint8(12);
		const vol_ual_sect = u24(this.buf1, 13);
		this.name = '';
		if(disk6_flag == 0xfdfd) {
			this.status = '<<< INIT >>>';
		} else if(disk6_flag == 0xffff || disk6_flag == 0) {
			this.name = '';
			if(vol_ual_sect == 0) {
				this.status = '<<< NUL >>>';
			} else if(vol_ual_sect >= this.max_sector) {
				if(disk6_flag == 0xffff)
					this.status = '<<<  6  >>>';
				else this.status = '<<<  5  >>>';
			} else {
				this.name = fixed_str(this.buf1, 0, 10);
				this.status = '';
			}
		} else this.status = `<<< ${hex(disk6_flag,4)}>>>`;

		let entry = 16;
		if(disk6_flag != 0xffff) return;
		let ent_itr = 0;
		let bad_itr = 0;
		let ent_index = 0;
		this.ual_sector = vol_ual_sect;
		let sector = disk_vol_ofs;
		const self = this;
		function dir_scan() {
			while(sector < self.max_sector) {
				for(; entry < 400; entry+=16) {
					if(bad_itr > 10) {
						self.directory[ent_index++] = `<<error limit exceeded>>`;
						return;
					}
					if(ent_itr > 800) return;
					ent_itr++;
					if(self.buf1[entry] == 0x84 && self.buf1[entry+1] == 0x8d) {
						self.directory[ent_index++] = `<<EOL>>`;
						return;
					}
					if(self.buf1[entry] == 0) { continue; }
					const fe = self.get_dir_ent(entry, vol_ual_sect);
					if(fe) {
						self.directory[ent_index++] = fe;
					}
				}
				entry = 0;
				sector++;
				self.read_media_sector(sector, self.buf1);
			}
		}
		dir_scan();
		this.directory.length = ent_index;
	}
	fmt_reorg() {
		if(this.reorg_date == 0) {
			return '<no reorg>';
		}
		return `${fmt_disk_date(this.reorg_date)} ${this.reorg_errors}`;
	}
}
function get_dirent_str(fe: FSDirEntry) {
	return `${fe.name} ${fe.ft.t} ${fe.t_len}${fe.s_len}${fe.fsi_str} ${
		hex(fe.cls)}${(fe.loadaddr != 0x8000)? ' ' + hex(fe.loadaddr,4) : ''
	} <${hex(fe.map_sect,4)}:${hex(fe.map_index)}> ${
		fmt_disk_date(fe.date)
	}`;
}
class DiskViewer {
	images:{n:HTMLDivElement, vol?: DiskVol}[] = [];
	images_con:HTMLDivElement;
	listing:{n:HTMLDivElement, file?: number}[] = [];
	//listing_lproxy: HTMLDivElement;
	listingc: HTMLDivElement;
	datae:{a:HTMLDivElement, d:HTMLDivElement, t:HTMLDivElement}[] = [];
	datae_lproxy: HTMLDivElement;
	datae_con_a: HTMLDivElement;
	datae_con_d: HTMLDivElement;
	datae_con_t: HTMLDivElement;
	image_index = 0;
	listing_index = 0;
	datae_index = 0;
	sel_disk = -1;
	sel_file = -1;
	static fsi_s = [
		0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
	].map(function(x) { return ((x > 3) ? `${1<<(x - 4)}T` : `${1<<x}S`).padStart(4); });
	constructor() {
		const left_box = frame_disks.base.children[1] as HTMLDivElement;
		this.images_con = left_box.children[0].children[0] as HTMLDivElement;
		const listscrollbox = left_box.children[1] as HTMLDivElement;
		const datascrollbox = frame_disks.base.children[2] as HTMLDivElement;
		//this.listing_lproxy = listscrollbox.children[0] as HTMLDivElement;
		this.listingc = listscrollbox.children[0] as HTMLDivElement;
		this.datae_lproxy = datascrollbox.children[0] as HTMLDivElement;
		this.datae_con_a = datascrollbox.children[1] as HTMLDivElement;
		this.datae_con_d = datascrollbox.children[2] as HTMLDivElement;
		this.datae_con_t = datascrollbox.children[3] as HTMLDivElement;
	}
	on_img_click(index:number, ev:MouseEvent) {
		if(this.sel_disk == index)
			return;
		if(this.sel_disk > -1)
			style_off(this.images[this.sel_disk].n, 'a');
		this.sel_disk = index;
		const ent = this.images[index];
		style_if(ent.n, 'a', true);
		this.update();
	}
	on_list_click(index:number, ev:MouseEvent) {
		if(this.sel_file == index) return;
		if(this.sel_file > -1) {
			style_off(this.listing[this.sel_file].n, 'a');
		}
		const ent = this.listing[index];
		this.sel_file = index;
		if(ent.file) {
			style_if(ent.n, 'a', true);
			this.sector_list(ent.file);
		}
	}
	get_img_elem() {
		const self = this;
		const index = this.image_index;
		this.image_index++;
		let li = this.images[index];
		if(li) return li;
		li = {
			n: document.createElement('div')
		};
		li.n.addEventListener('click', function(ev) {
			self.on_img_click(index, ev);
		});
		this.images_con.appendChild(li.n);
		this.images[index] = li;
		return li;
	}
	private get_list_elem() {
		let li = this.listing[this.listing_index];
		if(li == null) {
			li = {
				n: document.createElement('div'),
			};
			const self = this;
			const index = this.listing_index;
			li.n.addEventListener('click', function(ev) {
				self.on_list_click(index, ev);
			});
			this.listingc.appendChild(li.n);
			this.listing[this.listing_index] = li;
		}
		this.listing_index++;
		return li;
	}
	private drop_list_elems() {
		this.listing.length = this.listing_index;
		while(this.listingc.childElementCount > this.listing_index) {
			this.listingc.removeChild(this.listingc.lastChild as ChildNode);
		}
	}
	private drop_datae_elems() {
		let it_datae = this.datae.length;
		while(it_datae > this.datae_index) {
			it_datae -= 1;
			let li = this.datae[it_datae];
			this.datae_con_a.removeChild(li.a);
			this.datae_con_d.removeChild(li.d);
			this.datae_con_t.removeChild(li.t);
		}
		this.datae.length = this.datae_index;
	}
	private get_datae_elem() {
		let li = this.datae[this.datae_index];
		if(li == null) {
			li = {
				a: document.createElement('div'),
				d: document.createElement('div'),
				t: document.createElement('div')
			};
			this.datae_con_a.appendChild(li.a);
			this.datae_con_d.appendChild(li.d);
			this.datae_con_t.appendChild(li.t);
			this.datae[this.datae_index] = li;
		}
		this.datae_index++;
		return li;
	}
	private sector_list(file_id: number) {
		this.datae_index = 0;
		let im_line = this.images[this.sel_disk];
		if(im_line == undefined || im_line.vol == undefined) return;
		const vol = im_line.vol;
		const dent = vol.directory[file_id];
		if(dent == undefined) {
			this.get_datae_elem().d.innerText = 'undef';
			this.drop_datae_elems();
			return;
		} else if(typeof dent == 'string') {
			this.get_datae_elem().d.innerText = 'error';
			this.drop_datae_elems();
			return;
		}
		const sec = vol.read_ual_sectors(dent);
		let addr = 0;
		const buf = vol.buf1;
		for(let ali = 0; ali < sec.length; ali++) {
			for(let fsi = 0; fsi < dent.fsi; fsi++) {
				vol.read_media_sector(sec[ali] + fsi, buf);
				let line = '';
				let txtl = '';
				for(let i = 0; i < 400; i++) {
					let c = buf[i];
					line += hex(c,2);
					if((c >= 0xa0) && (c < 0xff))
						txtl += String.fromCharCode(c & 127)
					else if(c > 0 && c < 0xa0) txtl += '.';
					else txtl += '?';
					if((i & 15) == 15) {
						let dat_line = this.get_datae_elem();
						dat_line.a.innerText = hex(addr, 5);
						dat_line.d.innerText = line;
						dat_line.t.innerText = txtl;
						line = '';
						txtl = '';
						addr += 16;
					} else {
						line += ' ';
					}
				}
				if(line.length > 0) {
					let dat_line = this.get_datae_elem();
					dat_line.a.innerText = hex(addr, 5);
					dat_line.d.innerText = line;
					dat_line.t.innerText = txtl;
				}
			}
		}
		this.drop_datae_elems();
	}
	private list_disk_name(n:string) {
		let li = this.get_img_elem();
		li.n.classList.add('disk');
		li.n.innerText = n;
		return li;
	}
	private list_vol_info(n:string) {
		let li = this.get_list_elem();
		li.n.classList.add('vol');
		li.n.innerText = n;
	}
	private list_file_name(n:string) {
		let li = this.get_list_elem();
		li.n.classList.add('file');
		li.n.innerText = n;
		return li;
	}

	update() {
		if(this.sel_file > -1) {
			style_off(this.listing[this.sel_file].n, 'a');
			this.sel_file = -1;
		}
		disk_view_update = false;
		this.image_index = 0;
		this.listing_index = 0;
		this.datae_index = 0;
		for(let i = 0; i < disk_images.length; i++) {
			const disk = disk_images[i];
			let disk_rec = this.list_disk_name(disk_image_luid(disk));
			if(this.sel_disk == i) {
				let vol: DiskVol;
				if(disk_rec.vol) vol = disk_rec.vol;
				else {
					vol = new DiskVol(disk);
					disk_rec.vol = vol;
				}
				vol.decode_image();
				this.list_vol_info(`k=${vol.key} SYSDATE:${fmt_disk_date(vol.sys_date)} ${vol.guarded ? 'GUARDED':''} o=${hex(vol.dir_offset,4)} [${vol.vrec_extra}]`);
				this.list_vol_info(`vol=${vol.name} ${vol.fmt_reorg()} [${hex(vol.ual_sector, 6)}]`);
				for(let i = 0; i < vol.directory.length; i++) {
					const fe = vol.directory[i];
					if(typeof fe == 'string') {
						this.list_vol_info(fe);
					} else {
						this.list_file_name(get_dirent_str(fe)).file = i;
						if(fe.ft.i == 5) {
							// libs
						}
					}
				}
			}
		}
		this.drop_list_elems();
	}
}
disk_view = new DiskViewer();

const enum MEMSTAT {
	IO = 0x200,
	P_ODD = 0x100,
	ACC_BRK = 0x1000,
	RD_BRK = 0x2000,
	WT_BRK = 0x4000,
	ALL_BRK = 0x7000,
	OPEN = 0x8000,
}
class DiagIO implements MemAccess {
	// TOS:1a, Aux:1d, Hawk:17-19, MUXINT:16, DMA:11/13
	dip = 0x0d;
	hexout = 0;
	points = 0;
	blank = false;
	readmeta(address: number):number { return MEMSTAT.IO; }
	writemeta(address: number, value: number): void {}
	readbyte(f:number):number {
		let v;
		switch(f) {
		case 6: this.blank = false; break;
		case 7: this.blank = true; break;
		case 8: this.points |= 1; break;
		case 9: this.points &= 0xe; break;
		case 10: this.points |= 2; break;
		case 11: this.points &= 0xd; break;
		case 12: this.points |= 4; break;
		case 13: this.points &= 0xb; break;
		case 14: this.points |= 8; break;
		case 15: this.points &= 0x7; break;
		case 16: v = this.dip & 255;
			return v;
		default: console.log('DIAG R/W',hex(f));
			return 0;
		}
		cx_diag.clearRect(0, 0, 40, 50);
		if (!this.blank) {
			cx_diag.fillText((this.hexout >> 4).toString(16).toUpperCase(), 14, 20);
			cx_diag.fillText((this.hexout & 15).toString(16).toUpperCase(), 14, 40);
		}
		if ((this.points & 8) != 0) cx_diag.fillRect(8, 22, 2, 2);
		if ((this.points & 2) != 0) cx_diag.fillRect(8, 42, 2, 2);
		if ((this.points & 4) != 0) cx_diag.fillRect(28, 22, 2, 2);
		if ((this.points & 1) != 0) cx_diag.fillRect(28, 42, 2, 2);
		return 0;
	}
	writebyte(f:number, v:number):void {
		if (f == 16) this.hexout = v;
		this.readbyte(f);
	}
}
const cx_diag0 = new DiagIO();
let cx_dip = cx_diag0.dip;

interface MemAccess {
	readbyte(address:number):number;
	readmeta(address:number):number;
	writemeta(address:number, value:number):void;
	writebyte(address:number, value:number):void;
}
interface IOAccess {
	is_interrupt():boolean;
	getlevel():number;
	acknowledge():boolean;
	reset():void;
}
interface AddressTransform {
	remap?:number[];
	invert?:boolean;
}

class DSK2Unit implements DiskContainer {
	set_disk(image: DiskImage|null): void {
		this.image = image;
		console.log(`set disk to ${image?.filename}`);
	}
	sel_address = 0;
	image:DiskImage|null = null;
}
const DSK2Commands = ['Read  ','Write ','Seek  ','SeekTZ','Verify','Format','FPre  '];
class DSK2 implements MemAccess, IOAccess, DMADevice {
	readmeta(address: number):number { return MEMSTAT.IO; }
	writemeta(address: number, value: number): void {}
	sel_unit = 0;
	sel_address = 0;
	units = [new DSK2Unit(), new DSK2Unit()];
	busy = false;
	busy_time = 0;
	busy_timeout = 0;
	addr_err = false;
	format_err = false;
	time_err = false;
	wpmask = 0;
	seeking = false;
	seek_done = false;
	sect_remain = 0;
	sect_crc = 0;
	sect_info_crc = -1;
	sect_base = 0;
	stat_start_sector = 0;
	stat_transfer_count = 0;
	stat_log_transfers = false;
	command = -1;
	format_permit = false;
	interrupt_en = false;
	interrupt_pend = false;
	dma_request = false;
	dma_mask = 0;
	dma_op = 0;
	dma_selected = false;
	verify_fail = false;
	is_interrupt(): boolean { return false; }
	getlevel():number { return 2; } // not used, but seems like a good number :)
	acknowledge():boolean { return false; }
	reset(): void {
		this.command = -1;
		this.format_permit = false;
		this.seeking = false;
		this.seek_done = false;
		this.busy = false;
		this.addr_err = false;
		this.busy_time = 0;
		this.wpmask = 0;
		this.sel_unit = 0;
		this.interrupt_en = false;
		this.interrupt_pend = false;
		mcsim.dma_int(this, false);
	}
	clear_errors():void {
		this.addr_err = false;
		this.format_err = false;
		this.verify_fail = false;
		this.time_err = false;
	}
	dma_select(enable: boolean, dev: number):void {
		const was_selected = this.dma_selected;
		this.dma_selected = enable && (dev == 0);
		if(was_selected != this.dma_selected) {
			mcsim.dma_int(this, this.interrupt_pend && this.interrupt_en);
		}
	}
	tickbusy() {
		this.busy_time--;
		if (this.busy_time == 0) {
			if(this.busy) this.interrupt_pend = true;
			this.busy = false;
			switch(this.command) {
			case 0:
			case 1:
			case 4:
			case 5:
				if(this.stat_log_transfers) {
					console.log(
						`DSK ${DSK2Commands[this.command]
						} S:${hex(this.stat_start_sector, 4)
						}/${hex(this.sel_address, 4)} DMA:`,
						this.stat_transfer_count,
						this.interrupt_pend ? 'Int':'-',
						this.format_err ? '!Fmt':'-',
						this.addr_err ? '!Addr':'-',
						this.verify_fail ? '!Data':'-');
				}
				this.stat_transfer_count = 0;
				break;
			case 6:
				//if (this.interrupt_en) mcsim.dma_int(true);
				break;
			case 2:
				this.seeking = false;
				this.seek_done = true;
				this.interrupt_pend = true;
				break;
			case 3:
				this.seeking = false;
				this.seek_done = true;
				this.interrupt_pend = true;
				break;
			default:
				if (this.command != -1) {
					console.log('unknown command');
				}
			}
			mcsim.dma_int(this, this.dma_selected && this.interrupt_pend && this.interrupt_en);
			this.command = -1;
		}
	}
	run(increment:number):void {
		if (this.busy) {
			this.busy_timeout += increment;
			if (this.command < 2 || this.command == 4 || this.command == 5) {
				const unit = this.units[this.sel_unit & 7];
				if(unit != null && unit.image != null) this.busy_timeout = 0;
			}
			if (this.busy_timeout > 300000) {
				this.busy = false;
				this.time_err = true;
			}
		}
		if (this.busy_time > 0) {
			this.tickbusy();
		}
	}
	readbyte(address:number):number {
		let v = 0;
		const unit = this.units[this.sel_unit & 7];
		switch(address) {
		case 0:
			v = this.sel_unit | 0xf0;
			break;
		case 1: // cylh
			v = this.sel_address >> 8;
			break;
		case 2: // cyll:h:sec
			v = this.sel_address & 0xff;
			break;
		case 3: // wpmask?
			v = this.wpmask;
			break;
		case 4: // stat hi
			// tmoerr crcdaterr adrerr fmterr | 0 seekerr fault busy
			v = (this.time_err ? 0x80:0) | (this.verify_fail ? 0x40:0) |
			(this.addr_err ? 0x20:0) | (this.format_err ? 0x10:0) |
			(this.busy ? 1 : 0);
			break;
		case 5: // stat lo / wtpr wten oncyl ready | seekcom3..0
			if (unit) {
				v = ((unit.image?.protect !== false) ? 0x80 : 0) /* wp */ |
				((this.wpmask & (1 << (this.sel_unit & 7))) ? 0x40 : 0) |
				(this.seeking ? 0 : 0x20) /* oncyl */ |
				(unit.image != null ? 0x10 : 0) /* ready */ |
				(this.seek_done ? 0x01 : 0);
			} else {
				v = (this.seek_done ? 0x01 : 0);
			}
			break;
		case 8: // get input shift register
			break;
		case 9: // get output shift register
			break;
		case 10: // get state (gates | FSM next)
			break;
		default:
			return 255;
		}
		return v;
	}
	dma_step(ctrl:DMAControl):void {
		const unit = this.units[this.sel_unit & 7];
		const unitdata = unit.image;
		if (unit == null || unitdata == null) return;
		if (mcsim.dma_end) {
			ctrl.end();
			this.busy_time = 10;
			if(this.dma_op == 2 && frame_disks.show) disk_view_update = true;
		} else {
			if (this.sect_remain <= 0) {
				this.sect_remain = 400;
				let sela = (this.sel_address + 1) & 255;
				this.sel_address = (this.sel_address & 0xff00) | sela;
				if(this.dma_op == 2 && frame_disks.show) disk_view_update = true;
			}
			if (this.sect_remain == 400) {
				if((this.sel_address & 0xffe0) != (unit.sel_address & 0xffe0)) {
					this.addr_err = true;
					ctrl.end();
					this.busy_time = 200;
					return;
				}
				const fileaddr = this.sel_address * unitdata.stride;
				this.sect_base = fileaddr;
				this.sect_crc = 0;
				this.sect_info_crc = -1;
				if(unitdata.stride > 400) {
					let info = unitdata.data[fileaddr + 402];
					// emulation feature
					// meta info about the sector after it
					if(info == 0x43) { // sector has a CRC
						this.sect_info_crc =
						(unitdata.data[fileaddr + 400] << 8) |
						unitdata.data[fileaddr + 401]
					} else if(info == 0x41) { // forced sector address error
						this.addr_err = true;
						ctrl.end();
						this.busy_time = 20;
						return;
					} else if(info == 0x46) { // sector format error
						this.format_err = true;
						ctrl.end();
						this.busy_time = 20;
						return;
					}
				}
			}
			const secofs = this.sect_base + 400 - this.sect_remain;
			const b = unitdata.data[secofs];
			let d = 0;
			if(this.dma_op != 1) d = ctrl.read();
			switch(this.dma_op) {
			case 0: // verify
				this.sect_crc = this.sect_crc ^ (((this.sect_remain & 1)==0) ? b << 8 : b);
				if(d != b) {
					this.verify_fail = true;
				}
				break;
			case 1: // read
				this.sect_crc = this.sect_crc ^ (((this.sect_remain & 1)==0) ? b << 8 : b);
				ctrl.write(b);
				break;
			case 2: // write
				this.sect_crc = this.sect_crc ^ (((this.sect_remain & 1)==0) ? d << 8 : d);
				unitdata.data[secofs] = d;
				break;
			}
			this.stat_transfer_count += 1;
			this.sect_remain--;
			if(this.sect_remain == 0) {
				if(/*this.dma_op == 2 &&*/ unitdata.stride > 400) {
					unitdata.data[this.sect_base + 400] = (this.sect_crc >> 8) & 255;
					unitdata.data[this.sect_base + 401] = this.sect_crc & 255;
					//unitdata.data[this.sect_base + 402] = 0x43;
				} else if(this.sect_info_crc != -1) {
					if (this.sect_info_crc != this.sect_crc) {
						this.verify_fail = true;
						ctrl.end();
						this.busy_time = 20;
					}
				}
			}
		}
	}
	do_dma_read() {
		this.dma_request = true;
		this.dma_op = 1;
		mcsim.dma_request();
	}
	do_dma_write() {
		this.dma_request = true;
		this.dma_op = 2;
		mcsim.dma_request();
	}
	do_dma_verify() {
		this.dma_request = true;
		this.dma_op = 0;
		mcsim.dma_request();
	}
	writebyte(address:number, value:number):void {
		const unitindex = this.sel_unit & 7;
		const unit = this.units[unitindex];
		switch(address) {
		case 0:
			this.sel_unit = value & 0xF;
			break;
		case 1: // cylh
			this.sel_address = (this.sel_address & 0xff) | (value << 8);
			break;
		case 2: // cyll:h:sec
			this.sel_address = (this.sel_address & 0xff00) | (value & 0xff);
			break;
		case 3: // wpmask
			this.wpmask = value & 0xff;
			break;
		case 8: // cmd
			this.clear_errors();
			this.busy_timeout = 0;
			if((value & 2) == 0) this.busy = true;
			if (unit == null) break;
			this.seek_done = false;
			this.command = value;
			if(value != 5) {
				this.format_permit = false;
			}
			switch (value & 7) {
			case 0:// 0=read
				//console.log('DSK2:read:', hex(u.sel_address, 4));
				this.busy_time = 0;
				this.sect_remain = 400;
				this.stat_start_sector = this.sel_address;
				this.do_dma_read();
				break;
			case 1: // 1=write
				this.busy_time = 0;
				this.sect_remain = 400;
				this.stat_start_sector = this.sel_address;
				this.do_dma_write();
				if (((this.wpmask & (1 << unitindex)) == 0) || (unit.image?.protect !== false)) {
					this.dma_op = 3;
					console.log('DSK2:wp_write:', hex(unit.sel_address, 4));
				}
				break;
			case 2: // 2=seek
				//console.log('DSK2:seek:', hex(this.sel_address, 4));
				this.busy_time = 40;
				this.seeking = true;
				unit.sel_address = this.sel_address;
				break;
			case 3: // 3=rtzcal
				//console.log('DSK2:rtz');
				unit.sel_address = this.sel_address = 0;
				this.busy_time = 200;
				this.seeking = true;
				break;
			case 4: // verify (typically issued after cmd 1)
				this.busy_time = 0;
				this.sect_remain = 400;
				this.stat_start_sector = this.sel_address;
				//console.log('DSK2:do_verify:', hex(u.sel_address, 4));
				this.do_dma_verify();
				break;
			case 5: // format write
				if(this.format_permit) {
					this.busy_time = 0;
					this.sect_remain = 400;
					this.stat_start_sector = unit.sel_address;
					this.do_dma_write();
				} else {
					this.busy_time = 10;
				}
				break;
			case 6: // format write permit
				this.format_permit = true;
				break;
			default:
				console.log('DSK2:cmd:', value & 7, hex(unit.sel_address, 4));
				break;
			}
			break;
		case 9: // diag register
			break;
		case 10: // diag clocks
			break;
		case 11: // reset card with unit select
			this.reset();
			this.sel_unit = value & 0xF;
			break;
		case 12: // force interrupt
			this.interrupt_pend = true;
			mcsim.dma_int(this, this.dma_selected && this.interrupt_en);
			//console.log('DSK2:W:IFORCE');
			break;
		case 13: // disable interrupt gate
			this.interrupt_en = false;
			mcsim.dma_int(this, false);
			break;
		case 14: // enable interrupt gate
			this.interrupt_en = true;
			mcsim.dma_int(this, this.dma_selected && this.interrupt_pend);
			break;
		case 15: // clear interrupt
			this.interrupt_pend = false;
			mcsim.dma_int(this, false);
			break;
		default:
			console.log('DSK2:W:', hex(address, 1), hex(value));
		}
		return;
	}
}

class MockPrinter implements MemAccess, CharDevice {
	readmeta(address: number):number { return MEMSTAT.IO; }
	writemeta(address: number, value: number): void {}
	rts = true;
	readbyte(address: number): number {
		let value = 0;
		if(address == 1) {
			value = 31; // don't know the actual status, but this works :D
		}
		return value;
	}
	writebyte(address: number, value: number): void {
		if (address == 0) {
			this.receive(value);
		}
	}
	// the printer never sends anything
	get_dev(): CharDevice | undefined { return undefined; }
	bind_dev(dev: CharDevice | undefined): void {}
	can_receive(): boolean { return true; }
	receive(v: number): void {
		let c;
		v &= 127;
		if (v == 12) {
			c = "\u21ca\n";
		} else {
			c = String.fromCodePoint(v);
		}
		txt_anno.value += c;
	}
	set_cts(value: boolean): void {}
	check_send(): void {}
}

const ccitt = new Uint16Array(256);
{
	let flip = 69665; // non-standard repr
	for(let i = 0; i < 256; i++) {
		let v = i << 8;
		for(let x = 0; x < 8; x++) {
			v = (v<<1) ^ (((v&32768)!=0)?flip:0);
		}
		ccitt[i] = ((v >> 8) & 255) | ((v << 8) & 65280);
	}
}
function crc_add(crc:number, b:number):number {
	return ((crc >> 8) ^ ccitt[(crc ^ b) & 255]) & 65535;
}
//@ts-ignore
window.crc_add = crc_add;

const UNIT_SELECT = [-1,0,1,-1,2,-1,-1,-1,3,-1,-1,-1,-1,-1,-1,-1];
class FinchUnit implements DiskContainer {
	// unit vars
	sector_byte = 0;
	start_of_disk = false;
	start_of_sector = 0;
	track = 7;
	rotation = 0;
	track_base = 0;
	last_rotation_index = 0;
	data:Uint8Array|undefined;
	backing_cache:Uint8Array|null = null;
	image: DiskImage | null = null;
	status = 0;
	use_backing() {
		if(this.backing_cache == null) {
			this.backing_cache = new Uint8Array(FINCH_PLAT*4);
			this.data = this.backing_cache;
			this.status = 7;
		}
	}
	set_disk(image: DiskImage | null): void {
		this.image = image;
		if (image != null) {
			if(image.stride != FINCH_TRACK) this.use_backing();
			else {
				this.data = image.data;
				const l = image.backing_data.byteLength;
				if(l == FINCH_PLAT*4) this.status = 7;
				if(l == FINCH_PLAT*3) this.status = 5;
				if(l == FINCH_PLAT*2) this.status = 3;
				if(l == FINCH_PLAT) this.status = 1;
			}
		} else {
			this.data = undefined;
			this.status = 0;
		}
	}
}
class FinchFloppyControl implements MemAccess, Run, IOAccess, DMADevice {
	is_interrupt(): boolean { return false; }
	getlevel(): number { return 0; }
	acknowledge(): boolean { return false; }
	dma_select(enable: boolean, dev: number): void {}
	sys_data: number = 0;
	flag_cardtocpu: boolean = false; // bit 0
	flag_cputocard: boolean = false; // bit 1
	flag_2 = false; // bit 2
	busy: boolean = false; // bit 3
	interrupt_priority = 0;
	address = 0;
	cardram = new Uint8Array(0x1000);
	dma_read = false;
	dma_request = false;
	dma_mask = 0;
	dma_active = false;
	dma_cycle = false;
	dcr1 = 0;
	dcr2 = 0;
	ssbc = 0;
	fdsr2s = 0;
	fdsr2r = 0;
	drive_sel_unit = -1;
	tsm = 255;
	tsm_timeout = 0;
	data_edge = 128;
	crc_reg = 0;
	crc_en = false;
	crc_out = false;
	unit_1 = new FinchUnit();
	// Finch: 3600 RPM nominal (60 rev/s)
	// per rev: 1 index, 13440(0x3480) bytes, 107520 bits
	// 806400 bytes per second
	// servo/data clock: 6451200 Hz
	// max tracks: 0 to 0x25c / 0 to 604 / or 605 total
	// sector index pulse
	// 16 byte times
	// sector address block:
	// Pre:(0xA5) TrackH TrackL Platter# Sector# BlockCRC
	// BlockCRC is X16+X12+X5+1 (CCITT 16)
	// a5 00 12 00 00 RR RR
	// 0,0,0,0,0,0,0,0, // Address=>Data blank
	// 0x96,0, // data mark
	// 400 bytes of data
	// CRC
	// blank space
	// next sector
	// each track: (from format)
	// 23: Index, 11 ISG(0), 12 PLO(0)
	//  7: sector0 address: sy THTL PL SN CCCC
	// 14: byte space
	//  2: data mark, 0
	//400: byte of sector0 data
	//  2: crc
	// 37: byte space
	// sector1 address
	// ...
	// sector28 (1C) data,crc
	// 13384 bytes
	// 14 more space
	// end of track marker (CRCOut spam)
	// end unit vars
	seq = new Sequencer8X02();
	aluc = new ALU8();
	flag_reg = 0;
	flag_dne = 0;
	log_enable = false;
	constructor() {
		ffc_log.addEventListener('click', (ev)=>{
			this.log_enable = !this.log_enable;
			style_if(ffc_log, 'active', this.log_enable);
		});
		style_if(ffc_log, 'active', this.log_enable);
	}
	readmeta(address: number):number { return MEMSTAT.IO; }
	writemeta(address: number, value: number): void {}
	// Clocks:
	// Count:  0   1   2   3   4   5   6   7   8   9  10  11  12
	// Shift . 1 . 1 . 1 . 1 . 1 . 1 . 1 . 1 . 1 . 1 . 1 . 1 . 1
	// Byte  . 1 1 1 1 1 1 1 1 . . . . . . . . 1 1 1 1 1 1 1 1 .
	// Index . . . . . 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 . . . . .
	run(increment: number): void {
		if(this.log_enable) this.step(true, true);
		const unit_1 = this.unit_1;
		if(++unit_1.rotation >= 107520) {
			unit_1.rotation = 0;
			unit_1.start_of_disk = true;
		} else if(unit_1.rotation == 10) unit_1.start_of_disk = false;
		let where = unit_1.rotation >> 3;
		let phase = unit_1.rotation & 7;
		if(phase == 0) {
			if(unit_1.start_of_disk || unit_1.sector_byte == 0xfff) {
				unit_1.sector_byte = this.ssbc;
			} else {
				unit_1.sector_byte++;
			}
		} else if(phase == 4) {
			if(unit_1.start_of_disk || unit_1.sector_byte == 0xfff)
				unit_1.start_of_sector = 2;
			else if(unit_1.start_of_sector != 0) unit_1.start_of_sector--;
		}
		const ltsm = (this.tsm & 127);
		// writing to unit 1
		if((this.drive_sel_unit == 1) && (unit_1.data != undefined)) {
			const mpc = this.seq.p;
			const m0 = ffcmc.r1[mpc];
			const m6 = ffcmc.r7[mpc];
			const rds_sel = (m0 & 8) != 0;
			const crc_out = (m6 & 16) != 0;
			const crc_ena = (m0 & 128) != 0;
			let frw = (this.dcr1 & 0x40) | (this.dcr2 & 0x10);
			if(phase == 0 && rds_sel && frw == 0x40) {
				let next = where + 1;
				if(next >= FINCH_TRACK) next = 0;
				if((unit_1.data[next+unit_1.track_base] & 128) != 0) {
					this.data_edge = 0;
				}
			}
			if(phase == 7 && frw == 0x10) {
				//txt_anno.value += `|${crc_out ?'RR':(this.fdsr2 == 0?'..':hex(this.fdsr2))}:${hex(this.sector_byte,3)}${hex(where,4)}${phase}`;
				//if((where & 3) == 3) {txt_anno.value +='\n';}
				let wr = this.fdsr2s;
				this.fdsr2s = 0;
				if(this.crc_out) {
					wr = this.crc_reg & 255;
				}
				if(this.crc_en) {
					this.crc_reg = crc_add(this.crc_reg, wr);
				}
				unit_1.data[where+unit_1.track_base] = wr;
			}
			this.tsm = ffcmc.tsm[ltsm | this.data_edge];
			this.data_edge |= 128;
			const tsmset = (ltsm ^ 127) & this.tsm;
			if(frw == 0x40 && (tsmset & 32) != 0) {
				this.fdsr2r = unit_1.data[where+unit_1.track_base];
				if(this.crc_en) {
					this.crc_reg = crc_add(this.crc_reg, this.fdsr2r);
				}
			}
			if(phase == 4) {
				this.crc_en = crc_ena;
				this.crc_out = crc_out;
			}
		} else {
			this.tsm = ffcmc.tsm[ltsm | this.data_edge];
			this.data_edge |= 128;
		}
		// if(ltsm == 0x85 && this.data_edge == 0) {
		// txt_anno.value += `TSM Mark ${hex(where,4)}.${phase}\n`;
		// }
		// if((ltsm != 0x05) && (this.tsm | this.data_edge) == 0x85) {
		// txt_anno.value += `TSM Wait ${hex(where,4)}.${phase}\n`;
		// }
		this.tsm_timeout++;
		if(this.tsm_timeout >= 255) {
			this.tsm_timeout = 0;
			this.tsm = 0x7f;
			//txt_anno.value += `TSM Timeout ${this.track_base} ${hex(where,4)}.${phase}\n`;
		}
		if((ltsm & 3) == 0 && (this.tsm & 3) != 0) {
			// precheck idle state to save on sim time
			if(this.seq.p != 0x2B5 || this.flag_cputocard || run_rate <= 10000)
				this.step(false);
			this.tsm_timeout = 0;
		}
	}
	step(for_display:boolean, log:boolean=false) {
		const mpc = this.seq.p;
		const m0 = ffcmc.r1[mpc];
		const m1 = ffcmc.r2[mpc];
		const m2 = ffcmc.r3[mpc];
		const mval = ffcmc.r4[mpc];
		const m4 = ffcmc.r5[mpc];
		const m5 = ffcmc.r6[mpc];
		const m6 = ffcmc.r7[mpc];
		const m7 = ffcmc.r8[mpc];

		const f2_sel = m0 & 7;
		const rds_sel = (m0 & 8) != 0;
		const f1_sel = (m0>>4) & 7;
		const crc_ena = (m0 & 128) != 0;
		const k2_sel = m1 & 15;
		const k1_sel = (m1>>4) & 15;
		const flag_inv = m2 & 1;
		const e1_sel = (m2>>1) & 7;
		const test_inv = (m2 & 16) != 0;
		const d1_sel = (m2>>5) & 7;
		const alu_a = m4 & 15;
		const alu_b = m4 >> 4;
		const alu_s = m5 & 7;
		const addr_inc = (m5 & 8) != 0;
		const alu_f = (m5>>4) & 7;
		// on the falling edge, dma starts a cycle when this is low
		const dma_inc = (m5 & 128) == 0;
		// m6 -> DataRtoW | TSM_CSel | CRC_Reset | CRC_Out | tp_d | alu_d[2:0]
		const alu_d = m6 & 7;
		const tp_d = (m6 & 8) != 0;
		const crc_out = (m6 & 16) != 0;
		const crc_reset = (m6 & 32) != 0;
		const tsm_csel = (m6 & 64) != 0;
		const data_bridge = (m6 & 128) != 0;
		const seq_ac = m7 & 7;
		const e2_sel = (m7>>4) & 7;
		const seq_branch_hi = ((m7<<2) & 0x200) | ((m7<<5) & 0x100);

		const flag_reg = this.flag_reg;
		let data_in = 0;

		const unit_1 = this.unit_1;
		let where = unit_1.rotation >> 3;
		let phase = unit_1.rotation & 7;
		switch(k2_sel) {
		case 0: // TODO ReadFS1:
			//FaultRst | ReadEna | CRCErr | LossOfSync | UnitSelect[3:0]
			//if(!for_display)txt_anno.value += `ReadFS1\n`;
			data_in = (this.crc_reg == 0 ?0:0x20) | /*0x10 |*/ (this.dcr1 & 0xcf); break;
		case 1: data_in = 0xfc | (this.dcr2 & 3); break; // ReadFS3
		case 2: // TODO ReadFS2
			// Finch supplies Index on the main cable when selected
			// FS2: Index | AtZero | WrFault | WrProt | EOS | Capacity[1:0] | Ready
			if(this.drive_sel_unit == 1) {
				data_in = (unit_1.start_of_disk ? 0x80 : 0) |
					0x10 | // wp
					(unit_1.track == 0 ? 0x40:0) |
					(unit_1.start_of_sector!=0 ? 8 : 0) |
					unit_1.status; // capacity/ready
				// if(where < 0x18 || this.start_of_disk || this.start_of_sector!=0) {
				// if(!for_display) txt_anno.value += `FS2:${this.start_of_disk?'Idx':''}${this.start_of_sector!=0?'Sec':''} ${hex(where,4)}.${phase}\n`;
				// }
			} else {
				data_in = 0;
			}
			break;
		case 3: // TODO ReadMCSR
			if(!for_display)txt_anno.value += `ReadMCSR\n`;
			data_in = 0xff;
			break;
		case 4: if(!for_display)txt_anno.value += `ReadFDSR1\n`; data_in = 0xff; break; // TODO ReadFSDR1
		case 5: txt_anno.value += `Readnop5\n`; break; // nop
		case 6: // TODO ReadFSDR2
			if(this.drive_sel_unit == 1) {
				if(!for_display) {
					//run_control(false);
					//txt_anno.value += `\\${hex(where, 4)}.${phase} ${hex(this.fdsr2)}\n`;
				}
			}
			data_in = this.fdsr2r;
			break;
		case 7: txt_anno.value += `Readnop7\n`; break; // nop
		case 8: data_in = 255 ^ this.address & 255; break; // ReadIndexL
		case 9: data_in = 255 ^ this.cardram[this.address]; break; // ReadRAM
		case 10: // ReadSysReg
			data_in = 255 ^ this.sys_data;
			this.flag_cputocard = false;
			break;
		case 11: // ReadStatus
			data_in = 255 ^ (
				(this.flag_cardtocpu ? 1 : 0) |
				(this.flag_cputocard ? 2 : 0) |
				(mcsim.dma_end ? 4 : 0));
			break;
		case 12: data_in = 255 ^ ((this.address >> 8) & 15); break; // ReadIndexH
		case 13: txt_anno.value += 'Readnop13\n'; break; // nop
		case 14: txt_anno.value += 'Readnop14\n'; break; // nop
		case 15: data_in = mval; break; // ReadConst
		}

		this.aluc.in_data = data_in;

		switch(e2_sel) {
		case 0: this.aluc.carry_in = 0; break;
		case 1: this.aluc.carry_in = 1; break;
		case 2: this.aluc.carry_in = 0; break; // defer: Shift RamOut
		case 3: this.aluc.carry_in = 0; break; // defer: Shift QOut
		case 4: this.aluc.carry_in = 1^flag_reg; break; // !flag
		case 5: this.aluc.carry_in = flag_reg; break; // flag
		case 6: this.aluc.carry_in = 0; break; // defer: carry
		case 7: this.aluc.carry_in = 0; break; // defer: sign
		}
		this.aluc.resolve_alu(alu_s, alu_f, alu_d, alu_a, alu_b);
		let shift_out_ram = 0;
		let shift_out_q = 0;
		if(this.aluc.is_right) { // Q7 >> ALU >> Q0, RAM7 >> ALU >> RAM0
			shift_out_q = this.aluc.q0;
			shift_out_ram = this.aluc.ram0;
		} else { // Q7 << ALU << Q0, RAM7 << ALU << RAM0
			shift_out_q = this.aluc.q7;
			shift_out_ram = this.aluc.ram7;
		}
		let deferred = false;
		// re-resolve on deferred change
		switch(e2_sel) {
		case 0: break; //0
		case 1: break; //1
		case 2: deferred = true; this.aluc.carry_in = shift_out_ram; break; // Shift RamOut
		case 3: deferred = true; this.aluc.carry_in = shift_out_q; break; // Shift QOut
		case 4: break; // !flag
		case 5: break; // flag
		case 6: deferred = true; this.aluc.carry_in = this.aluc.main_carry_out; break; // carry
		case 7: deferred = true; this.aluc.carry_in = this.aluc.sign; break; // sign
		}
		if(deferred) {
			this.aluc.resolve_alu(alu_s, alu_f, alu_d, alu_a, alu_b);
			if(this.aluc.is_right) { // Q7 >> ALU >> Q0, RAM7 >> ALU >> RAM0
				shift_out_q = this.aluc.q0;
				shift_out_ram = this.aluc.ram0;
			} else { // Q7 << ALU << Q0, RAM7 << ALU << RAM0
				shift_out_q = this.aluc.q7;
				shift_out_ram = this.aluc.ram7;
			}
		}

		let data_out = this.aluc.out_f;
		if(data_bridge) {
			data_out = data_in ^ 255;
		}

		if(for_display) {
			this.debug_output(data_in, data_out, log);
			return;
		}
		/////////////// Rising edge ///////////////
		if(dma_inc) this.dma_cycle = true;
		if(crc_reset) {
			this.flag_dne = 0;
			this.crc_reg = 0;
		}
		switch(e1_sel) {
		case 0: this.flag_reg = flag_inv ? 1 : 0; break;
		case 1: this.flag_reg = flag_inv ? flag_reg : 1^flag_reg; break;
		case 2: this.flag_reg = flag_inv ? shift_out_ram : 1^shift_out_ram; break;
		case 3: this.flag_reg = flag_inv ? shift_out_q : 1^shift_out_q; break;
		case 4: this.flag_reg = flag_inv ? this.aluc.main_carry_out : 1^this.aluc.main_carry_out; break;
		case 5: this.flag_reg = flag_inv ? this.aluc.over : 1^this.aluc.over; break;
		case 6: this.flag_reg = flag_inv ? this.aluc.sign : 1^this.aluc.sign; break;
		case 7: this.flag_reg = flag_inv ? this.aluc.half_carry_out : 1^this.aluc.half_carry_out; break;
		}
		let shift_in_q = 0;
		let shift_in_ram = 0;
		switch(f2_sel) {
		case 0: shift_in_q = 0; break;
		case 1: shift_in_q = 1; break;
		case 2: shift_in_q = shift_out_ram; break;
		case 3: shift_in_q = shift_out_q; break;
		case 4: shift_in_q = 1^flag_reg; break;
		case 5: shift_in_q = flag_reg; break;
		case 6: shift_in_q = this.aluc.main_carry_out; break;
		case 7: shift_in_q = this.aluc.sign; break;
		}
		switch(f1_sel) {
		case 0: shift_in_ram = 0; break;
		case 1: shift_in_ram = 1; break;
		case 2: shift_in_ram = shift_out_ram; break;
		case 3: shift_in_ram = shift_out_q; break;
		case 4: shift_in_ram = 1^flag_reg; break;
		case 5: shift_in_ram = flag_reg; break;
		case 6: shift_in_ram = this.aluc.main_carry_out; break;
		case 7: shift_in_ram = this.aluc.sign; break;
		}
		if(this.aluc.is_right) { // Q7 >> ALU >> Q0, RAM7 >> ALU >> RAM0
			this.aluc.q7 = shift_in_q;
			this.aluc.ram7 = shift_in_ram;
		} else { // Q7 << ALU << Q0, RAM7 << ALU << RAM0
			this.aluc.q0 = shift_in_q;
			this.aluc.ram0 = shift_in_ram;
		}
		let seq_test = 0;
		switch(d1_sel) { // this outputs the complement
		case 0: seq_test = 1; break; // always
		case 1: seq_test = flag_reg; break;
		case 2: seq_test = this.aluc.zero; break; // zero
		case 3: seq_test = this.aluc.main_carry_out; break; // carry
		case 4: seq_test = this.aluc.over; break; // overflow
		case 5: seq_test = this.aluc.sign; break; // sign
		case 6: seq_test = this.flag_dne; break; // Finch data verify
		case 7: seq_test = 0; txt_anno.value += 'MFMError\n'; break; // TODO rename these: disk_cond7
		}
		seq_test = test_inv ? seq_test : 1^seq_test;

		const prev_address = this.address;
		if (addr_inc) {
			if (k1_sel == 8) { // LoadIndexL
				if((prev_address & 255) == 255) {
					this.address = (this.address + 0x100) & 0xfff;
				}
			} else if (k1_sel == 11) { // LoadIndexH
				this.address = ((prev_address + 1) & 0xff) | (this.address & 0xf00);
			} else {
				this.address = (prev_address + 1) & 0xfff;
			}
		}
		let bitset;
		switch(k1_sel) {
		case 0: // WriteDCR1
			// FaultRst | RdEna | MFMCheck | FDSInDis | UnitSelect[3:0]
			//txt_anno.value += `WriteDCR1 ${hex(data_out)}\n`;
			bitset = (this.dcr1 ^ 255) & data_out;
			this.dcr1 = data_out;
			this.drive_sel_unit = UNIT_SELECT[data_out & 15];
			if((bitset & 0x40) != 0) {
				let head = ((this.dcr2 >> 5) & 2) | ((this.dcr2 >> 3) & 1);
				unit_1.track_base = unit_1.track * FINCH_TRACK + head * FINCH_PLAT;
				//txt_anno.value += `ReadEn ${hex(where,4)}.${phase}\n`;
			}
			break;
		case 1: // TODO WriteDCR2:
			// FDDWrGate | HSel1 | LowCur | WrEna | HSel0 | HeadLd/RTZ | Dir | Step
			bitset = (this.dcr2 ^ 255) & data_out;
			let head = ((this.dcr2 >> 5) & 2) | ((this.dcr2 >> 3) & 1);
			if((bitset & 1) != 0) {
				if((data_out & 2) != 0) {
					unit_1.track += 1;
					if(unit_1.track > 604) unit_1.track = 604;
				} else {
					unit_1.track -= 1;
					if(unit_1.track < 0) unit_1.track = 0;
				}
				unit_1.track_base = unit_1.track * FINCH_TRACK + head * FINCH_PLAT;
				//txt_anno.value += `Step ${this.unit_track}\n`;
			}
			if((bitset & 4) != 0) {
				unit_1.track = 0;
				unit_1.track_base = unit_1.track * FINCH_TRACK + head * FINCH_PLAT;
				//txt_anno.value += `RTZ\n`;
			}
			if((bitset & 0x10) != 0) {
				unit_1.track_base = unit_1.track * FINCH_TRACK + head * FINCH_PLAT;
			}
			//if((this.dcr2 ^ data_out) & 0xb0) {
				//txt_anno.value += `WriteDCR2 ${hex(data_out)} ${hex(where,4)}.${phase}\n`;
			//}
			this.dcr2 = data_out;
			
			break;
		case 2: // WriteSSBCL
			// (soft sector byte counter, size = 0x1000 - ssbc)
			this.ssbc = (this.ssbc & 0xf00) | data_out;
			break;
		case 3: // TODO WriteMCSR
			//txt_anno.value += `WriteMCSR ${hex(data_out)}\n`;
			// TODO this also triggers the Finch DNE check for the current byte
			if(data_in != this.fdsr2r) this.flag_dne = 1;
			break;
		case 4: // WriteFDSR
			this.fdsr2s = data_out;
			break;
		case 5: // TODO WriteFloppyPulse - raw pulse output to the floppy
			txt_anno.value += `WritePulse ${hex(where,4)}.${phase}\n`;
			break;
		case 6: // WriteSSBCH
			// (soft sector byte counter, size = 0x1000 - ssbc)
			this.ssbc = (this.ssbc & 0xff) | ((data_out & 15) << 8);
			break;
		case 7: // SetTSM - enter a different inital state
			this.tsm = 0x87 ^ (data_out & 6);
			// TODO this also clears:
			//   MCSR, FDSR1, MFM error states, and a modulator FF
			break;
		case 8: // WriteIndexL
			this.address = (this.address & 0xf00) | data_out;
			break;
		case 9: // WriteRAM
			this.cardram[this.address] = data_out;
			break;
		case 10: // WriteSys
			this.sys_data = data_out;
			this.flag_cardtocpu = true;
			break;
		case 11: // WriteIndexH
			this.address = (this.address & 0xff) | ((data_out & 15) << 8);
			break;
		case 12: // WriteCtrlReg: 0000 | busy | status2 | DMARead | DMARun
			this.dma_active = (data_in & 1) != 0;
			this.dma_read = (data_in & 2) != 0;
			this.flag_2 = (data_in & 4) != 0;
			this.busy = (data_in & 8) != 0;
			break;
		case 13: this.interrupt_priority = data_out & 15; break; // WriteIPL
		case 14: break; // nop
		case 15: break; // nop
		}
		if (!this.dma_request) {
			this.dma_request = this.dma_active || this.dma_cycle;
			mcsim.dma_request();
		}
		this.aluc.step(alu_d, alu_b);
		this.seq.commit(seq_ac, data_out | seq_branch_hi, seq_test != 0);
	}
	dma_step(ctrl: DMAControl): void {
		if(this.dma_cycle) {
			this.dma_cycle = false;
			if (this.dma_read) {
				this.sys_data = ctrl.read();
				this.flag_cputocard = true;
			} else {
				ctrl.write(this.sys_data);
				this.flag_cardtocpu = false;
			}
		}
		if(!this.dma_active) {
			ctrl.end();
			return;
		}
	}
	debug_output(data_in:number, data_out:number, log:boolean=false):void {
		if(!show_ffc) return;
		const mpc = this.seq.p;
		const m0 = ffcmc.r1[mpc];
		const m1 = ffcmc.r2[mpc];
		const m2 = ffcmc.r3[mpc];
		const mval = ffcmc.r4[mpc];
		const m4 = ffcmc.r5[mpc];
		const m5 = ffcmc.r6[mpc];
		const m6 = ffcmc.r7[mpc];
		const m7 = ffcmc.r8[mpc];
		const mcw0 = m0 | (m1<<8) | (m2<<16);
		const mcw1 = m4 | (m5<<8);
		const mcw2 = m6 | (m7<<8);

		const f2_sel = m0 & 7;
		const rds_sel = (m0 & 8) != 0;
		const f1_sel = (m0>>4) & 7;
		const crc_ena = (m0 & 128) != 0;
		const k2_sel = m1 & 15;
		const k1_sel = (m1>>4) & 15;
		const flag_inv = m2 & 1;
		const e1_sel = (m2>>1) & 7;
		const test_inv = (m2 & 16) != 0;
		const d1_sel = (m2>>5) & 7;
		const alu_a = m4 & 15;
		const alu_b = m4 >> 4;
		const alu_s = m5 & 7;
		const addr_inc = (m5 & 8) != 0;
		const alu_f = (m5>>4) & 7;
		// on the falling edge, dma starts a cycle when this is low
		const dma_inc = (m5 & 128) == 0;
		// m6 -> DataRtoW | TSM_CSel | CRC_Reset | CRC_Out | tp_d | alu_d[2:0]
		const alu_d = m6 & 7;
		const tp_d = (m6 & 8) != 0;
		const crc_out = (m6 & 16) != 0;
		const crc_reset = (m6 & 32) != 0;
		const tsm_csel = (m6 & 64) != 0;
		const data_bridge = (m6 & 128) != 0;
		const seq_ac = m7 & 7;
		const e2_sel = (m7>>4) & 7;
		const seq_branch_hi = ((m7<<2) & 0x200) | ((m7<<5) & 0x100);

		const FFC_DATA_IN = [
			'FS1','FS3','FS2','MCSR',
			'FDSR1','nop5','FDSR2','nop7',
			'AddrL','FFCRAM','SysReg','Status',
			'AddrH','nop13','nop14',''
		];
		const FFC_CARRY = ['0','1','SROut','SQOut','~F','F','ALU.C','ALU.S'];
		const FFC_FLAGI = ['1     ','Flag  ','SRO   ','SQO   ','ALU.C ','ALU.V ','ALU.S ','ALU.H '];
		const FFC_FLAGN = ['0     ','~Flag ','~SRO  ','~SQO  ','~ALU.C','~ALU.V','~ALU.S','~ALU.H']
		const FFC_SHIFT_IN = ['0','1','SROut','SQOut','~Flag','Flag','ALU.C','ALU.S'];
		const FFC_K1 = [
			'DCR1','DCR2','SSBCL','MCSR',
			'FDSRs','','SSBCH','TSM',
			'AddrL','FFCRAM','SysReg','AddrH',
			'CtrlReg','IPL','',''
		];
		const FFC_K1_SPL = [
			'','','','VerifyDat','','FDDPulse','','TSMReset',
			'','','','','','','nop14',''
		];
		const FFC_TESTI = ['Alway','Flag ','Zero ','Carry','Ovr  ','Neg  ','fiDNE','MFMEr'];
		const FFC_TESTN = ['Never','~Flag','NotZ ','NoCar','NoOvr','Pos  ','fiDOk','MFMOk'];
		let nextop;
		if(d1_sel == 0) {
			nextop = `AC:${(test_inv ? FN_8X02_A[seq_ac] : FN_8X02_N[seq_ac]).padEnd(12)} Branch=${hex(seq_branch_hi|data_out,3)}`;
		} else {
			nextop = `AC:${FN_8X02_C[seq_ac]} ${test_inv ? FFC_TESTI[d1_sel] : FFC_TESTN[d1_sel]} Branch=${hex(seq_branch_hi|data_out,3)}`;
		}
		const disp_data_in = k2_sel<13 ? `${FFC_DATA_IN[k2_sel]}(${hex(data_in)})` : (k2_sel == 15 ? `#${hex(data_in)}`:'');
		const disp_data_out = k1_sel<14 ? `${FFC_K1[k1_sel]}(${hex(data_out)})` : '';
		const seq = `${hex(this.seq.p,3)}:${hex(mcw2,4)}${hex(mcw1,4)}:${hex(mval)}:${hex(mcw0,6)} ${nextop}`;
		const alu = (
		ALU.trace_str(alu_s, alu_f, alu_d, alu_a, alu_b,
			FFC_SHIFT_IN[f2_sel], FFC_SHIFT_IN[f1_sel],
			data_bridge||disp_data_out.length==0?'_':disp_data_out, disp_data_in, FFC_CARRY[e2_sel]) + ` (${hex(this.aluc.y)})` +
			(data_bridge && disp_data_out.length > 0?`${disp_data_out} = ~${disp_data_in} `:'') // ~36ch max
		).padEnd(30) +
		` Flag=${flag_inv ? FFC_FLAGI[e1_sel] : FFC_FLAGN[e1_sel]}`;
		const bus = `${FFC_K1_SPL[k1_sel].padEnd(9)} [${addr_inc?'A+':'  '}${dma_inc?'D+':'  '}${tp_d?'TP':'  '} ${rds_sel?'fdd':'cry'} ${tsm_csel?'fic':'vco'} CRC${crc_out?'Out':'-- '}${crc_reset?'Rst':'-- '}${crc_ena?'EN':'DS'}]`;
		ffc_op_seq.innerText = seq;
		ffc_op_alu.innerText = alu;
		ffc_op_bus.innerText = bus;
		if(log) {
			txt_anno.value += `${seq} ${alu}\n${bus}\n`;
		}
		ffc_addr.innerText = hex(this.address, 3);
		//CTRL: 0000 | busy | status2 | DMARead | DMARun
		ffc_ctrl.innerText = `${this.busy ?'Busy':'Idle'} ${this.flag_2?'F2':'--'} ${this.dma_request?'DMA':'---'}:${this.dma_read?'R':'W'}`;
		ffc_ipl.innerText = hex(this.interrupt_priority, 1);
		ffc_sys.innerText = (this.flag_cputocard ? '>' : (this.flag_cardtocpu ? '<' : '=')) + hex(this.sys_data);
		/* dma_end | cpu->card | card->cpu */
		ffc_status.innerText = `${mcsim.dma_end?'END':'---'} ${this.flag_cputocard?'FIN':'---'} ${this.flag_cardtocpu?'FOUT':'----'}`;
		ffc_track.innerText = hex(this.unit_1.track,3);
		ffc_disk.innerText = `${hex(this.ssbc, 3)} ${hex(this.tsm)} ${hex(this.dcr2)} ${this.crc_reg==0?'Z':'N'} ${this.unit_1.start_of_disk?'I':'-'}${this.unit_1.start_of_sector!=0?'S':'-'}${hex(this.unit_1.sector_byte,3)}/${hex(this.unit_1.rotation>>3,4)}`;
		const malu1 = hex(this.aluc.regq, 2) +
		` ${(this.aluc.half_carry_out)!=0?'H':'-'}${(this.aluc.main_carry_out)!=0?'C':'-'}${(this.aluc.over)!=0?'V':'-'}${(this.aluc.sign)!=0?'S':'-'}${(this.aluc.zero)!=0?'Z':'-'} F=${this.flag_reg}`;
		let malu2 = '';
		let malu3 = '';
		for(let i=0;i<8;i++) {
			malu2 += hex(this.aluc.reg[i], 2) + ' ';
			malu3 += hex(this.aluc.reg[i+8], 2) + ' ';
		}
		ffc_alu.innerText = malu1;
		ffc_alu2.innerText = malu2;
		ffc_alu3.innerText = malu3;
	}
	reset():void {
		this.address = 0;
		this.interrupt_priority = 0;
		this.busy = false;
		this.flag_cardtocpu = false;
		this.flag_cputocard = false;
		this.dma_read = false;
		this.dma_active = false;
		this.seq.reset();
	}
	readbyte(address: number): number {
		if(address == 0) { // data
			this.flag_cardtocpu = false;
			return this.sys_data;
		} else { // status
			return (this.busy ? 8 : 0) | (this.flag_2 ? 4 : 0) |
			(this.flag_cputocard ? 2 : 0) | (this.flag_cardtocpu ? 1 : 0);
		}
	}
	writebyte(address: number, value: number): void {
		if(address == 0) { // data
			this.sys_data = value;
			this.flag_cputocard = true;
		} else { // reset
			this.reset();
		}
	}
}

const enum CMDERR {
	COMMAND_STRING_OVERFLOW = 0x11,
	INVALID_COMMAND = 0x12,
	COMMAND_SEQ_ERROR = 0x13,
	COMMAND_STRING_OVERRUN = 0x14,
	UNIT_SELECT_ERROR_1 = 0x16,
	KEY_LENGTH_ERROR = 0x22,
	DMA_LAG = 0x23,
	WRITE_FAULT = 0x24,
	BUFFER_ADDRESS_ERROR = 0x26,
	DATA_LENGTH_ERROR = 0x29,
	CYLINDER_ADDRESS_ERROR = 0x2a,
	SEEK_ERROR = 0x2b,
	HEAD_ADDRESS_ERROR = 0x2c,
	ADDRESS_CHECKWORD_ERROR = 0x2d,
	DATA_MARK_ERROR = 0x2f,
	UNIT_SELECT_ERROR_3 = 0x30,
	TIMEOUT_ERROR = 0x31,
	DATA_CRC_ERROR = 0x33,
	VERIFY_ERROR = 0x34,
	TRACK_END_WHILE_WRITING = 35,
	DRIVE_NOT_READY = 0x41,
	DISK_WRITE_PROTECTED = 0x42,
	LOAD_COMMAND_STRING_ERROR = 0x43,
	EXEC_COMMAND_STRING_ERROR = 0x45,
}
class TestCMD implements MemAccess, Run, DMADevice {
	readmeta(address: number):number { return MEMSTAT.IO; }
	writemeta(address: number, value: number): void {}
	dma_select(enable: boolean, dev: number): void {}
	data_in = 0;
	data_out = 0;
	data_fout = false;
	data_fin = false;
	state = 0;
	address = 0;
	dma_len = 0;
	dma_request: boolean = false;
	dma_mask = 0;
	dma_mode = 0;
	busy = false;
	cardram = new Uint8Array(0x1000);
	read_request:((v:number)=>void) | null = null;
	cancel_request:(()=>void) | null = null;
	dma_complete:(()=>void) | null = null;
	delay_request:(()=>void) | null = null;
	delay_count = 0;
	run(increment: number): void {
		if(this.delay_count < 200) {
			this.delay_count += increment;
		} else {
			this.delay_count = 0;
			if (this.delay_request != null) {
				this.delay_request();
			}
		}
		this.process();
	}
	async request8():Promise<number> {
		let v = await new Promise<number>((resolve, reject)=>{
			this.cancel_request = reject;
			this.read_request = resolve;
		});
		//console.log('CMD-RQ:', hex(v));
		this.cancel_request = null;
		return v;
	}
	async request16():Promise<number> {
		return ((await this.request8()) << 8) | (await this.request8());
	}
	// not to be confused with delay_request, this function just waits
	async request_delay():Promise<void> {
		return new Promise<void>((resolve)=>{
			this.delay_request = ()=>{
				this.delay_request = null;
				resolve();
			};
		});
	}
	dma_step(ctrl: DMAControl): void {
		if(mcsim.dma_end || this.dma_len <= 0) {
			ctrl.end();
			if(this.dma_complete) this.dma_complete();
			return;
		}
		if(this.dma_mode == 0) {
			this.cardram[this.address & 0xfff] = ctrl.read();
		} else {
			ctrl.write(this.cardram[this.address & 0xfff]);
		}
		this.address = (this.address + 1) & 0xfff;
		this.dma_len--;
	}
	async dma_in():Promise<void> {
		const last_cancel = this.cancel_request;
		return new Promise((resolve, reject)=>{
			this.cancel_request = ()=>{
				this.data_out = CMDERR.DMA_LAG;
				this.data_fout = true;
				this.dma_complete = null;
				this.cancel_request = last_cancel;
				this.dma_request = false;
				reject();
			};
			this.dma_complete = ()=>{
				this.dma_complete = null;
				this.cancel_request = last_cancel;
				resolve();
			};
			this.dma_request = true;
			this.dma_mode = 0;
			mcsim.dma_request();
		});
	}
	async dma_out():Promise<void> {
		return new Promise((resolve, reject)=>{
			this.cancel_request = ()=>{
				this.data_out = CMDERR.DMA_LAG;
				this.data_fout = true;
				this.dma_complete = null;
				this.cancel_request = null;
				this.dma_request = false;
				reject();
			};
			this.dma_complete = resolve;
			this.dma_request = true;
			this.dma_mode = 1;
			mcsim.dma_request();
		});
	}
	async io_command(index:number):Promise<number> {
		switch(index) {
		case 0: // CMD reset?
			await this.request_delay();
			console.log('CMD-RESET');
			return 0;
		case 0x43: // DMA to cmdbuf
			this.address = 0x11; // TODO: same as FFC?
			this.dma_len = 178;
			await this.dma_in();
			return 0;
		case 0x46: // CPU to card
			this.address = await this.request16();
			this.dma_len = await this.request16();
			if (this.address > 0xfff) return CMDERR.BUFFER_ADDRESS_ERROR;
			if (this.dma_len > 0xfff) return CMDERR.DATA_LENGTH_ERROR;
			await this.dma_in();
			return 0;
		case 0x47: // card to CPU
			this.address = await this.request16();
			this.dma_len = await this.request16();
			if (this.address > 0xfff) return CMDERR.BUFFER_ADDRESS_ERROR;
			if (this.dma_len > 0xfff) return CMDERR.DATA_LENGTH_ERROR;
			await this.dma_out();
			return 0;
		default:
			//console.log('CMD-C', hex(index));
		}
		return CMDERR.INVALID_COMMAND;
	}
	process() {
		if(this.data_fin) {
			const fin = this.data_in;
			this.data_fin = false;
			if (this.read_request != null) {
				let req = this.read_request;
				this.read_request = null;
				req.call(this, fin);
			} else if (!this.busy) {
				this.busy = true;
				this.io_command(fin).then((res)=>{
					this.data_out = res;
					this.data_fout = true;
				}).catch(()=>{
					console.log('CMD: io-cancel');
				}).finally(()=>{
					//console.log('CMD-done');
					this.busy = false;
				});
			} else {
				this.data_fin = true;
			}
		}
	}
	readbyte(address: number): number {
		let value = 0;
		if (address == 1) {
			if(this.data_fout) value |= 1;
			if(this.data_fin) value |= 2;
			if(this.busy) {
				//console.log('CMD-rdbusy');
				value |= 8;
			}
		} else {
			this.data_fout = false;
			value = this.data_out;
		}
		return value;
	}
	writebyte(address: number, value: number): void {
		if(address == 0) {
			this.data_in = value;
			//console.log('CMD:W:', hex(value), this.data_fin, this.read_request != null);
			this.data_fin = true;
			this.process();
		} else if (this.cancel_request != null) {
			this.cancel_request();
			this.cancel_request = null;
		}
	}
}
class MockTape9Tk implements MemAccess {
	readmeta(address: number):number { return MEMSTAT.IO; }
	writemeta(address: number, value: number): void {}
	data0 = 0;
	data_ctl = 0;
	reset() {
		this.data_ctl = 0;
		this.data0 = 0;
	}
	readbyte(address: number): number {
		switch(address) {
		case 0: return this.data0;
		case 1: return 0x2d;
		case 2: return 0xb3;
		default: console.log('Tape ?R<', address, 0);
		}
		return 0;
	}
	writebyte(address: number, value: number): void {
		switch(address) {
		case 0: this.data0 = value; console.log('Tape D', hex(value)); return;
		case 1: this.data_ctl = value; return;
		case 2: console.log(`Tape ${hex(this.data0)} ctl:${hex(this.data_ctl)}.${hex(value)}`);
		case 3: console.log('Tape ST', hex(value));
			return;
		default: console.log('Tape ?W>', address, hex(value));
		}
	}
}
class MMIOTrace implements MemAccess {
	readmeta(address: number):number { return MEMSTAT.IO; }
	writemeta(address: number, value: number): void {}
	v = new Uint8Array(20);
	readbyte(address: number): number {
		let value = this.v[address];
		console.log('IOTrace-R', address, value);
		return value;
	}
	writebyte(address: number, value: number): void {
		let c = ' ';
		if(value > 127) {
			c = String.fromCodePoint(value & 127);
		}
		console.log('IOTrace-W', address, value, c);
	}
}
class MMIOMulti implements MemAccess {
	readmeta(address: number):number {
		for (let i = 0;;i++) {
			const devlist = this.devices[i];
			if (devlist == null) return 0;
			if ((address >= devlist.address) && (address < devlist.end)) {
				return devlist.dev.readmeta(address - devlist.address);
			}
		}
	}
	writemeta(address: number, value: number): void {
		for (let i = 0;;i++) {
			const devlist = this.devices[i];
			if (devlist == null) return;
			if ((address >= devlist.address) && (address < devlist.end)) {
				devlist.dev.writemeta(address - devlist.address, value);
				return;
			}
		}
	}
	devices:{address:number,end:number,dev:MemAccess}[] = [];
	adddev(subaddr:number, size:number, dev:MemAccess) {
		this.devices.push({address:subaddr, end:subaddr+size, dev});
	}
	readbyte(address: number):number {
		for (let i = 0;;i++) {
			const devlist = this.devices[i];
			if (devlist == null) return 0;
			if ((address >= devlist.address) && (address < devlist.end)) {
				return devlist.dev.readbyte(address - devlist.address);
			}
		}
	}
	writebyte(address: number, value: number):void {
		for (let i = 0;;i++) {
			const devlist = this.devices[i];
			if (devlist == null) return;
			if ((address >= devlist.address) && (address < devlist.end)) {
				devlist.dev.writebyte(address - devlist.address, value);
				return;
			}
		}
	}
}
const RUN_INTERVAL = 50; // (1000ms / 20ms [tick interval]) * (10 bits/byte)
const MUX_BAUDS = [0, 75, 300, 1200, 2400, 4800, 9600, 19200];
const MUX_MASKS = [0x1f, 0x3f, 0x7f, 0xff];
class MUXPort implements CharDevice {
	emu_linked = true;
	write_busy = false;
	write_full = false;
	read_busy = false;
	read_full = false;
	read_buffer = 0;
	overrun = false;
	_rts = true;
	_cts = true;
	buf_write = 0;
	_bit_len = 0;
	_frame_cost = 0;
	_parity = 0;
	_baud_field = 0;
	_baud = 0;
	_tx_div = 0;
	card:MMIOMux;
	tx_flag:number;
	line:CharDevice | undefined;
	constructor(card:MMIOMux, id:number) {
		this.card = card;
		this.tx_flag = 1 << id;
		this.reset();
		mux_hw.push(this);
	}
	get rts() { return this._rts; }
	set_cts(value:boolean) {
		this._cts = value;
	}
	set_rts(value:boolean) {
		this._rts = value;
		if(this.line != null) {
			this.line.set_cts(value);
			this.line.check_send();
		}
	}
	reset():void {
		this.write_busy = false;
		this.read_busy = false;
		this.set_rts(true);
		this._bit_len = 5;
		this._parity = 1;
		this._frame_cost = 8 * RUN_INTERVAL;
		this._baud_field = 0;
		this._baud = 0;
		this.overrun = false;
	}
	read_status():number {
		return (this.write_busy ? 0 : 2) |
			(this.read_busy ? 1 : 0) |
			(this.overrun ? 16 : 0) |
			(this._cts ? 0x20 : 0);
	}
	get_dev(): CharDevice | undefined {
		return this.line;
	}
	bind_dev(dev: CharDevice | undefined): void {
		this.line = dev;
		if(dev) {
			this.set_cts(dev.rts);
		} else {
			this.set_cts(false);
		}
	}
	read_data():number {
		let vcc = this.read_buffer;
		this.read_buffer = 0;
		this.read_busy = false;
		this.overrun = false;
		if(this.line != null) this.line.check_send();
		return vcc;
	}
	run_tx(): void {
		if(this._tx_div < this._baud) {
			this._tx_div += this._baud;
		}
		if(this._tx_div > this._baud) {
			this._tx_div = this._baud;
		}
		this.check_send();
	}
	check_send(): void {
		if(this.write_busy && this._tx_div > 0) {
			this._tx_div -= this._frame_cost;
			this.write_busy = false;
			if(this.line) {
				this.line.receive(this.buf_write & MUX_MASKS[this._bit_len]);
				this.write_complete();
			} else this.write_complete();
		}
	}
	write_control(value:number):void {
		this._baud_field = (value >> 5) & 7;
		this._baud = MUX_BAUDS[this._baud_field];
		this._bit_len = (value >> 1) & 3;
		let stop = (value >> 3) & 1;
		let p_dis = (value >> 4) & 1;
		if(p_dis == 0) {
			this._parity = 2 | (value & 1);
			this._frame_cost = (3 + stop + 5 + this._bit_len) * RUN_INTERVAL;
		} else {
			this._parity = 0;
			this._frame_cost = (2 + stop + 5 + this._bit_len) * RUN_INTERVAL;
		}
	}
	write_complete():void {
		this.card.tx_int |= this.tx_flag;
		this.card.interrupt_pend = true;
		this.card.mux_cause = true;
	}
	write_data(value:number):void {
		this.write_busy = true;
		this.buf_write = value;
		this.check_send();
	}
	can_receive():boolean {
		return !this.read_busy;
	}
	receive(data:number):void {
		if(this.read_busy) this.overrun = true;
		this.read_buffer = data & MUX_MASKS[this._bit_len];
		this.read_busy = true;
		this.card.interrupt_pend = true;
		this.card.mux_cause = true;
	}
}
class MMIOMux implements MemAccess, IOAccess {
	readmeta(address: number):number { return MEMSTAT.IO; }
	writemeta(address: number, value: number): void {}
	is_interrupt():boolean {
		return this.interrupt_en && this.interrupt_pend;
	}
	getlevel():number {
		return this.interrupt_level;
	}
	acknowledge():boolean {
		//console.log('MUX:IACK');
		if (this.interrupt_pend) {
			this.interrupt_pend = false;
			return true;
		}
		return false;
	}
	reset():void {
		this.interrupt_en = false;
		this.interrupt_level = 0;
		this.interrupt_pend = false;
		this.mux_cause = false;
		this.muxports[0].reset();
		this.muxports[1].reset();
		this.muxports[2].reset();
		this.muxports[3].reset();
	}
	muxports:MUXPort[] = [
		new MUXPort(this, 0), new MUXPort(this, 1),
		new MUXPort(this, 2), new MUXPort(this, 3)
	];
	interrupt_level = 0;
	interrupt_en = false;
	interrupt_pend = false;
	mux_cause = false;
	tx_int = 0;
	readbyte(address:number):number {
		let v = 0;
		if (address < 8) {
			let selmux = this.muxports[address >> 1];
			if (selmux) {
				if ((address & 1) != 0) v = selmux.read_data();
				else v = selmux.read_status();
				if (this.tx_int > 0) {
					this.interrupt_pend = true;
					this.mux_cause = true;
				}
			}
		} else if (address == 15) {
			if (this.mux_cause) {
				this.mux_cause = false;
				if (this.muxports[0].read_busy) {
					v = 0; // (card_id << 4)
				} else if (this.muxports[1].read_busy) {
					v = 2; // (card_id << 4)
				} else if (this.muxports[2].read_busy) {
					v = 4; // (card_id << 4)
				} else if (this.muxports[3].read_busy) {
					v = 6; // (card_id << 4)
				} else if (this.tx_int > 0) {
					v = 0; // (card_id << 4)
					for(let i = 0; i < 4; i++) {
						let q = 1 << i;
						if ((this.tx_int & q) != 0) {
							v |= (i << 1) | 1;
							this.tx_int ^= q;
							break;
						}
					}
				}
			}
			//console.log('MUX:R:' + hex(address,1), hex(v));
		} else if (address < 16) {
			console.log('MUX:R:' + hex(address,1), hex(v));
		}
		return v;
	}
	writebyte(address:number, value:number):void {
		if (address < 8) {
			let port = address >> 1;
			let selmux = this.muxports[port];
			if (selmux) {
				if ((address & 1) != 0) {
					selmux.write_data(value);
				} else {
					selmux.write_control(value);
				}
			}
		} else if (address == 8) { // CTS control
			let onoff = value & 1;
			let port = (value >> 1) & 3;
			let selmux = this.muxports[port];
			if (selmux) {
				selmux.set_rts(onoff == 0);
			}
		} else if (address == 10) {
			this.interrupt_level = value & 0xf;
		} else if (address == 12) {
			this.tx_int |= (value & 0xf);
			this.interrupt_pend = true;
			this.mux_cause = true;
			//console.log('MUX:IFORCE');
		} else if (address == 13) {
			this.interrupt_en = false;
		} else if (address == 14) {
			this.interrupt_en = true;
		} else if (address == 15) {
			this.reset();
		} else if (address < 16) {
			console.log('MUX:W:' + hex(address), hex(value));
		}
		return;
	}
}
class NullROM implements MemAccess {
	readmeta(address: number):number { return MEMSTAT.IO; }
	writemeta(address: number, value: number): void {}
	writebyte(address: number, value: number): void {}
	readbyte(address: number): number {
		return 0;
	}
}

function loadbin(mem:MemAccess, v:Uint8Array, addrfn?:number|AddressTransform):MemAccess {
	const l = v.length;
	if (addrfn === undefined || typeof addrfn == 'number') {
		let a = 0;
		if(addrfn !== undefined) a = addrfn;
		for (; a < l; a++) {
			mem.writemeta(a, v[a]);
		}
	} else {
		let xm = addrfn.invert ? (l - 1) : 0;
		const remap = addrfn.remap;
		if (remap) {
			const aremapfn = function(addr_in:number):number {
				let atx = 0;
				for (let i = 0; i < remap.length; i++) {
					atx |= ((addr_in >>> remap[i]) & 1) << i;
				}
				return atx;
			};
			for (let a = 0; a < l; a++) {
				let txa = aremapfn(a ^ xm);
				mem.writemeta(a, v[txa]);
			}
		} else {
			for (let a = 0; a < l; a++) {
				let txa = a ^ xm;
				mem.writemeta(a, v[txa]);
			}
		}
	}
	return mem;
}
// load a space/lf delimited list of hex values
function loadhex(mem:MemAccess, h:string, ofs:number = 0):void {
	let msh = h.split(/[ \n]/);
	let vpc = ofs;
	msh.forEach(value=>{
		if (value !== '') {
			let v = parseInt(value, 16);
			mem.writemeta(vpc, v & 0xff);
			vpc++;
		}
	});
}
class SysMem implements MemAccess {
	memory = new Uint8Array(0x20000);
	pram = new Uint8Array(0x20000);
	readmeta(address: number): number {
		return this.memory[address] | (this.pram[address] << 8);
	}
	writemeta(address: number, value: number):void {
		this.memory[address] = value & 255;
		const vhi = (value >> 8) & 254;
		value = value & 255;
		let pval = value ^ (value >> 4);
		pval = pval ^ (pval >> 2);
		pval = (pval ^ (pval >> 1)) & 1;
		this.pram[address] = vhi | pval;
	}
	readbyte(address:number):number {
		const value = this.memory[address];
		let pval = value ^ (value >> 4);
		pval = pval ^ (pval >> 2);
		pval = (pval ^ (pval >> 1)) & 1;
		const mval = this.pram[address];
		mcsim.memfault = pval ^ (mval & 1);
		if((mval & 112) != 0) handle_break();
		return value & 255;
	}
	writebyte(address: number, value: number): void {
		value = value & 255;
		let pval = value ^ (value >> 4);
		pval = pval ^ (pval >> 2);
		pval = (pval ^ (pval >> 1) ^ mcsim.parity) & 1;
		this.pram[address] = (this.pram[address] & 254) | pval;
		this.memory[address] = value;
	}
}
class ROM512 implements MemAccess {
	contents = new Uint16Array(512);
	readmeta(address: number): number {
		return this.contents[address];
	}
	writemeta(address: number, value: number): void {
		this.contents[address] = value;
	}
	readbyte(address:number):number {
		let mval = this.contents[address];
		if((mval & 28672) != 0) handle_break();
		return mval & 255;
	}
	writebyte(address: number, value: number):void {}
}
class ROM2k implements MemAccess {
	contents = new Uint16Array(2048);
	readmeta(address: number): number {
		return this.contents[address];
	}
	writemeta(address: number, value: number): void {
		this.contents[address] = value;
	}
	readbyte(address:number):number {
		let mval = this.contents[address];
		if((mval & 28672) != 0) handle_break();
		return mval & 255;
	}
	writebyte(address: number, value: number):void {}
}
class RAM2k implements MemAccess {
	contents = new Uint8Array(2048);
	readmeta(address: number): number {
		return this.contents[address];
	}
	writemeta(address: number, value: number): void {
		this.contents[address] = value & 255;
	}
	readbyte(address:number):number {
		return this.contents[address];
	}
	writebyte(address: number, value: number):void {
		this.contents[address] = value & 255;
	}
}

const enum OPM {
	IMPL,
	IMM, DIR, IND, PCO, IPO, MOD,
	RR, RRX, RRSR, RRS, RC,
	IMPL_R,
	IMPL_R_DIR,
}
const enum TXS {
	B, W, F
}
const enum OPL_EXT {
	MPUSH, MPOP,
	PAGE, DMA, BIG, MEM,
	RII, XIO,
}
interface OPL_EXT_MPUSH { x:OPL_EXT.MPUSH }
interface OPL_EXT_MPOP { x:OPL_EXT.MPOP }
interface OPL_EXT_PAGE {
	x:OPL_EXT.PAGE,
	xd:[string[],string[],string[]]
}
interface OPL_EXT_DMA {
	x:OPL_EXT.DMA,
	xd:[string[],string[],string[]]
}
interface OPL_EXT_BIG {
	x:OPL_EXT.BIG,
	xd:[string[],string[]]
}
interface OPL_EXT_MEM {
	x:OPL_EXT.MEM,
	xd:[number[],string[],string[]]
}
interface OPL_EXT_RII {
	x:OPL_EXT.RII,
}
interface OPL_EXT_XIO {
	x:OPL_EXT.XIO,
}
const enum AOP {
	ADD=0, SUB=1, XFR=2,
	AND=3, ORI=4, XOR=5,
	NOT=6, CLR=7,
}
interface OPLBase {
	n:string|(string[]),
	nm?:string|(string[]),
	l?:number,
	i?:number,
	ms?:OPM,
	md:OPM,
	w?:TXS,
	sr?:REG,
	dr?:REG,
	fl:FLAGS,
	aop?:AOP,
	opf?:(this:SoftCPU, ctx:rrscdata)=>number,
	opc?:(this:SoftCPU, ctx:rrscdata)=>void,
}
type OPLEntry = OPLBase & ( { x?:never } |
	OPL_EXT_MEM | OPL_EXT_PAGE | OPL_EXT_DMA | OPL_EXT_BIG
	| OPL_EXT_MPUSH | OPL_EXT_MPOP | OPL_EXT_RII | OPL_EXT_XIO
);
interface rrscdata {
	reg:ILevelRegisters;
	srcreg:number;
	dstreg:number;
	srcval:number;
	cdval:number;
	addr:number;
	fault:number;
	link:number;
	is_addr:boolean;
}
interface SoftCPU {
	cc:number;
	pc:number;
	write(address:number, v8:number):void;
	writew(address:number, v16:number):void;
	stackb(v8:number):void;
	stackw(v16:number):void;
	get_rw(n:number):number;
	set_rw(n:number, v16:number):void;
	get_rb(n:number):number;
	set_rb(n:number, v8:number):void;
	popb():number;
	popw():number;
	fetch(address:number):number;
	fetchw(address:number):number;
	pcfetch():number;
	pcfetchw():number;
	f_jsr(ea:number):void;
	f_branch(cm:number, cn:string, z:boolean):void;
	handle_svc(sc:number):void;
	flags_8vm(v:number):number;
	flags_8vmfl(v:number, fault:number, link:number):number;
	flags_a8vml(lh:number, rh:number, cin?:number):number;
	flags_a8vmfl(lh:number, rh:number, cin:number):number;
	flags_a8vmf(lh:number, rh:number, cin?:number):number;
	flags_a16vmfl(lh:number, rh:number, cin?:number):number;
	flags_a16vmf(lh:number, rh:number, cin:number):number;
	flags_16vm(v:number):number;
	flags_16vmfl(v:number, fault:number, link:number):number;
}

const enum FLAGS {
	None,
	F, L,
	MV, FLMV, ArithFMV, ArithFLMV
}
const enum REG {
	A, AL, B, BL, X, XL, Y, YL,
	Z, ZL, S, SL, C, CL, P, PL, PC, PCL
}
const regname = [[
	['AU','AL','BU','BL','XU','XL','YU','YL',
	'ZU','ZL','SU','SL','CU','CL','PU','PL'],
	['A','AL','B','BL','X','XL','Y','YL',
	'Z','ZL','S','SL','C','CL','P','PL','PC','PCL'],
],[
	['AH','AL','BH','BL','XH','XL','YH','YL',
	'ZH','ZL','SH','SL','CH','CL','PH','PL'],
	['A','A!','B','B!','X','X!','Y','Y!',
	'Z','Z!','S','S!','C','C!','P','P!','PC','PC!'],
]];
const mmwlist = new Map<number, string>([]);

const mmiolist = new Map([
	[0x00fe,'cpu_reg_ph15'],
	[0xf106,'diag_unblank'],
	[0xf107,'diag_blankhex'],
	[0xf108,'dp1_set'],[0xf109,'dp1_clear'],
	[0xf10a,'dp2_set'],[0xf10b,'dp2_clear'],
	[0xf10c,'dp3_set'],[0xf10d,'dp3_clear'],
	[0xf10e,'dp4_set'],[0xf10f,'dp4_clear'],
	[0xf110,'diag_dip_hex'],
	[0xf201,'mux0_rx_tx'],[0xf200,'mux0_stat_ctl'],
	[0xf203,'mux1_rx_tx'],[0xf202,'mux1_stat_ctl'],
	[0xf205,'mux2_rx_tx'],[0xf204,'mux2_stat_ctl'],
	[0xf207,'mux3_rx_tx'],[0xf206,'mux3_stat_ctl'],
	[0xf208,'mux_mmio_08'],[0xf209,'mux_mmio_09'],[0xf20a,'mux_mmio_0a'],[0xf20b,'mux_mmio_0b'],
	[0xf20c,'mux_mmio_0c'],[0xf20d,'mux_mmio_0d'],[0xf20e,'mux_mmio_0e'],[0xf20f,'mux_mmio_0f'],
]);

if(true) {
	for(let i = 0; i < 256; i++) {
		if ((i & 1) == 0) {
			mmwlist.set(i, `cpu_reg_${regname[0][1][i & 15].toLowerCase()}${i >> 4}`);
		}
		mmiolist.set(i, `cpu_reg_${regname[0][0][i & 15].toLowerCase()}${i >> 4}`);
	}
}

const oplist:OPLEntry[] = [
	// 0x0H
	{n:['HLT','HALT'],md:OPM.IMPL,fl:FLAGS.None,opc:function(){throw 0;}},
	{n:'NOP',md:OPM.IMPL,opc:function(){},fl:FLAGS.None},
	{n:'SF',md:OPM.IMPL,fl:FLAGS.F, opc:function(){ this.cc |= CC_F; }},
	{n:'RF',md:OPM.IMPL,fl:FLAGS.F, opc:function(){ this.cc &= CC_NF; }},
	{n:'EI',md:OPM.IMPL,fl:FLAGS.None},
	{n:'DI',md:OPM.IMPL,fl:FLAGS.None},
	{n:'SL',md:OPM.IMPL,fl:FLAGS.L, opc:function(){ this.cc |= CC_L; }},
	{n:'RL',md:OPM.IMPL,fl:FLAGS.L, opc:function(){ this.cc &= CC_NL; }},
	{n:['CL','COML'],md:OPM.IMPL,fl:FLAGS.L, opc:function(){ this.cc ^= CC_L; }}, // 8
	{n:['RSR','RET'],md:OPM.IMPL,fl:FLAGS.None,
		opc:function(ctx) {
			this.pc = ctx.reg.x;
			this.set_rw(REG.X, this.popw()); }},
	{n:['RI','RETI'],md:OPM.IMPL,fl:FLAGS.FLMV},
	{n:'!ill0B',md:OPM.IMPL,fl:FLAGS.None},
	{n:['SYN','SYNC'],md:OPM.IMPL,fl:FLAGS.None,opc:function(){console.log('SYN');}},
	{n:['PCX','MOV'],ms:OPM.IMPL_R,md:OPM.IMPL_R,w:TXS.W,sr:REG.PC,dr:REG.X,fl:FLAGS.None},
	{n:['DLY','DELAY'],md:OPM.IMPL,fl:FLAGS.None,opc:function(){}},
	{n:['RSV','SVRET'],md:OPM.IMPL,fl:FLAGS.None},
	// 0x1H
	{n:'BL',md:OPM.PCO,w:TXS.F,fl:FLAGS.None,opc:function(){this.f_branch(CC_L,'BL ',false);}},
	{n:'BNL',md:OPM.PCO,w:TXS.F,fl:FLAGS.None,opc:function(){this.f_branch(CC_L,'BNL',true);}},
	{n:'BF',md:OPM.PCO,w:TXS.F,fl:FLAGS.None,opc:function(){this.f_branch(CC_F,'BF ',false);}},
	{n:'BNF',md:OPM.PCO,w:TXS.F,fl:FLAGS.None,opc:function(){this.f_branch(CC_F,'BNF',true);}},
	{n:'BZ',md:OPM.PCO,w:TXS.F,fl:FLAGS.None,opc:function(){this.f_branch(CC_V,'BZ ',false);}},
	{n:'BNZ',md:OPM.PCO,w:TXS.F,fl:FLAGS.None,opc:function(){this.f_branch(CC_V,'BNZ',true);}},
	{n:'BM',md:OPM.PCO,w:TXS.F,fl:FLAGS.None,opc:function(){this.f_branch(CC_M,'BM ',false);}},
	{n:'BP',md:OPM.PCO,w:TXS.F,fl:FLAGS.None,opc:function(){this.f_branch(CC_M,'BP ',true);}},
	{n:'BGZ',md:OPM.PCO,w:TXS.F,fl:FLAGS.None,opc:function(){this.f_branch(CC_M|CC_V,'BGZ',true);}},
	{n:'BLE',md:OPM.PCO,w:TXS.F,fl:FLAGS.None,opc:function(){this.f_branch(CC_M|CC_V,'BLE',false);}},
	{n:'BS1',md:OPM.PCO,w:TXS.F,fl:FLAGS.None},
	{n:'BS2',md:OPM.PCO,w:TXS.F,fl:FLAGS.None},
	{n:'BS3',md:OPM.PCO,w:TXS.F,fl:FLAGS.None},
	{n:'BS4',md:OPM.PCO,w:TXS.F,fl:FLAGS.None},
	{n:'BI',md:OPM.PCO,w:TXS.F,fl:FLAGS.None},
	{n:'BCK',md:OPM.PCO,w:TXS.F,fl:FLAGS.None},
	// 0x2H
	{n:['INRB','INC'],md:OPM.RC,w:TXS.B,i:1,aop:AOP.ADD,fl:FLAGS.ArithFMV},
	{n:['DCRB','DEC'],md:OPM.RC,w:TXS.B,i:1,aop:AOP.SUB,fl:FLAGS.ArithFMV},
	{n:'CLRB',md:OPM.RC,w:TXS.B,i:0,aop:AOP.CLR,fl:FLAGS.FLMV},
	{n:['IVRB','NOT'],md:OPM.RC,w:TXS.B,aop:AOP.NOT,fl:FLAGS.MV},
	{n:['SRRB','SHR'],md:OPM.RC,w:TXS.B,i:1,fl:FLAGS.FLMV,
		opf:function(ctx) { ctx.fault = 0;
			ctx.link = (ctx.srcval >> (8 - ctx.cdval)) & 1;
			return ctx.srcval << ctx.cdval; }},
	{n:['SLRB','SHL'],md:OPM.RC,w:TXS.B,i:1,fl:FLAGS.FLMV,
		opf:function(ctx) {
			const s = ctx.srcval;
			const mshift = (ctx.cdval>7)? 7 : ctx.cdval;
			const mask = (-1 << (7-mshift)) & 0x7f;
			const si = (s > 0x7f) ? 0xff : 0;
			ctx.fault = (((si ^ s) & mask) != 0)? 1:0;
			ctx.link = (s >> (8 - ctx.cdval)) & 1;
			return s << ctx.cdval; }},
	{n:['RRRB','RORC'],md:OPM.RC,w:TXS.B,i:1,fl:FLAGS.FLMV},
	{n:['RLRB','ROLC'],md:OPM.RC,w:TXS.B,i:1,fl:FLAGS.FLMV},
	{n:['INAB','INC'],md:OPM.IMPL_R,w:TXS.B,dr:REG.AL,i:1,aop:AOP.ADD,fl:FLAGS.ArithFMV},
	{n:['DCAB','DEC'],md:OPM.IMPL_R,w:TXS.B,dr:REG.AL,i:1,aop:AOP.SUB,fl:FLAGS.ArithFMV},
	{n:['CLAB','CLR'],md:OPM.IMPL_R,w:TXS.B,dr:REG.AL,i:0,aop:AOP.CLR,fl:FLAGS.FLMV},
	{n:['IVAB','NOT'],md:OPM.IMPL_R,w:TXS.B,dr:REG.AL,aop:AOP.NOT,fl:FLAGS.MV},
	{n:['SRAB','SHR'],md:OPM.IMPL_R,w:TXS.B,dr:REG.AL,fl:FLAGS.FLMV,
		opf:function(ctx) { ctx.fault = 0; ctx.link = ctx.srcval & 1;
			return (ctx.srcval >> 1) | (ctx.srcval & 128); }},
	{n:['SLAB','SHL'],md:OPM.IMPL_R,w:TXS.B,dr:REG.AL,fl:FLAGS.FLMV,
		opf:function(ctx) { ctx.link = ctx.srcval >> 7;
			ctx.fault = (ctx.link ^ (ctx.srcval >> 6)) & 1;
			return ctx.srcval << 1; }},
	{n:['','page.'],md:OPM.IMPL,fl:FLAGS.None,x:OPL_EXT.PAGE,xd:[ // 2E
		['c','c','i','i','i','i'],
		["LDM","STM","LSM","SSM","FLM","MFM"],
		["WrPM","RdPM","Wr1PM","Rd1PM","FillPM","FFromPM"]
	]},
	{n:['DMA ','dma.',''],md:OPM.IMPL,fl:FLAGS.None,x:OPL_EXT.DMA,xd:[ // 2F
		['SAD','RAD','SCT','RCT','SDV','RDV','EAB','DAB','SMN','RMN'],
		['LD.A','ST.A','LD.C','ST.C','LD.M','LD.M','EN'  ,'DIS' ,'LD.S','ST.S'],
		['LDDMAA','STDMAA','LDDMAC','STDMAC','SETDMAM','SETDMAMR','EDMA','DDMA','LDISR','STISR'],
	]},
	// 0x3H
	{n:['INR','INC'],nm:'INC',md:OPM.RC,w:TXS.W,i:1,aop:AOP.ADD,fl:FLAGS.ArithFMV},
	{n:['DCR','DEC'],nm:'DEC',md:OPM.RC,w:TXS.W,i:1,aop:AOP.SUB,fl:FLAGS.ArithFMV},
	{n:'CLR',nm:'CAD',md:OPM.RC,w:TXS.W,aop:AOP.CLR,fl:FLAGS.FLMV},
	{n:['IVR','NOT'],nm:['IAD','NOT'],md:OPM.RC,w:TXS.W,aop:AOP.NOT,fl:FLAGS.MV},
	{n:['SRR','SHR'],nm:'SHR',md:OPM.RC,w:TXS.W,i:1,fl:FLAGS.FLMV,
		opf:function(ctx) { ctx.fault = 0;
			ctx.link = (ctx.srcval >> (16 - ctx.cdval)) & 1;
			return ctx.srcval << ctx.cdval; }},
	{n:['SLR','SHL'],nm:'SHL',md:OPM.RC,w:TXS.W,i:1,fl:FLAGS.FLMV,
		opf:function(ctx) {
			const s = ctx.srcval;
			const mshift = (ctx.cdval>15)? 15 : ctx.cdval;
			const mask = (-1 << (15-mshift)) & 0x7fff;
			const si = (s > 0x7fff) ? 0xffff : 0;
			ctx.fault = (((si ^ s) & mask) != 0)? 1:0;
			ctx.link = (s >> (16 - ctx.cdval)) & 1;
			return s << ctx.cdval; }},
	{n:['RRR','RORC'],nm:['RTR','RORC'],md:OPM.RC,w:TXS.W,i:1,fl:FLAGS.FLMV},
	{n:['RLR','ROLC'],nm:['RTL','ROLC'],md:OPM.RC,w:TXS.W,i:1,fl:FLAGS.FLMV},
	{n:['INA','INC'],md:OPM.IMPL_R,w:TXS.W,dr:REG.A,i:1,aop:AOP.ADD,fl:FLAGS.ArithFMV},
	{n:['DCA','DEC'],md:OPM.IMPL_R,w:TXS.W,dr:REG.A,i:1,aop:AOP.SUB,fl:FLAGS.ArithFMV},
	{n:['CLA','CLR'],md:OPM.IMPL_R,w:TXS.W,dr:REG.A,i:0,aop:AOP.CLR,fl:FLAGS.FLMV},
	{n:['IVA','NOT'],md:OPM.IMPL_R,w:TXS.W,dr:REG.A,aop:AOP.NOT,fl:FLAGS.MV},
	{n:['SRA','SHR'],md:OPM.IMPL_R,w:TXS.W,dr:REG.A,fl:FLAGS.FLMV,
		opf:function(ctx) { ctx.fault = 0; ctx.link = ctx.srcval & 1;
			return (ctx.srcval >> 1) | (ctx.srcval & 0x8000); }},
	{n:['SLA','SHL'],md:OPM.IMPL_R,w:TXS.W,dr:REG.A,fl:FLAGS.FLMV,
		opf:function(ctx) { ctx.link = ctx.srcval >> 15;
			ctx.fault = (ctx.link ^ (ctx.srcval >> 14)) & 1;
			return ctx.srcval << 1; }},
	{n:['INX','INC'],md:OPM.IMPL_R,w:TXS.W,dr:REG.X,i:1,aop:AOP.ADD,fl:FLAGS.ArithFMV},
	{n:['DCX','DEC'],md:OPM.IMPL_R,w:TXS.W,dr:REG.X,i:1,aop:AOP.SUB,fl:FLAGS.ArithFMV},
	// 0x4H
	{n:'ADDB',md:OPM.RR,w:TXS.B,aop:AOP.ADD,fl:FLAGS.ArithFLMV},
	{n:'SUBB',md:OPM.RR,w:TXS.B,aop:AOP.SUB,fl:FLAGS.ArithFLMV},
	{n:'ANDB',md:OPM.RR,w:TXS.B,aop:AOP.AND,fl:FLAGS.MV},
	{n:['ORIB','OR'],md:OPM.RR,w:TXS.B,aop:AOP.ORI,fl:FLAGS.MV},
	{n:['OREB','XOR'],md:OPM.RR,w:TXS.B,aop:AOP.XOR,fl:FLAGS.MV},
	{n:['XFRB','XFR'],md:OPM.RR,w:TXS.B,fl:FLAGS.MV,aop:AOP.XFR},
	{n:['','BIG.'],md:OPM.IMPL,fl:FLAGS.FLMV,x:OPL_EXT.BIG,xd:[ // 46
		['A','S','C','ZAD','ZSU','M','D','DRM','CTB','CFB'],
		['ADD','SUB','CMP','MOV','NEG','SMUL','DIV','DIVMOD','TOBIN','FMBIN'],
	]},
	{n:['','MEM.'],md:OPM.IMPL,fl:FLAGS.FLMV,x:OPL_EXT.MEM,xd:[ // 47
		[0,1,3,2,6,6,6,6,6,6],
		['CVX','CPV','MVV','SCN','MVF','ANC','ORC','XRC','CPF','FIL'],//1
		['XREC','CMPC','MOVEC','SCANC','MOVEF','ANDC','ORC','XORC','CMPF','FILL'],//2
	]},
	{n:['AABB','ADD'],ms:OPM.IMPL_R,md:OPM.IMPL_R,w:TXS.B,sr:REG.AL,dr:REG.BL,aop:AOP.ADD,fl:FLAGS.ArithFLMV},
	{n:['SABB','SUB'],ms:OPM.IMPL_R,md:OPM.IMPL_R,w:TXS.B,sr:REG.AL,dr:REG.BL,aop:AOP.SUB,fl:FLAGS.ArithFLMV},
	{n:['NABB','AND'],ms:OPM.IMPL_R,md:OPM.IMPL_R,w:TXS.B,sr:REG.AL,dr:REG.BL,aop:AOP.AND,fl:FLAGS.MV},
	{n:['XAXB','XFR'],ms:OPM.IMPL_R,md:OPM.IMPL_R,w:TXS.B,sr:REG.AL,dr:REG.XL,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['XAYB','XFR'],ms:OPM.IMPL_R,md:OPM.IMPL_R,w:TXS.B,sr:REG.AL,dr:REG.YL,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['XABB','XFR'],ms:OPM.IMPL_R,md:OPM.IMPL_R,w:TXS.B,sr:REG.AL,dr:REG.BL,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['XAZB','XFR'],ms:OPM.IMPL_R,md:OPM.IMPL_R,w:TXS.B,sr:REG.AL,dr:REG.ZL,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['XASB','XFR'],ms:OPM.IMPL_R,md:OPM.IMPL_R,w:TXS.B,sr:REG.AL,dr:REG.SL,aop:AOP.XFR,fl:FLAGS.MV},
	// 0x5H
	{n:'ADD',md:OPM.RR,w:TXS.W,aop:AOP.ADD,fl:FLAGS.ArithFLMV},
	{n:'SUB',md:OPM.RR,w:TXS.W,aop:AOP.SUB,fl:FLAGS.ArithFLMV},
	{n:'AND',md:OPM.RR,w:TXS.W,aop:AOP.AND,fl:FLAGS.MV},
	{n:['ORI','OR'],md:OPM.RR,w:TXS.W,aop:AOP.ORI,fl:FLAGS.MV},
	{n:['ORE','XOR'],md:OPM.RR,w:TXS.W,aop:AOP.XOR,fl:FLAGS.MV},
	{n:'XFR',md:OPM.RRS,w:TXS.W,aop:AOP.XFR,fl:FLAGS.MV}, // 55
	{n:'EAO',md:OPM.IMPL,fl:FLAGS.None}, // 56
	{n:'DAO',md:OPM.IMPL,fl:FLAGS.None}, // 57
	{n:['AAB','ADD'],ms:OPM.IMPL_R,md:OPM.IMPL_R,w:TXS.W,sr:REG.A,dr:REG.B,aop:AOP.ADD,fl:FLAGS.ArithFLMV},
	{n:['SAB','SUB'],ms:OPM.IMPL_R,md:OPM.IMPL_R,w:TXS.W,sr:REG.A,dr:REG.B,aop:AOP.SUB,fl:FLAGS.ArithFLMV},
	{n:['NAB','AND'],ms:OPM.IMPL_R,md:OPM.IMPL_R,w:TXS.W,sr:REG.A,dr:REG.B,aop:AOP.AND,fl:FLAGS.MV},
	{n:['XAX','XFR'],ms:OPM.IMPL_R,md:OPM.IMPL_R,w:TXS.W,sr:REG.A,dr:REG.X,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['XAY','XFR'],ms:OPM.IMPL_R,md:OPM.IMPL_R,w:TXS.W,sr:REG.A,dr:REG.Y,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['XAB','XFR'],ms:OPM.IMPL_R,md:OPM.IMPL_R,w:TXS.W,sr:REG.A,dr:REG.B,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['XAZ','XFR'],ms:OPM.IMPL_R,md:OPM.IMPL_R,w:TXS.W,sr:REG.A,dr:REG.Z,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['XAS','XFR'],ms:OPM.IMPL_R,md:OPM.IMPL_R,w:TXS.W,sr:REG.A,dr:REG.S,aop:AOP.XFR,fl:FLAGS.MV},
	// 0x6H
	{n:['LDX','LD'],ms:OPM.IMM,w:TXS.W,md:OPM.IMPL_R,dr:REG.X,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['LDX','LD'],ms:OPM.DIR,w:TXS.W,md:OPM.IMPL_R,dr:REG.X,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['LDX','LD'],ms:OPM.IND,w:TXS.W,md:OPM.IMPL_R,dr:REG.X,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['LDX','LD'],ms:OPM.PCO,w:TXS.W,md:OPM.IMPL_R,dr:REG.X,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['LDX','LD'],ms:OPM.IPO,w:TXS.W,md:OPM.IMPL_R,dr:REG.X,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['LDX','LD'],ms:OPM.MOD,w:TXS.W,md:OPM.IMPL_R,dr:REG.X,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['SVC','SVCALL'],ms:OPM.IMM,w:TXS.B,fl:FLAGS.None,md:OPM.IMPL,
		opc:function(ctx) { this.handle_svc(ctx.srcval); }},
	{n:['','MEM.'],md:OPM.IMPL,fl:FLAGS.FLMV,x:OPL_EXT.MEM,sr:REG.A,xd:[ // 67
		[0,1,3,2,6,6,6,6,6,6],
		['CVXR','CPVR','MVVR','SCNR','MVFR','ANCR','ORCR','XRCR','CPFR','FILR'],//1
		['XREC','CMPC','MOVEC','SCANC','MOVEF','ANDC','ORC','XORC','CMPF','FILL'],//2
	]},
	{n:['STX','ST'],md:OPM.IMM,ms:OPM.IMPL_R,w:TXS.W,sr:REG.X,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['STX','ST'],md:OPM.DIR,ms:OPM.IMPL_R,w:TXS.W,sr:REG.X,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['STX','ST'],md:OPM.IND,ms:OPM.IMPL_R,w:TXS.W,sr:REG.X,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['STX','ST'],md:OPM.PCO,ms:OPM.IMPL_R,w:TXS.W,sr:REG.X,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['STX','ST'],md:OPM.IPO,ms:OPM.IMPL_R,w:TXS.W,sr:REG.X,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['STX','ST'],md:OPM.MOD,ms:OPM.IMPL_R,w:TXS.W,sr:REG.X,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['LST','LDST'],md:OPM.DIR,w:TXS.B,fl:FLAGS.ArithFLMV}, // 6E
	{n:['SST','STST'],md:OPM.IMPL,ms:OPM.DIR,w:TXS.B,fl:FLAGS.ArithFLMV}, // 6F
	// 0x7H
	{n:'!ill70',md:OPM.IMM,w:TXS.F,fl:FLAGS.None},//0
	{n:'JMP',md:OPM.DIR,w:TXS.F,fl:FLAGS.None, opc:function(ctx){ this.pc = ctx.addr; }},
	{n:'JMP',md:OPM.IND,w:TXS.F,fl:FLAGS.None, opc:function(ctx){ this.pc = ctx.addr; }},
	{n:'JMP',md:OPM.PCO,w:TXS.F,fl:FLAGS.None, opc:function(ctx){ this.pc = ctx.addr; }},
	{n:'JMP',md:OPM.IPO,w:TXS.F,fl:FLAGS.None, opc:function(ctx){ this.pc = ctx.addr; }},
	{n:'JMP',md:OPM.MOD,w:TXS.F,fl:FLAGS.None, opc:function(ctx){ this.pc = ctx.addr; }},
	{n:['EPE','EN.PEF'],md:OPM.IMPL,fl:FLAGS.None}, //6
	{n:'MUL',md:OPM.RRX,w:TXS.W,fl:FLAGS.ArithFLMV}, //7
	{n:'DIV',md:OPM.RRX,w:TXS.W,fl:FLAGS.ArithFLMV}, //8
	{n:['JSR','CALL'],md:OPM.DIR,w:TXS.F,fl:FLAGS.None, opc:function(ctx){ this.f_jsr(ctx.addr); }},//9
	{n:['JSR','CALL'],md:OPM.IND,w:TXS.F,fl:FLAGS.None, opc:function(ctx){ this.f_jsr(ctx.addr); }},//A
	{n:['JSR','CALL'],md:OPM.PCO,w:TXS.F,fl:FLAGS.None, opc:function(ctx){ this.f_jsr(ctx.addr); }},//B
	{n:['JSR','CALL'],md:OPM.IPO,w:TXS.F,fl:FLAGS.None, opc:function(ctx){ this.f_jsr(ctx.addr); }},//C
	{n:['JSR','CALL'],md:OPM.MOD,w:TXS.F,fl:FLAGS.None, opc:function(ctx){ this.f_jsr(ctx.addr); }},//D
	{n:['STK','MPUSH'],md:OPM.RC,w:TXS.F,i:1,x:OPL_EXT.MPUSH,fl:FLAGS.None, opc:function(ctx) {
		let s = this.get_rw(REG.S);
		ctx.srcreg += ctx.cdval;
		while(ctx.cdval > 0) {
			s--;
			ctx.srcreg--;
			ctx.cdval--;
			this.write(s, this.get_rb(ctx.srcreg & 15));
		}
		this.set_rw(REG.S, s & 65535);
	}},
	{n:['POP','MPOP'],md:OPM.RC,w:TXS.F,i:1,x:OPL_EXT.MPOP,fl:FLAGS.None, opc:function(ctx) {
		let s = this.get_rw(REG.S);
		while(ctx.cdval > 0) {
			this.set_rb(ctx.srcreg, this.fetch(s));
			s++;
			ctx.srcreg = (ctx.srcreg + 1) & 15;
			ctx.cdval--;
		}
		this.set_rw(REG.S, s & 65535);
	}},
	// 0x8H
	{n:['LDAB','LD'],ms:OPM.IMM,md:OPM.IMPL_R,w:TXS.B,dr:REG.AL,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['LDAB','LD'],ms:OPM.DIR,md:OPM.IMPL_R,w:TXS.B,dr:REG.AL,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['LDAB','LD'],ms:OPM.IND,md:OPM.IMPL_R,w:TXS.B,dr:REG.AL,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['LDAB','LD'],ms:OPM.PCO,md:OPM.IMPL_R,w:TXS.B,dr:REG.AL,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['LDAB','LD'],ms:OPM.IPO,md:OPM.IMPL_R,w:TXS.B,dr:REG.AL,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['LDAB','LD'],ms:OPM.MOD,md:OPM.IMPL_R,w:TXS.B,dr:REG.AL,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['DPE','DIS.PEF'],md:OPM.IMPL,fl:FLAGS.None}, // 86
	{n:'!ill87',md:OPM.IMPL,fl:FLAGS.None},
	{n:['LDAB+ A','LD'],ms:OPM.IMPL_R_DIR,md:OPM.IMPL_R,w:TXS.B,sr:REG.A,dr:REG.AL,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['LDAB+ B','LD'],ms:OPM.IMPL_R_DIR,md:OPM.IMPL_R,w:TXS.B,sr:REG.B,dr:REG.AL,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['LDAB+ X','LD'],ms:OPM.IMPL_R_DIR,md:OPM.IMPL_R,w:TXS.B,sr:REG.X,dr:REG.AL,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['LDAB+ Y','LD'],ms:OPM.IMPL_R_DIR,md:OPM.IMPL_R,w:TXS.B,sr:REG.Y,dr:REG.AL,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['LDAB+ Z','LD'],ms:OPM.IMPL_R_DIR,md:OPM.IMPL_R,w:TXS.B,sr:REG.Z,dr:REG.AL,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['LDAB+ S','LD'],ms:OPM.IMPL_R_DIR,md:OPM.IMPL_R,w:TXS.B,sr:REG.S,dr:REG.AL,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['LDAB+ C','LD'],ms:OPM.IMPL_R_DIR,md:OPM.IMPL_R,w:TXS.B,sr:REG.C,dr:REG.AL,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['LDAB+ P','LD'],ms:OPM.IMPL_R_DIR,md:OPM.IMPL_R,w:TXS.B,sr:REG.P,dr:REG.AL,aop:AOP.XFR,fl:FLAGS.MV},
	// 0x9H
	{n:['LDA','LD'],ms:OPM.IMM,md:OPM.IMPL_R,w:TXS.W,dr:REG.A,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['LDA','LD'],ms:OPM.DIR,md:OPM.IMPL_R,w:TXS.W,dr:REG.A,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['LDA','LD'],ms:OPM.IND,md:OPM.IMPL_R,w:TXS.W,dr:REG.A,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['LDA','LD'],ms:OPM.PCO,md:OPM.IMPL_R,w:TXS.W,dr:REG.A,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['LDA','LD'],ms:OPM.IPO,md:OPM.IMPL_R,w:TXS.W,dr:REG.A,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['LDA','LD'],ms:OPM.MOD,md:OPM.IMPL_R,w:TXS.W,dr:REG.A,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['SOP','SET.PO'],md:OPM.IMPL,fl:FLAGS.None},
	{n:'!ill97',md:OPM.IMPL,fl:FLAGS.None},
	{n:['LDA+ A','LD'],ms:OPM.IMPL_R_DIR,md:OPM.IMPL_R,w:TXS.W,sr:REG.A,dr:REG.A,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['LDA+ B','LD'],ms:OPM.IMPL_R_DIR,md:OPM.IMPL_R,w:TXS.W,sr:REG.B,dr:REG.A,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['LDA+ X','LD'],ms:OPM.IMPL_R_DIR,md:OPM.IMPL_R,w:TXS.W,sr:REG.X,dr:REG.A,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['LDA+ Y','LD'],ms:OPM.IMPL_R_DIR,md:OPM.IMPL_R,w:TXS.W,sr:REG.Y,dr:REG.A,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['LDA+ Z','LD'],ms:OPM.IMPL_R_DIR,md:OPM.IMPL_R,w:TXS.W,sr:REG.Z,dr:REG.A,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['LDA+ S','LD'],ms:OPM.IMPL_R_DIR,md:OPM.IMPL_R,w:TXS.W,sr:REG.S,dr:REG.A,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['LDA+ C','LD'],ms:OPM.IMPL_R_DIR,md:OPM.IMPL_R,w:TXS.W,sr:REG.C,dr:REG.A,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['LDA+ P','LD'],ms:OPM.IMPL_R_DIR,md:OPM.IMPL_R,w:TXS.W,sr:REG.P,dr:REG.A,aop:AOP.XFR,fl:FLAGS.MV},
	// 0xAH
	{n:['STAB','ST'],ms:OPM.IMPL_R,md:OPM.IMM,w:TXS.B,sr:REG.AL,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['STAB','ST'],ms:OPM.IMPL_R,md:OPM.DIR,w:TXS.B,sr:REG.AL,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['STAB','ST'],ms:OPM.IMPL_R,md:OPM.IND,w:TXS.B,sr:REG.AL,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['STAB','ST'],ms:OPM.IMPL_R,md:OPM.PCO,w:TXS.B,sr:REG.AL,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['STAB','ST'],ms:OPM.IMPL_R,md:OPM.IPO,w:TXS.B,sr:REG.AL,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['STAB','ST'],ms:OPM.IMPL_R,md:OPM.MOD,w:TXS.B,sr:REG.AL,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['SEP','SET.PE'],md:OPM.IMPL,fl:FLAGS.None}, // A6
	{n:'!illA7',md:OPM.IMPL,fl:FLAGS.None},
	{n:['STAB+ A','ST'],ms:OPM.IMPL_R,md:OPM.IMPL_R_DIR,w:TXS.B,sr:REG.AL,dr:REG.A,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['STAB+ B','ST'],ms:OPM.IMPL_R,md:OPM.IMPL_R_DIR,w:TXS.B,sr:REG.AL,dr:REG.B,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['STAB+ X','ST'],ms:OPM.IMPL_R,md:OPM.IMPL_R_DIR,w:TXS.B,sr:REG.AL,dr:REG.X,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['STAB+ Y','ST'],ms:OPM.IMPL_R,md:OPM.IMPL_R_DIR,w:TXS.B,sr:REG.AL,dr:REG.Y,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['STAB+ Z','ST'],ms:OPM.IMPL_R,md:OPM.IMPL_R_DIR,w:TXS.B,sr:REG.AL,dr:REG.Z,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['STAB+ S','ST'],ms:OPM.IMPL_R,md:OPM.IMPL_R_DIR,w:TXS.B,sr:REG.AL,dr:REG.S,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['STAB+ C','ST'],ms:OPM.IMPL_R,md:OPM.IMPL_R_DIR,w:TXS.B,sr:REG.AL,dr:REG.C,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['STAB+ P','ST'],ms:OPM.IMPL_R,md:OPM.IMPL_R_DIR,w:TXS.B,sr:REG.AL,dr:REG.P,aop:AOP.XFR,fl:FLAGS.MV},
	// 0xBH
	{n:['STA','ST'],ms:OPM.IMPL_R,md:OPM.IMM,w:TXS.W,sr:REG.A,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['STA','ST'],ms:OPM.IMPL_R,md:OPM.DIR,w:TXS.W,sr:REG.A,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['STA','ST'],ms:OPM.IMPL_R,md:OPM.IND,w:TXS.W,sr:REG.A,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['STA','ST'],ms:OPM.IMPL_R,md:OPM.PCO,w:TXS.W,sr:REG.A,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['STA','ST'],ms:OPM.IMPL_R,md:OPM.IPO,w:TXS.W,sr:REG.A,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['STA','ST'],ms:OPM.IMPL_R,md:OPM.MOD,w:TXS.W,sr:REG.A,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['ECK','EN.CLK'],md:OPM.IMPL,fl:FLAGS.None}, // B6
	{n:'!illB7',md:OPM.IMPL,fl:FLAGS.None},
	{n:['STA+ A','ST'],ms:OPM.IMPL_R,md:OPM.IMPL_R_DIR,w:TXS.W,sr:REG.A,dr:REG.A,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['STA+ B','ST'],ms:OPM.IMPL_R,md:OPM.IMPL_R_DIR,w:TXS.W,sr:REG.A,dr:REG.B,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['STA+ X','ST'],ms:OPM.IMPL_R,md:OPM.IMPL_R_DIR,w:TXS.W,sr:REG.A,dr:REG.X,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['STA+ Y','ST'],ms:OPM.IMPL_R,md:OPM.IMPL_R_DIR,w:TXS.W,sr:REG.A,dr:REG.Y,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['STA+ Z','ST'],ms:OPM.IMPL_R,md:OPM.IMPL_R_DIR,w:TXS.W,sr:REG.A,dr:REG.Z,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['STA+ S','ST'],ms:OPM.IMPL_R,md:OPM.IMPL_R_DIR,w:TXS.W,sr:REG.A,dr:REG.S,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['STA+ C','ST'],ms:OPM.IMPL_R,md:OPM.IMPL_R_DIR,w:TXS.W,sr:REG.A,dr:REG.C,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['STA+ P','ST'],ms:OPM.IMPL_R,md:OPM.IMPL_R_DIR,w:TXS.W,sr:REG.A,dr:REG.P,aop:AOP.XFR,fl:FLAGS.MV},
	// 0xCH
	{n:['LDBB','LD'],ms:OPM.IMM,md:OPM.IMPL_R,w:TXS.B,dr:REG.BL,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['LDBB','LD'],ms:OPM.DIR,md:OPM.IMPL_R,w:TXS.B,dr:REG.BL,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['LDBB','LD'],ms:OPM.IND,md:OPM.IMPL_R,w:TXS.B,dr:REG.BL,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['LDBB','LD'],ms:OPM.PCO,md:OPM.IMPL_R,w:TXS.B,dr:REG.BL,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['LDBB','LD'],ms:OPM.IPO,md:OPM.IMPL_R,w:TXS.B,dr:REG.BL,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['LDBB','LD'],ms:OPM.MOD,md:OPM.IMPL_R,w:TXS.B,dr:REG.BL,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['DCK','DIS.CLK'],md:OPM.IMPL,fl:FLAGS.None}, // C6
	{n:'!illC7',md:OPM.IMPL,fl:FLAGS.None},
	{n:['LDBB+ A','LD'],ms:OPM.IMPL_R_DIR,md:OPM.IMPL_R,w:TXS.B,sr:REG.A,dr:REG.BL,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['LDBB+ B','LD'],ms:OPM.IMPL_R_DIR,md:OPM.IMPL_R,w:TXS.B,sr:REG.B,dr:REG.BL,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['LDBB+ X','LD'],ms:OPM.IMPL_R_DIR,md:OPM.IMPL_R,w:TXS.B,sr:REG.X,dr:REG.BL,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['LDBB+ Y','LD'],ms:OPM.IMPL_R_DIR,md:OPM.IMPL_R,w:TXS.B,sr:REG.Y,dr:REG.BL,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['LDBB+ Z','LD'],ms:OPM.IMPL_R_DIR,md:OPM.IMPL_R,w:TXS.B,sr:REG.Z,dr:REG.BL,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['LDBB+ S','LD'],ms:OPM.IMPL_R_DIR,md:OPM.IMPL_R,w:TXS.B,sr:REG.S,dr:REG.BL,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['LDBB+ C','LD'],ms:OPM.IMPL_R_DIR,md:OPM.IMPL_R,w:TXS.B,sr:REG.C,dr:REG.BL,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['LDBB+ P','LD'],ms:OPM.IMPL_R_DIR,md:OPM.IMPL_R,w:TXS.B,sr:REG.P,dr:REG.BL,aop:AOP.XFR,fl:FLAGS.MV},
	// 0xDH
	{n:['LDB','LD'],ms:OPM.IMM,md:OPM.IMPL_R,w:TXS.W,dr:REG.B,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['LDB','LD'],ms:OPM.DIR,md:OPM.IMPL_R,w:TXS.W,dr:REG.B,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['LDB','LD'],ms:OPM.IND,md:OPM.IMPL_R,w:TXS.W,dr:REG.B,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['LDB','LD'],ms:OPM.PCO,md:OPM.IMPL_R,w:TXS.W,dr:REG.B,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['LDB','LD'],ms:OPM.IPO,md:OPM.IMPL_R,w:TXS.W,dr:REG.B,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['LDB','LD'],ms:OPM.MOD,md:OPM.IMPL_R,w:TXS.W,dr:REG.B,aop:AOP.XFR,fl:FLAGS.MV},
	{n:'STR',w:TXS.W,md:OPM.RRSR,aop:AOP.XFR,fl:FLAGS.MV}, // D6
	{n:'SAR',ms:OPM.IMPL_R,sr:REG.A,w:TXS.W,md:OPM.IMPL,x:OPL_EXT.RII,fl:FLAGS.ArithFLMV}, // D7
	{n:['LDB+ A','LD'],ms:OPM.IMPL_R_DIR,md:OPM.IMPL_R,w:TXS.W,sr:REG.A,dr:REG.B,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['LDB+ B','LD'],ms:OPM.IMPL_R_DIR,md:OPM.IMPL_R,w:TXS.W,sr:REG.B,dr:REG.B,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['LDB+ X','LD'],ms:OPM.IMPL_R_DIR,md:OPM.IMPL_R,w:TXS.W,sr:REG.X,dr:REG.B,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['LDB+ Y','LD'],ms:OPM.IMPL_R_DIR,md:OPM.IMPL_R,w:TXS.W,sr:REG.Y,dr:REG.B,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['LDB+ Z','LD'],ms:OPM.IMPL_R_DIR,md:OPM.IMPL_R,w:TXS.W,sr:REG.Z,dr:REG.B,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['LDB+ S','LD'],ms:OPM.IMPL_R_DIR,md:OPM.IMPL_R,w:TXS.W,sr:REG.S,dr:REG.B,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['LDB+ C','LD'],ms:OPM.IMPL_R_DIR,md:OPM.IMPL_R,w:TXS.W,sr:REG.C,dr:REG.B,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['LDB+ P','LD'],ms:OPM.IMPL_R_DIR,md:OPM.IMPL_R,w:TXS.W,sr:REG.P,dr:REG.B,aop:AOP.XFR,fl:FLAGS.MV},
	// 0xEH
	{n:['STBB','ST'],ms:OPM.IMPL_R,md:OPM.IMM,w:TXS.B,sr:REG.BL,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['STBB','ST'],ms:OPM.IMPL_R,md:OPM.DIR,w:TXS.B,sr:REG.BL,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['STBB','ST'],ms:OPM.IMPL_R,md:OPM.IND,w:TXS.B,sr:REG.BL,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['STBB','ST'],ms:OPM.IMPL_R,md:OPM.PCO,w:TXS.B,sr:REG.BL,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['STBB','ST'],ms:OPM.IMPL_R,md:OPM.IPO,w:TXS.B,sr:REG.BL,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['STBB','ST'],ms:OPM.IMPL_R,md:OPM.MOD,w:TXS.B,sr:REG.BL,aop:AOP.XFR,fl:FLAGS.MV},
	{n:'LAR',w:TXS.W,md:OPM.IMPL_R,dr:REG.A,i:1,x:OPL_EXT.RII,fl:FLAGS.ArithFLMV}, // E6
	{n:'!illE7',md:OPM.IMPL,fl:FLAGS.None},
	{n:['STBB+ A','ST'],ms:OPM.IMPL_R,md:OPM.IMPL_R_DIR,w:TXS.B,sr:REG.BL,dr:REG.A,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['STBB+ B','ST'],ms:OPM.IMPL_R,md:OPM.IMPL_R_DIR,w:TXS.B,sr:REG.BL,dr:REG.B,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['STBB+ X','ST'],ms:OPM.IMPL_R,md:OPM.IMPL_R_DIR,w:TXS.B,sr:REG.BL,dr:REG.X,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['STBB+ Y','ST'],ms:OPM.IMPL_R,md:OPM.IMPL_R_DIR,w:TXS.B,sr:REG.BL,dr:REG.Y,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['STBB+ Z','ST'],ms:OPM.IMPL_R,md:OPM.IMPL_R_DIR,w:TXS.B,sr:REG.BL,dr:REG.Z,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['STBB+ S','ST'],ms:OPM.IMPL_R,md:OPM.IMPL_R_DIR,w:TXS.B,sr:REG.BL,dr:REG.S,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['STBB+ C','ST'],ms:OPM.IMPL_R,md:OPM.IMPL_R_DIR,w:TXS.B,sr:REG.BL,dr:REG.C,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['STBB+ P','ST'],ms:OPM.IMPL_R,md:OPM.IMPL_R_DIR,w:TXS.B,sr:REG.BL,dr:REG.P,aop:AOP.XFR,fl:FLAGS.MV},
	// 0xFH
	{n:['STB','ST'],ms:OPM.IMPL_R,md:OPM.IMM,w:TXS.W,sr:REG.B,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['STB','ST'],ms:OPM.IMPL_R,md:OPM.DIR,w:TXS.W,sr:REG.B,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['STB','ST'],ms:OPM.IMPL_R,md:OPM.IND,w:TXS.W,sr:REG.B,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['STB','ST'],ms:OPM.IMPL_R,md:OPM.PCO,w:TXS.W,sr:REG.B,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['STB','ST'],ms:OPM.IMPL_R,md:OPM.IPO,w:TXS.W,sr:REG.B,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['STB','ST'],ms:OPM.IMPL_R,md:OPM.MOD,w:TXS.W,sr:REG.B,aop:AOP.XFR,fl:FLAGS.MV},
	{n:'LIO',md:OPM.IMPL,x:OPL_EXT.XIO,fl:FLAGS.None}, // F6 LIO/SIO
	{n:['MVL','MOVML'],md:OPM.IMPL,w:TXS.W,sr:REG.B,dr:REG.Y,fl:FLAGS.None}, // F7
	{n:['STB+ A','ST'],ms:OPM.IMPL_R,md:OPM.IMPL_R_DIR,w:TXS.W,sr:REG.B,dr:REG.A,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['STB+ B','ST'],ms:OPM.IMPL_R,md:OPM.IMPL_R_DIR,w:TXS.W,sr:REG.B,dr:REG.B,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['STB+ X','ST'],ms:OPM.IMPL_R,md:OPM.IMPL_R_DIR,w:TXS.W,sr:REG.B,dr:REG.X,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['STB+ Y','ST'],ms:OPM.IMPL_R,md:OPM.IMPL_R_DIR,w:TXS.W,sr:REG.B,dr:REG.Y,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['STB+ Z','ST'],ms:OPM.IMPL_R,md:OPM.IMPL_R_DIR,w:TXS.W,sr:REG.B,dr:REG.Z,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['STB+ S','ST'],ms:OPM.IMPL_R,md:OPM.IMPL_R_DIR,w:TXS.W,sr:REG.B,dr:REG.S,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['STB+ C','ST'],ms:OPM.IMPL_R,md:OPM.IMPL_R_DIR,w:TXS.W,sr:REG.B,dr:REG.C,aop:AOP.XFR,fl:FLAGS.MV},
	{n:['STB+ P','ST'],ms:OPM.IMPL_R,md:OPM.IMPL_R_DIR,w:TXS.W,sr:REG.B,dr:REG.P,aop:AOP.XFR,fl:FLAGS.MV},
];

interface AnnotationLine {
	address:number;
	comm?:string[];
	pre?:string[];
	label?:string[];
	data?:string;
}
const annotation_data = new Map<number, AnnotationLine>();

function annotation_import(src:string) {
	const lines = src.replace("\r", "").split(/\n/);
	const scan = {
		ws: /^[ \t\r\n]+/,
		num: /^0x[0-9a-fA-F]+/,
		punct: /^[,:]+/,
		comm: /^;.*$/,
		word: /^[A-Za-z_$@][A-Za-z0-9_$@]*/,
		ign: /^[>][A-Za-z0-9_$@]*/,
	}
	const defer = new Set<string>([
		'comment','pre','plate','plate_comment','pre_comment',
		'label','code'
	]);
	annotation_data.clear();
	let anno_lines = [];
	let prev_line:AnnotationLine | null = null;
	for (let line of lines) {
		let parse:AnnotationLine = {address:-1};
		let offset = 0;
		let cmd_state:string | null = null;
		while (offset < line.length) {
			let fragment = line.substring(offset);
			let res:RegExpExecArray | null;
			let test = function(v:RegExp):RegExpExecArray | null {
				let ires = v.exec(fragment);
				if (ires != null && ires.length > 0 && ires[0].length > 0) {
					offset += ires[0].length;
					return ires;
				} else {
					return null;
				}
			}
			if (test(scan.ws)) {
			} else if (test(scan.punct)) {
			} else if (res = test(scan.num)) {
				parse.address = parseInt(res[0]);
			} else if (res = test(scan.comm)) {
				if (cmd_state != null && (
					cmd_state == 'pre_comment' ||
					cmd_state == 'pre' ||
					cmd_state == 'plate' ||
					cmd_state == 'plate_comment' ||
					cmd_state == 'pre_comment'))
				{
					if (parse.address == -1 && prev_line != null) {
						if (prev_line.pre == undefined) {
							prev_line.pre = [res[0]];
						} else {
							prev_line.pre.push(res[0]);
						}
					} else {
						parse.pre = [res[0]];
					}
				} else {
					if (parse.address == -1 && prev_line != null) {
						if (prev_line.comm == undefined){
							prev_line.comm = [res[0]];
						} else {
							prev_line.comm.push(res[0]);
						}
					} else {
						parse.comm = [res[0]];
					}
				}
			} else if (res = test(scan.word)) {
				let cmd = res[0].toLowerCase();
				if (cmd_state != null) {
					if (cmd_state == 'label' || cmd_state == 'code') {
						parse.label = [res[0]];
					} else if (cmd_state == 'comment') {
						parse.comm = [res[0]];
					} else if (
						cmd_state == 'pre_comment' ||
						cmd_state == 'pre' ||
						cmd_state == 'plate' ||
						cmd_state == 'plate_comment' ||
						cmd_state == 'pre_comment') {
						parse.pre = [res[0]];
					} else {
					}
					cmd_state = null;
				} else if (defer.has(cmd)) {
					cmd_state = cmd;
				} else if (cmd == 'pstring16') {
					parse.data = 'pstringhi ';
				} else {
					console.warn('unhandled:', cmd);
				}
			} else if (res = test(scan.ign)) {
				if (res[0] == '>H') {
					parse.data = 'word';
				} else if (res[0] == '>B') {
					parse.data = 'byte';
				}
			} else {
				console.warn('input invalid');
			}
		}
		if (parse.address != -1) {
			anno_lines.push(parse);
			prev_line = parse;
			let last = annotation_data.get(parse.address);
			if (last == undefined) {
				annotation_data.set(parse.address, parse);
			} else {
				if(parse.pre != null) {
					if (last.pre != null) last.pre.push(...parse.pre);
					else last.pre = parse.pre;
				}
				if(parse.comm != null) {
					if (last.comm != null) last.comm.push(...parse.comm);
					else last.comm = parse.comm;
				}
				if (parse.label != null) {
					if (last.label != null) last.label.push(...parse.label);
					else last.label = parse.label;
				}
				if (parse.data != null) {
					if (last.data != null) console.error('redefinition of data');
					else last.data = parse.data;
				}
			}
		}
	}
}

interface DisAsmResult {
	hb:string,
	asc:string,
	ins:string,
	par:string,
	l:number,
	pa:number,
	pg:number,
	ic:string|null,
	pre:string,
	post:string,
	is_brk:boolean,
}

const LIT_PFX = [
	{ir:'=',iw:'=',sr:'',sw:''},
	{ir:'#',iw:'>#',sr:'#',sw:'>#'},
	{ir:'=',iw:'=',sr:'',sw:''}
];
enum OPS_UNIT_NAMES {
	SYSRDR = 0x80,
	SYSIPT = 0x81,
	SYSLOG = 0x82,
	SYSLST = 0x83,
}

interface LTrace {
	op: string;
	wh:number;
	param?: string;
	aref?:number;
	tk?:boolean;
}
type LNTrace = LTrace | number;
interface RCB {
	rcb:number,
	unit:string,
	f:string, rbbln:number, rbbuf:number,
}
interface RCBExt extends RCB {
	lsr:number, dev_class:number, file_type:number,
	max_rec_size: number,
	rec_address: number,
	rec_size: number,
}
type RCBT = (RCB & {ext:false}) | (RCBExt & {ext:true});

function ccr_str(cc:number):string {
	return `${(cc & CC_V)!=0?'V':'-'
		}${(cc & CC_M)!=0?'M':'-'}${(cc & CC_F)!=0?'F':'-'
		}${(cc & CC_L)!=0?'L':'-'}`;
}
const enum ARITH_OP {
	SET = 0,
	ADD = 1,
	SUB = 2,
}
const editors:{
	editor1?:monaco.editor.IStandaloneCodeEditor,
	output1?:monaco.editor.IStandaloneCodeEditor,
	out_m?:monaco.editor.ITextModel,
	edit1?:monaco.editor.ITextModel,
} = {};
function softlog(text:string) {
	const model = editors.out_m;
	if(!model) return;
	let line = model.getLineCount();
	let col = model.getLineLength(line)+1;
	model.applyEdits([
		{
			range: {
				startLineNumber: line,
				startColumn: col,
				endLineNumber: line,
				endColumn: col,
			},
			text: text.replace('\r','\\r')+'\n'
		}
	]);
	editors.output1?.revealLineInCenter(line);
}

let um_enable_sync = false;
class UMCPU6 implements SoftCPU {
	mem: SysMem;
	reg: Uint8Array;
	reg_snap: Uint8Array;
	page: Uint8Array;
	regview: DataView;
	tib: Uint8Array;
	tibview: DataView;
	registers;
	_pc = 0;
	cc = 0;
	reason_v = '';
	reason_m = '';
	level = 0;
	_snap = {pc:0,cc:0,level:0};
	rref:rrscdata;
	trace = new Tracer();
	src_buffer:string[] = [];
	src_pointer = 0;
	constructor() {
		this.mem = new SysMem();
		this.reg = new Uint8Array(256);
		this.reg_snap = new Uint8Array(256);
		this.page = new Uint8Array(256);
		this.tib = new Uint8Array([
1, //00 task running flag (1=true)
1, //01 task identifier
0, //02 task priority counter
0, //03 task priority value
0,0, //04w addr of lub table for this task
0, //06 1st programmer logical unit number
0, //07 max logical unit number for this task
0,0, //08w addr of console pub for this task
0x80,0x00, //0Aw low memory address
0x30,0x00, //0Cw high memory address
0,0, //0Ew last prog segment high address
0,0, //10w 's' reg save area
0, //12 job control flag
0, //13 abort flag
0, //14 completion code
0, //15 utility program switches
0, //16 max ncmber of job parameters
0,0, //17w address of job parameters
0,0, //19w utility word 0 (first word of cpl program)
0, //1b run disc number
0,0, //1Cw run lib (dir) disc addr
0,0,0,0,0,0,0,0,0,0, //1E(10-char) run file name
0, //28 console unit number
0,0,0,0,0,0,0,0, //29(8) storage for sub-totals in cpl math statements
0, //31 default disk 'd'
255,255, //32w time lock (-1=disabled)
0,0, //34w job time for lock (0=tib time lock)
//36(33) tib memory map
0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0, 0,
0,0, //57w default form
0, //59 time of last wait
0,0, //5Aw save seg 1 x reg
0,0, //5Cw save prgm x reg
0, //5E default disk 't' temporary
0, //5F default disk 'l' library
0, //60 default disk 'w' work
		]);
		this.tibview = new DataView(this.tib.buffer);
		this.regview = new DataView(this.reg.buffer);
		this.registers = [
			LevelRegisters(0, this.reg), LevelRegisters(1, this.reg),
			LevelRegisters(2, this.reg), LevelRegisters(3, this.reg),
			LevelRegisters(4, this.reg), LevelRegisters(5, this.reg),
			LevelRegisters(6, this.reg), LevelRegisters(7, this.reg),
			LevelRegisters(8, this.reg), LevelRegisters(9, this.reg),
			LevelRegisters(10, this.reg), LevelRegisters(11, this.reg),
			LevelRegisters(12, this.reg), LevelRegisters(13, this.reg),
			LevelRegisters(14, this.reg), LevelRegisters(15, this.reg),
		];
		this.rref = {
			reg: this.registers[0],
			srcreg:0, dstreg:0, cdval:0, srcval:0, addr:0,
			fault:0, link:0, is_addr:false,
		};
		this.reset();
	}
	reset() {
		for(let r = 0; r < 32; r++) {
			this.page[r] = r;
		}
		this.src_pointer = 0;
	}
	loadxrec(xrec:Uint8Array, base:number) {
		let ofs = 0;
		let sofs = 0;
		let load_seg = base & 0xf800;
		this.tibview.setUint16(10, load_seg);
		load_seg |= 0x7ff;
		this.tibview.setUint16(12, load_seg);
		while(sofs < xrec.length) {
			ofs = sofs;
			while((ofs - sofs) < 400) {
				let rec_type = xrec[ofs];
				if(rec_type == 0x80) {
					break;
				}
				let rec_length = xrec[ofs + 1];
				let rec_baseh = xrec[ofs + 2];
				let rec_base = xrec[ofs + 3];
				let rec_sum = rec_base + rec_baseh + rec_length + rec_type;
				rec_base |= rec_baseh << 8;
				ofs += 4;
				//let cs = '';
				let load_base = (rec_base + base) & 65535;
				if(rec_type == 1) {
					if((rec_length & 1) != 0) throw new Error('bad fixup');
					for(let r = 0; r < rec_length; r+=2) {
						let ch = xrec[ofs];
						let cl = xrec[ofs+1];
						rec_sum += ch + cl;
						cl |= ch << 8;
						cl = (cl + base) & 65535;
						//cs += hex(cl) + ' ';
						
						let fu = this.fetchw(cl);
						fu = (fu + load_base) & 65535;
						this.m_writew(cl, fu);
						ofs += 2;
					}
				} else if(rec_type == 0 && rec_length == 0) {
					//console.log('ENTRY:', hex(load_base));
					this.pc = load_base;
					this.snap();
					return load_base;
				} else {
					while(load_base + rec_length > load_seg) {
						load_seg += 0x800;
						this.tibview.setUint16(12, load_seg);
					}
					for(let r = 0; r < rec_length; r++) {
						let cc = xrec[ofs];
						rec_sum += cc;
						this.m_write(load_base, cc);
						load_base += 1;
						ofs += 1;
					}
				}
				rec_sum += xrec[ofs];
				ofs += 1;
				//console.log(`${rec_type} ${hex(rec_sum & 255)} ${hex(rec_base + base,4)} len:${hex(rec_length)} ${cs}`);
			}
			sofs += 400;
		}
		return base;
	}
	showreg() {
		const levelreg = this.registers[this.level];
		const cc = this.cc;
		return `A:${hex(levelreg.a,4)} B:${hex(levelreg.b,4)
		} X:${hex(levelreg.x,4)} Y:${hex(levelreg.y,4)
		} Z:${hex(levelreg.z,4)} S:${hex(levelreg.s,4)
		} C:${hex(levelreg.c,4)} P:${hex(levelreg.p,4)
		} PC:${hex(this.pc,4)} CC:${(cc & CC_V)!=0?'V':'-'
		}${(cc & CC_M)!=0?'M':'-'}${(cc & CC_F)!=0?'F':'-'
		}${(cc & CC_L)!=0?'L':'-'}`;
	}
	get levelreg() {
		return this.registers[this.level];
	}
	get pc() { return this._pc; }
	set pc(v:number) { this._pc = v & 65535; }
	get_rw(n:number):number {
		return this.regview.getUint16((n & 14) | this.registers[this.level].base);
	}
	set_rw(n:number, v16:number):void {
		softlog(`${this.level}/${regname[0][1][n & 14]}=${hex(v16,4)}`);
		this.regview.setUint16((n & 14) | this.registers[this.level].base, v16);
	}
	get_rb(n:number):number {
		return this.regview.getUint8((n & 15) | this.registers[this.level].base);
	}
	set_rb(n:number, v8:number):void {
		softlog(`${this.level}/${regname[0][0][n & 15]}=${hex(v8,2)}`);
		this.regview.setUint8((n & 15) | this.registers[this.level].base, v8);
	}
	mk_reasonb(lh:number, rh:number, opr:ARITH_OP) {
		let ls:string;
		let rs:string;
		if(lh >= 0xa0 && lh < 0xff) {
			ls = `[${String.fromCharCode(lh & 127)}]`;
		} else ls = hex(lh,1);
		if(rh >= 0xa0 && rh < 0xff) {
			rs = `[${String.fromCharCode(rh & 127)}]`;
		} else rs = hex(rh,1);
		if(opr == ARITH_OP.SUB) {
			this.reason_v = `${ls}=${rs}`;
			this.reason_m = `${ls}<${rs}`;
		} else if(opr == ARITH_OP.ADD) {
			this.reason_v = `${ls}+${rs}=0`;
			this.reason_m = `${ls}+${rs}<0`;
		} else if(rh == 0) {
			this.reason_v = `${ls}=0`;
			this.reason_m = `${ls}<0`;
		} else {
			this.reason_v = `${ls},${rs}=0`;
			this.reason_m = `${ls},${rs}<0`;
		}
	}
	mk_reasonw(lh:number, rh:number, opr:ARITH_OP) {
		let ls:string; let rs:string;
		let c1 = lh & 0xff00;
		let c2 = lh & 255;
		if(c1 >= 0xa000 && c1 < 0xff00 && c2 >= 0xa0 && c2 < 0xff) {
			ls = `'${String.fromCharCode((lh >> 8) & 127)}${String.fromCharCode(lh & 127)}'`;
		} else ls = hex(lh,4);
		c1 = rh & 0xff00;
		c2 = rh & 255;
		if(c1 >= 0xa000 && c1 < 0xff00 && c2 >= 0xa0 && c2 < 0xff) {
			rs = `'${String.fromCharCode((rh >> 8) & 127)}${String.fromCharCode(rh & 127)}'`;
		} else rs = hex(rh,4);
		if(opr == ARITH_OP.SUB) {
			this.reason_v = `${ls}=${rs}`;
		} else if(opr == ARITH_OP.ADD) {
			this.reason_v = `${ls}+${rs}=0`;
		} else if(rh == 0) {
			this.reason_v = `${ls}=0`;
		} else {
			this.reason_v = `${ls},${rs}=0`;
		}
	}
	flags_8vm(v:number):number {
		v &= 255;
		this.mk_reasonb(v, 0, ARITH_OP.SET);
		this.cc = (this.cc & 0x3F) | (v == 0 ? CC_V : 0) |
		(v > 127 ? CC_M : 0);
		return v;
	}
	flags_8vmfl(v:number, fault:number, link:number):number {
		v &= 255;
		this.mk_reasonb(v, 0, ARITH_OP.SET);
		this.cc = (this.cc & 0x0F) | (v == 0 ? CC_V : 0) |
			(v > 127 ? CC_M : 0) | (link << 4) | (fault << 5);
		return v;
	}
	flags_a8vml(lh:number, rh:number, cin=0):number {
		lh &= 255; rh &= 255;
		if(cin != 0) {
			rh = rh ^ 255;
			this.mk_reasonb(lh, rh, ARITH_OP.SUB);
		} else {
			this.mk_reasonb(lh, rh, ARITH_OP.ADD);
		}
		let v = lh + rh + cin;
		let c = (v > 255) ? CC_L : 0;
		v &= 255;
		if(v == 0) c |= CC_V;
		if(v > 127) c |= CC_M;
		this.cc = (this.cc & 0x2F) | c;
		return v;
	}
	flags_a8vmfl(lh:number, rh:number, cin:number):number {
		lh &= 255; rh = (cin!=0?rh^255:rh) & 255;
		let v = lh + rh + cin;
		let c = (v > 255) ? (CC_F | CC_L) : 0;
		v &= 255;
		if(cin != 0) {
			this.mk_reasonb(lh, rh ^ 255, ARITH_OP.SUB);
		} else {
			this.mk_reasonb(lh, rh, ARITH_OP.ADD);
		}
		lh &= 127; rh &= 127;
		if((lh + rh + cin) > 127) c ^= CC_F;
		if(v == 0) c |= CC_V;
		if(v > 127) c |= CC_M;
		this.cc = (this.cc & 0x0F) | c;
		return v;
	}
	flags_n8vmfl(old:number, res:number):number {
		old &= 255; res &= 255;
		this.mk_reasonb(0, res, ARITH_OP.ADD);
		let c = ((res ^ old) > 127) ? CC_F : 0;
		if(res == 0) c |= CC_V;
		if(res > 127) c |= CC_M;
		this.cc = (this.cc & 0x0F) | c;
		return res;
	}
	flags_a8vmf(lh:number, rh:number, cin=0):number {
		lh &= 255; rh = (cin!=0?rh^255:rh) & 255;
		let v = lh + rh + cin;
		let c = (v > 255) ? CC_F : 0;
		v &= 255;
		this.mk_reasonb(lh, rh, ARITH_OP.ADD);
		lh &= 127; rh &= 127;
		if((lh + rh + cin) > 127) c ^= CC_F;
		if(v == 0) c |= CC_V;
		if(v > 127) c |= CC_M;
		this.cc = (this.cc & 0x1F) | c;
		return v;
	}
	flags_a16vmfl(lh:number, rh:number, cin=0):number {
		lh &= 65535; rh &= 65535;
		if(cin != 0) {
			rh = rh ^ 65535;
			this.mk_reasonw(lh, rh, ARITH_OP.SUB);
		} else {
			this.mk_reasonw(lh, rh, ARITH_OP.ADD);
		}
		let v = lh + rh + cin;
		let c = (v > 65535) ? (CC_F | CC_L) : 0;
		v &= 65535;
		lh &= 32767; rh &= 32767;
		if((lh + rh + cin) > 32767) c ^= CC_F;
		if(v == 0) c |= CC_V;
		if(v > 32767) c |= CC_M;
		this.cc = (this.cc & 0x0F) | c;
		return v;
	}
	flags_n16vmfl(old:number, res:number):number {
		old &= 65535; res &= 65535;
		this.mk_reasonw(0, res, ARITH_OP.ADD);
		let c = ((res ^ old) > 32767) ? CC_F : 0;
		if(res == 0) c |= CC_V;
		if(res > 32767) c |= CC_M;
		this.cc = (this.cc & 0x0F) | c;
		return res;
	}
	flags_a16vmf(lh:number, rh:number, cin:number):number {
		lh &= 65535; rh &= 65535;
		if(cin != 0) {
			rh = rh ^ 65535;
			this.mk_reasonw(lh, rh, ARITH_OP.SUB);
		} else {
			this.mk_reasonw(lh, rh, ARITH_OP.ADD);
		}
		let v = lh + rh + cin;
		let c = (v > 65535) ? CC_F : 0;
		v &= 65535;
		lh &= 32767; rh &= 32767;
		if((lh + rh + cin) > 32767) c ^= CC_F;
		if(v == 0) c |= CC_V;
		if(v > 32767) c |= CC_M;
		this.cc = (this.cc & 0x1F) | c;
		return v;
	}
	flags_16vm(v:number):number {
		v &= 65535;
		this.mk_reasonw(v, 0, ARITH_OP.SET);
		this.cc = (this.cc & 0x3F) | (v == 0 ? 0x80 : 0) |
		(v > 32767 ? 0x40 : 0);
		return v;
	}
	flags_16vmfl(v:number, fault:number, link:number):number {
		v &= 65535;
		this.mk_reasonw(v, 0, ARITH_OP.SET);
		this.cc = (this.cc & 0x0F) | (v == 0 ? 0x80 : 0) |
			(v > 32767 ? 0x40 : 0) | (link << 4) | (fault << 5);
		return v;
	}
	restore() {
		this.cc = this._snap.cc;
		this.level = this._snap.level;
		this.pc = this._snap.pc;
		for(let i = 0; i < 256; i++) {
			this.reg[i] = this.reg_snap[i];
		}
		this.src_pointer = 0;
		if(um_enable_sync) {
			mcsim.cc = this._snap.cc;
			mcsim.set_pc(this._pc);
			mcsim.reg.a = this.levelreg.a;
			mcsim.reg.b = this.levelreg.b;
			mcsim.reg.x = this.levelreg.x;
			mcsim.reg.y = this.levelreg.y;
			mcsim.reg.z = this.levelreg.z;
			mcsim.reg.s = this.levelreg.s;
			mcsim.reg.c = this.levelreg.c;
			for(let address = 0x100; address < 0x10000; address++) {
				this.mem.writemeta(address | 0x10000, 0);
				bpl.writemeta(address, this.mem.readmeta(address) & 255);
			}
		} else {
			for(let address = 0x100; address < 0x10000; address++) {
				this.mem.writemeta(address | 0x10000, 0);
			}
		}
	}
	snap() {
		this._snap.cc = this.cc;
		this._snap.level = this.level;
		this._snap.pc = this._pc;
		for(let i = 0; i < 256; i++) {
			this.reg_snap[i] = this.reg[i];
		}
		for(let address = 0; address < 0x10000; address++) {
			let i = this.mem.readmeta(address | 0x10000);
			if((i&0x400)!=0) {
				this.mem.writemeta(address, i & 255);
				this.mem.writemeta(address | 0x10000, 0);
			}
		}
	}
	m_write(address:number, v8:number):void {
		address &= 65535;
		if(um_enable_sync) bpl.writemeta(address, v8 & 255);
		if(address < 0x100) {
			this.reg[address] = v8 & 255;
		} else {
			this.mem.writemeta(address | 0x10000, (v8 & 255) | 0x400);
		}
	}
	m_writew(address:number, v16:number):void {
		this.m_write(address, v16 >> 8);
		this.m_write(address+1, v16);
	}
	write(address:number, v8:number):void {
		address &= 65535;
		let add_tr = true;
		for(let i = 0; i < this.trace.list.length; i++) {
			const t = this.trace.list[i];
			if(t.op == 'ST' && t.wh == address) {
				add_tr = false;
				break;
			}
		}
		if(add_tr) {
			let t = this.trace.add('ST', address);
		}
		if(address < 0x100) {
			softlog(`r[${hex(address,2)}]=${hex(v8&255,2)}`);
			this.reg[address] = v8 & 255;
		} else {
			softlog(`[${hex(address,4)}]=${hex(v8&255,2)}`);
			this.mem.writemeta(address | 0x10000, (v8 & 255) | 0x400);
		}
	}
	writew(address:number, v16:number):void {
		this.write(address, v16 >> 8);
		this.write(address + 1, v16);
	}
	stackb(v8:number):void {
		let stk = this.registers[this.level].s;
		this.write(--stk, v8);
		this.registers[this.level].s = stk;
	}
	stackw(v16:number):void {
		let stk = this.registers[this.level].s;
		this.write(--stk, v16);
		this.write(--stk, v16 >> 8);
		this.registers[this.level].s = stk;
		softlog(`${this.level}/S=${hex(this.registers[this.level].s,4)} (PUSH ${hex(v16,4)})`);
	}
	popb():number {
		let stk = this.registers[this.level].s;
		let v = this.fetch(stk++);
		this.registers[this.level].s = stk;
		return v;
	}
	popw():number {
		let stk = this.registers[this.level].s;
		let v = this.fetch(stk++) << 8;
		v |= this.fetch(stk++);
		this.registers[this.level].s = stk;
		softlog(`${this.level}/S=${hex(this.registers[this.level].s,4)} (POP ${hex(v,4)})`);
		return v;
	}
	fetch_hex(where:number, count:number):string {
		let str = '';
		where += 2;
		for(let r = 0; r < count; r++) {
			let c = this.fetch(where+r);
			str += hex(c);
		}
		return str;
	}
	fetch_str(where:number, limit:number=120):string {
		let len = this.fetchw(where);
		let str = '';
		where += 2;
		for(let r = 0; (r < len) && (r < limit); r++) {
			let c = this.fetch(where+r);
			if(c==0) { continue; }
			c = c & 127;
			if(c==10) {str += '\\n'; continue; }
			if(c==13) {str += '\\r'; continue; }
			str += String.fromCharCode(c);
		}
		return str;
	}
	fetch(address:number):number {
		address &= 65535;
		if(address < 0x100) {
			return this.reg[address];
		} else {
			let i = this.mem.readmeta(address | 0x10000);
			if((i & 0x400) != 0) return i & 255;
			return this.mem.readmeta(address) & 255;
		}
	}
	fetchw(address:number):number {
		const vh = this.fetch(address);
		const vl = this.fetch(address + 1);
		return (vh << 8) | vl;
	}
	pcfetch():number {
		const v = this.fetch(this._pc);
		this.pc = this._pc + 1;
		return v;
	}
	pcfetchw():number {
		const vh = this.fetch(this._pc);
		const vl = this.fetch(this._pc + 1);
		this.pc = this._pc + 2;
		return (vh << 8) | vl;
	}
	ex_decode(initb:number, llen = 1) {
		const m = initb;
		const ex = this.rref;
		ex.cdval = m >> 4; // selector
		//ex.reg
		// ex.sv -> src address
		let rby = -1;
		switch((m >> 2) & 3) {
		case 0: ex.srcval = this.pcfetchw(); break;
		case 1: {
			let rpair = this.pcfetch();
			ex.srcval = this.get_rw(rpair >> 4);
			if((rpair & 15) != 0) {
				ex.srcval += this.get_rw(rpair & 15);
			}
			if((rpair & 16) != 0) {
				ex.srcval += this.pcfetchw();
			} else {
				ex.srcval += sbyte(this.pcfetch());
			}
			ex.srcval &= 65535;
			break;
		}
		case 2: rby = this.pcfetch();
			ex.srcval = this.get_rw(rby >> 4);
			break;
		case 3: ex.srcval = this.pc; this.pc = this._pc + llen; break;
		}
		// ex.ea -> dest address
		switch(m & 3) {
		case 0: ex.addr = this.pcfetchw(); break;
		case 1: {
			let rpair = this.pcfetch();
			ex.addr = this.get_rw(rpair >> 4);
			if((rpair & 15) != 0) {
				ex.addr += this.get_rw(rpair & 15);
			}
			if((rpair & 16) != 0) {
				ex.addr += this.pcfetchw();
			} else {
				ex.addr += sbyte(this.pcfetch());
			}
			ex.addr &= 65535;
			break;
		}
		case 2: if(rby == -1) rby = this.pcfetch();
			ex.addr = this.get_rw(rby & 15);
			break;
		case 3:throw {ex:3};
		}
		return ex;
	}
	rrsrfetchw():rrscdata {
		let rvc = this.pcfetch();
		const rref = this.rref;
		rref.srcreg = (rvc >> 4);
		rref.dstreg = (rvc & 15);
		const rrmode = rvc & 17;
		rref.srcval = this.get_rw(rref.dstreg);
		rref.cdval = 0;
		if (rrmode == 0) {
			rref.cdval = this.get_rw(rref.srcreg);
			rref.is_addr = false;
		} else {
			this.lea_immw();
			rref.is_addr = true;
			//if (rrmode == 16) //MSN odd: r(dst) -> #adr
			if ((rrmode & 1) != 0) {
				//MSN even: r(dst) -> w[ adr ]
				rref.addr = this.fetchw(rref.addr);
			}
			if (rrmode == 17) {
				//both: r(dst) -> [ r(src) + adr ]
				rref.addr = (rref.addr + this.get_rw(rref.srcreg)) & 65535;
			}
		}
		return rref;
	}
	rrfetchb():rrscdata {
		let rvc = this.pcfetch();
		const rref = this.rref;
		rref.srcreg = rvc >> 4;
		rref.dstreg = rvc & 15;
		rref.srcval = this.get_rb(rref.srcreg);
		rref.cdval = this.get_rb(rref.dstreg);
		rref.is_addr = false;
		return rref;
	}
	rrfetchw():rrscdata {
		let rvc = this.pcfetch();
		const rrmode = rvc & 17;
		const rref = this.rref;
		rref.srcreg = rvc >> 4;
		rref.dstreg = rvc & 15;
		rref.is_addr = false;
		if (rrmode == 0) {
			rref.srcval = this.get_rw(rref.srcreg);
			rref.cdval = this.get_rw(rref.dstreg);
		} else {
			this.lea_immw();
			// rrmode == 16 // 2
			// MSN odd
			//#adr, r(src) -> r(dst)
			if ((rrmode & 1) != 0) { // 1,3
				// MSN even
				//w[ adr ], r(src) -> r(dst)
				rref.addr = this.fetchw(rref.addr);
			}
			if (rrmode == 17) { // 3
				// [ r(src) + adr ] , r(dst) -> r(dst)
				rref.addr += this.get_rw(rref.srcreg);
				rref.srcreg = rref.dstreg;
			}
			rref.srcval = this.fetchw(rref.addr);
			rref.cdval = this.get_rw(rref.srcreg);
		}
		return rref;
	}
	rcfetchb():rrscdata {
		let rvc = this.pcfetch();
		const rref = this.rref;
		rref.dstreg = rref.srcreg = rvc >> 4;
		rref.cdval = rvc & 15;
		rref.srcval = this.get_rb(rref.srcreg);
		rref.is_addr = false;
		return rref;
	}
	rcfetchw():rrscdata {
		let rvc = this.pcfetch();
		const rcref = this.rref;
		rcref.dstreg = rcref.srcreg = rvc >> 4;
		rcref.cdval = rvc & 15;
		rcref.is_addr = false;
		if((rcref.srcreg & 1) != 0) {
			throw {rc:rcref.srcreg};
		} else {
			rcref.srcval = this.get_rw(rcref.srcreg);
		}
		return rcref;
	}
	lea_immw():void {
		this.rref.addr = this._pc;
		this.pc = this._pc + 2;
	}
	lea_immb():void {
		this.rref.addr = this._pc;
		this.pc = this._pc + 1;
	}
	lea_dir():void {
		this.rref.addr = this.pcfetchw();
	}
	lea_ind():void {
		this.rref.addr = this.fetchw(this.pcfetchw());
	}
	lea_pco():void {
		const ofs = sbyte(this.pcfetch());
		this.rref.addr = (this.pc + ofs) & 65535;
	}
	lea_ipo():void {
		const ofs = sbyte(this.pcfetch());
		const ea = (this.pc + ofs) & 65535;
		this.rref.addr = this.fetchw(ea);
	}
	lea_mod(sz:number = 1):void {
		const modv:number = this.pcfetch();
		if((modv & 16) != 0) {
			throw {mod:modv};
		}
		let reg = this.get_rw(modv >> 4);
		if ((modv & 4) != 0) sz = 2; // indirection always points at words
		if ((modv & 3) == 2) {
			// reg predec
			reg = (reg - sz) & 65535;
		}
		let res = reg;
		if ((modv & 3) == 1) {
			// reg postinc
			reg = (reg + sz) & 65535;
		}
		this.set_rw(modv >> 4, reg);
		if ((modv & 8) != 0) {
			let disp = sbyte(this.pcfetch());
			res = (res + disp) & 65535;
		}
		if ((modv & 4) != 0) {
			this.rref.addr = this.fetchw(res);
		} else {
			this.rref.addr = res;
		}
	}
	rcb_io(rcb:number, ext=false):RCBT {
		let unit = this.fetch(rcb+1);
		let unitname;
		if(OPS_UNIT_NAMES[unit] != undefined) {
			unitname = OPS_UNIT_NAMES[unit];
		} else {
			unitname = 'U'+hex(unit);
		}
		let iofn = this.fetch(rcb+3);
		let rbbln = this.fetchw(rcb+4); //max buffer length
		let rbbuf = this.fetchw(rcb+6); //buffer address
		let sfn = [undefined,
		'read','write','rewrite','rewind',
		'note','point','hold','free',
		'open','close','truncate buffer',
		'new key','get key','delete key','next key'][iofn];
		if(sfn == undefined) throw new Error('RCB');
		if(ext) {
			let lsr = this.fetchw(rcb+10);
			let devc = this.fetch(rcb+12);
			let filet = this.fetch(rcb+13);
			let max_rec = this.fetchw(rcb+14);
			let rec_adr = this.fetchw(rcb+16);
			let ra_rec_size = this.fetchw(rcb+28);
			return {
				rcb:unit, unit:unitname, f:sfn, rbbln, rbbuf,
				lsr, dev_class:devc, file_type:filet,
				max_rec_size: max_rec,
				rec_address: rec_adr,
				rec_size: ra_rec_size,
				ext:true
			};
		} else {
			return {rcb:unit, unit:unitname, f:sfn, rbbln, rbbuf, ext:false};
		}
	}
	handle_svc(svc:number) {
		switch(svc) {
		//case 0: //00 @pioc   physical i/o control
		case 1: //01 @trtn   transient return
			throw {svcret: 1};
		//case 2: //02 @lodnm  load file name specified
		//case 3: //03 @lodf   load fcb specified
		case 4: {//04 @lodjx  load jx module specified
			// inline args: word, byte
			break;
		}
		case 5: { //05 @ts     load transient module
			let ts_id = this.pcfetch();
			let dst = this.pcfetchw();
			console.log('Transient', ts_id, hex(dst, 4));
			if(ts_id == 4) { // char date
				let cv = `11/22/22`;
				for(let i = 0; i < cv.length; i++) {
					this.m_write(dst, (cv.charCodeAt(i) & 127) | 128);
					dst++;
				}
				return;
			}
			if(ts_id == 12) return; // with RCB ptr, gets file date into A
			if(ts_id == 13) return; // with RCB ptr, sets file date from A
			throw {ts:ts_id};
		}
		//case 6: //06 @flwt   wait for flag to go positive
		case 7: return; //07 @wt     uncontitional wait
		case 8: {//08 @rbwt   wait for rcb to go ready
			let dst = this.pcfetchw();
			//console.log('rcb wait', hex(dst, 4));
			return;
		}
		case 9: //09 @abrt   abort task
			throw {svcret: 9, code: this.pcfetch()};
		case 10: //0A @exit   exit to ojx00
			throw {svcret: 10, code: this.pcfetch()};
		case 11: {//0B @dt     get binary date
			this.levelreg.b = 0x4444;
			mcsim.reg.b = 0x4444;
			return;
		}
		//case 12: //0C @pgiob  protected get i/o block
		case 13: {//0D @jxm    protected change to jx map
			// no inline args
			break;
		}
		case 14: {//0E @dirnm  search directory for file name specified
			// inline arg: ptr file name?
			break;
		}
		case 15: { //0F @conio  console i/o
			// no inline args
			break;
		}
		case 16: { //10 @sysio  device independant logical unit i/o (all units)
			const rcb = this.levelreg.b;
			let maxbuf = this.fetchw(rcb+4);
			let bufadr = this.fetchw(rcb+6);
			let ctrl = this.fetchw(rcb+8);
			const prcb = this.rcb_io(rcb, false);
			//console.log('@sysio', prcb, hex(bufadr, 4), hex(maxbuf, 4), hex(this.fetchw(bufadr), 4));
			if(prcb.f == 'write') {
				console.log('@sysio', this.fetch_str(bufadr));
			}
			return;
		}
		//case 17: //11 @gmemr  @gmem with a=addr b=size
		//case 18: //12 @flwtr  @flwt with flag address in al
		//case 19: //13 @rmemr  @rmem with address in a
		//case 20: //14 @drdy   disk ready check
		//case 21: //15 @gbr    get bin time into a and b regs
		case 22: {//16 @gmem   get memory block from transient area
			// inline args: 2 ptr
			break;
		}
		//case 23: //17 @rmem   release memory block back to transient area
		case 24: {//18 @lioc   logical i/o control
			const rcb = this.levelreg.b;
			let maxbuf = this.fetchw(rcb+4);
			let bufadr = this.fetchw(rcb+6);
			let ctrl = this.fetchw(rcb+8);
			// this was seen using the RCB logical I/O extensions
			// others also?
			const prcb = this.rcb_io(rcb, true);
			if(prcb.f == 'rewind' && prcb.rcb == 1) {
				this.src_pointer = 0;
				this.m_write(rcb, 0);
			} else if(prcb.f == 'read' && prcb.rcb == 1 && prcb.ext) {
				let a = prcb.rec_address;
				if(this.src_pointer >= this.src_buffer.length) {
					this.m_write(rcb, 1);
					return;
				}
				let rec_line = this.src_buffer[this.src_pointer];
				if(rec_line.length > prcb.max_rec_size) {
					rec_line = rec_line.substring(0, prcb.max_rec_size - 1);
				}
				this.m_writew(a, rec_line.length);
				this.m_writew(bufadr, rec_line.length);
				a += 2;
				bufadr += 2;
				for(let i = 0; i < rec_line.length; i++) {
					let c = rec_line.charCodeAt(i) & 127;
					if(c == 10) c = 13;
					c |= 128;
					this.m_write(a, c);
					this.m_write(bufadr, c);
					bufadr++;
					a++;
				}
				this.m_write(a, 0);
				this.m_write(rcb, 0);
				this.src_pointer += 1;
			} else if(prcb.f == 'write' && prcb.ext) {
				if(prcb.rcb == 3) {
					if(editors.out_m) {
						softlog(this.fetch_str(prcb.rec_address));
					} else {
						console.log('@lioc:w3', this.fetch_str(prcb.rec_address));
					}
				}
				else console.log('@lioc:w', prcb, hex(this.fetchw(prcb.rec_address),4), hex(prcb.rec_address,4));
			} else {
				console.log('@lioc', prcb, hex(bufadr, 4), hex(maxbuf, 4), hex(this.fetchw(bufadr), 4));
			}
			return;
		}
		//case 25: //19 @exp    file expand
		//case 26: //1A @user   change to user mode
		//case 27: //1B @gb     get binary time
		//case 28: //1C @gc     get character time
		//case 29: //1D @stime  set time lock
		//case 30: //1E @ld     cpl 32-bit load
		//case 31: //1F @st     cpl 32-bit store
		//case 32: //20 @ad     cpl 32-bit add
		//case 33: //21 @tsr    @ts with tx# in au
		//case 34: //22 @su     cpl 32-bit subtract
		//case 35: //23 @gdpub  locate pub for disk specified in al
		//case 36: //24 @mu     cpl 32-bit multiply
		//case 37: //25 @dv     cpl 32-bit divide
		//case 38: //26 @cn     cpl 32-bit numeric compare
		//case 39: //27 @cs     cpl string compare
		//case 40: //28 @cg     cpl 32-bit computed goto
		//case 41: //29 @mv     cpl string move
		//case 42: //2A @cp     cpl cursor position
		case 43:{//2B @mul16  16-bit multiply
			let e = this.levelreg.a * this.levelreg.b;
			mcsim.reg.b = this.levelreg.b = e & 65535;
			mcsim.reg.a = this.levelreg.a = (e >> 16) & 65535;
			return;
		}
		//case 44: //2C @div16  16-bit divide
		//case 45: //2D @cvd16  16-bit cvt to dec from memory
		case 46: {//2E @cvr16  16-bit cvt to dec from 'a' reg
			let cv = `${this.levelreg.a}`;
			let a = this.pcfetchw();
			for(let i = 0; i < cv.length; i++) {
				this.m_write(a, (cv.charCodeAt(i) & 127) | 128);
				a++;
			}
			return;
		}
		//case 47: //2F @cb     cpl cursor blanking
		//case 48: //30 @cc     cpl cursor blanking with specified string
		//case 49: //31 @wn     cpl formatted write with out c/r
		//case 50: //32 @dc     cpl decode
		//case 51: //33 @nc     cpl encode
		//case 52: //34 @rf     cpl formatted read
		//case 53: //35 @wf     cpl formatted write
		//case 54: //36 @rt     cpl re-write
		//case 55: //37 @rb     cpl binary read
		//case 56: //38 @wb     cpl binary write
		//case 57: //39 @op     cpl open
		//case 58: //3A @ct     cpl control function
		//case 59: //3B @ld48   cpl 48-bit load
		//case 60: //3C @st48   cpl 48-bit store
		//case 61: //3D @ad48   cpl 48-bit add
		//case 62: //3E @rs     cpl record skip
		//case 63: //3F @su48   cpl 48-bit subtract
		//case 64: //40 @tioc   tape io
		//case 65: //41 @mu48   cpl 48-bit multiply
		//case 66: //42 @dv48   cpl 48-bit divide
		//case 67: //43 @cn48   cpl 48-bit numeric compare
		//case 68: //44 @cg48   cpl 48-bit computed goto
		//case 69: //45 @ld64   cpl 64-bit load
		//case 70: //46 @st64   cpl 64-bit store
		//case 71: //47 @ad64   cpl 64-bit add
		//case 72: //48 @su64   cpl 64-bit subtract
		//case 73: //49 @mu64   cpl 64-bit multiply
		//case 74: //4A @dv64   cpl 64-bit divide
		//case 75: //4B @ttime  test time lock
		//case 76: //4C @dio    disk i/o
		//case 77: //4D @shld   sector hold
		//case 78: //4E @sfre   sector free
		//case 79: //4F @dirl   search library directory
		//case 80: //50 @dire   locate directory entry specified
		//case 81: //51 @dird   set date of file or subfile
		case 82: { //52 @giob   unprotected giob
			let rcb = this.levelreg.b;
			// does this read the PUB?
			let unkn = this.pcfetch();
			let count = this.pcfetch();
			let offs = this.pcfetch();
			let dest = this.pcfetchw();
			if(count != 0) throw {svc:82};
			this.levelreg.b = 0;
			mcsim.reg.b = 0;
			return;
		}
		//case 83: //53 @fmd    hard disk format
		//case 84: //54 @drnmb  directory search
		//case 85: //55 @diosx  execute disk command string
		//case 86: //56 @fsvc   fake svc call
		//case 87: //57 @lodtx  load tx module
		//case 88: //58 @bug    bug
		case 89: {//59 @aseg   add next free mem segment to curtb (wait for comp)
			let load_seg = this.tibview.getUint16(12);
			load_seg += 0x800;
			this.tibview.setUint16(12, load_seg);
			return;
		}
		case 90: {//5A @rseg   release memory segment specified in al
			let seg = this.levelreg.al;
			// no inline args
			break;
		}
		case 91: //5B @lodnmt load name into transient area
			break;
		case 92: {//5C @gbkv   get os block value
			let blk = this.pcfetch();
			let count = this.pcfetch();
			let offs = this.pcfetch();
			let dest = this.pcfetchw();
			if(blk == 1) {
				let rcb = this.levelreg.b;
				if(offs == 1) {
					console.log('@gbkv 1:', this.rcb_io(rcb))
					this.m_write(dest, 1);
					return;
				}
			}
			if(blk != 0) throw {};
			while(count > 0 && offs < this.tib.length) {
				this.m_write(dest, this.tib[offs]);
				offs += 1; dest += 1; count -= 1;
			}
			return;
		}
		case 93: {//5D @pbkv   set os block value
			let blk = this.pcfetch();
			let count = this.pcfetch();
			let offs = this.pcfetch();
			let dest = this.pcfetchw();
			if(blk != 0) throw {};
			break;
		}
		//case 94: //5E @asegr  add next free mem seg to curtb (ret if not avail)
		//case 95: //5F @gprm   get general parameter
		//case 96: //60 @pprm   set general parameter
		//case 97: //61 @ccc    security code check
		//case 98: //62 @lodfr  load fcb from .run
		//case 99: //63 @rsegx  release other part memory
		//case 100://64 @dirlf  create fcb for file in private lib
		//case 101://65 @dirsz  access size of file in private lib
		//case 102://66 @eom    check for eof/eom
		//case 103://67 @gvol   get volume name
		//case 104://68 @rlsr   return from lsr
		//case 105://69 @isrm   connect/disconnect isr from pub
		//case 106://6A @basic  enter basic monitor for current partition
		//case 107://6B @abrtr  abort with ab code in al
		//case 108://6C @exitr  exit with cc al
		default: break;
		}
		throw {svc:svc};
	}
	f_jsr(ea:number):void {
		const levelreg = this.levelreg;
		this.stackw(levelreg.x);
		this.set_rw(REG.X, this._pc);
		//levelreg.x = this.pc;
		//this.trace.add('JSR', ea);
		this.pc = ea;
	}
	f_branch(cm:number, cn:string, z:boolean):void {
		const rref = this.rref;
		let t = this.trace.add(cn, rref.addr);
		t.tk = false;
		if(cn == 'BZ ' || cn == 'BNZ') {
			t.param = this.reason_v;
		}
		if(cn == 'BM ' || cn == 'BP ') {
			t.param = this.reason_m;
		}
		if(z) {
			if((this.cc & cm)==0) {this.pc = rref.addr;t.tk=true;}
		} else {
			if((this.cc & cm)!=0) {this.pc = rref.addr;t.tk=true;}
		}
	}
	step():void {
		this.trace.count = 0;
		//this.reason_v = '';
		const soi = this.pc;
		const op = this.pcfetch();
		const opl = oplist[op];
		const rref = this.rref;
		rref.reg = this.registers[this.level];
		switch(opl.md) {
		case OPM.IMPL: break;
		case OPM.IMM: if(opl.w == TXS.B) this.lea_immb(); else this.lea_immw(); break;
		case OPM.DIR: this.lea_dir(); break;
		case OPM.IND: this.lea_ind(); break;
		case OPM.PCO: this.lea_pco(); break;
		case OPM.IPO: this.lea_ipo(); break;
		case OPM.MOD: this.lea_mod((opl.w == TXS.B) ? 1 : 2); break;
		case OPM.RR: if(opl.w == TXS.B) this.rrfetchb(); else this.rrfetchw(); break;
		case OPM.RRX: throw 0;
		case OPM.RRSR: this.rrsrfetchw(); break;
		case OPM.RRS: if(opl.w == TXS.B) this.rrfetchb(); else this.rrfetchw(); break;
		case OPM.RC:
			if(opl.w == TXS.B) this.rcfetchb(); else this.rcfetchw();
			if(opl.i !== undefined) rref.cdval += opl.i;
			break;
		case OPM.IMPL_R:
			if(opl.dr == undefined)
				throw new Error(`(${hex(op)}) opcode table error, no destination register`);
			rref.dstreg = opl.dr;
			if(opl.ms == undefined) {
				rref.srcreg = rref.dstreg;
				rref.cdval = 0;
				if(opl.i !== undefined) rref.cdval += opl.i;
				if(opl.w == TXS.B) rref.srcval = this.get_rb(rref.dstreg);
				else rref.srcval = this.get_rw(rref.dstreg);
			} else if(opl.ms == OPM.IMPL_R) {
				if(opl.w == TXS.B) rref.cdval = this.get_rb(rref.dstreg);
				else rref.cdval = this.get_rw(rref.dstreg);
			} // else ... pure destination
			break;
		case OPM.IMPL_R_DIR:
			if(opl.dr == undefined)
				throw new Error(`(${hex(op)}) opcode table error, no destination register`);
			rref.dstreg = opl.dr;
			rref.addr = this.get_rw(rref.dstreg);
			break;
		default: throw new Error(`(${hex(op)}) opcode md unhandled: ${opl.md}`);
		}
		switch(opl.ms) {
		case undefined:
		case OPM.IMPL: break;
		case OPM.IMM:
			if(opl.w == TXS.B) {
				this.lea_immb();
				rref.srcval = this.fetch(rref.addr);
			} else {
				this.lea_immw();
				rref.srcval = this.fetchw(rref.addr);
			}
			break;
		case OPM.DIR: this.lea_dir();
			if(opl.w == TXS.B) rref.srcval = this.fetch(rref.addr);
			else rref.srcval = this.fetchw(rref.addr);
			break;
		case OPM.IND: this.lea_ind();
			if(opl.w == TXS.B) rref.srcval = this.fetch(rref.addr);
			else rref.srcval = this.fetchw(rref.addr);
			break;
		case OPM.PCO: this.lea_pco();
			if(opl.w == TXS.B) rref.srcval = this.fetch(rref.addr);
			else rref.srcval = this.fetchw(rref.addr);
			break;
		case OPM.MOD: this.lea_mod((opl.w == TXS.B) ? 1 : 2);
			if(opl.w == TXS.B) rref.srcval = this.fetch(rref.addr);
			else rref.srcval = this.fetchw(rref.addr);
			break;
		case OPM.IMPL_R:
			if(opl.sr == undefined)
				throw new Error(`(${hex(op)}) opcode table error, no source register`);
			rref.srcreg = opl.sr;
			if(opl.w == TXS.B) rref.srcval = this.get_rb(rref.srcreg);
			else rref.srcval = this.get_rw(rref.srcreg);
			break;
		case OPM.IMPL_R_DIR:
			if(opl.sr == undefined)
				throw new Error(`(${hex(op)}) opcode table error, no source register`);
			rref.srcreg = opl.sr;
			rref.addr = this.get_rw(rref.srcreg);
			if(opl.w == TXS.B) rref.srcval = this.fetch(rref.addr);
			else rref.srcval = this.fetchw(rref.addr);
			break;
		default: throw new Error(`(${hex(op)}) unsupported source mode`);
		}
		if(opl.opc != undefined) {
			opl.opc.call(this, rref);
			return;
		}
		softlog(`${hex(rref.addr)},${hex(rref.srcval)},${hex(rref.cdval)} ${hex(rref.srcreg)}>${hex(rref.dstreg)} ${hex(rref.reg.level)}`);
		if(opl.opf != undefined) {
			rref.link = (this.cc >> 4) & 1;
			rref.fault = (this.cc >> 5) & 1;
			const fr = opl.opf.call(this, rref);
			switch(opl.fl) {
			case FLAGS.F:
				this.cc = (this.cc & CC_NF) | ((rref.fault & 1) << 5);
				rref.cdval = fr;
				break;
			case FLAGS.L:
				this.cc = (this.cc & CC_NL) | ((rref.link & 1) << 4);
				rref.cdval = fr;
				break;
			case FLAGS.MV:
				if(opl.w == TXS.B) rref.cdval = this.flags_8vm(fr);
				else rref.cdval = this.flags_16vm(fr);
				break;
			case FLAGS.FLMV:
				if(opl.w == TXS.B) rref.cdval = this.flags_8vmfl(fr, rref.fault, rref.link);
				else rref.cdval = this.flags_16vmfl(fr, rref.fault, rref.link);
				break;
			case FLAGS.ArithFMV:
			case FLAGS.ArithFLMV:
				if(opl.w == TXS.B)
					rref.cdval = this.flags_a8vmfl(rref.srcval, fr, 0);
				else
					rref.cdval = this.flags_a16vmfl(rref.srcval, fr, 0);
				break;
			case FLAGS.None:
			default: rref.cdval = fr; break;
			}
			if(opl.w == TXS.B)
				softlog(`${hex(op)}: OPF(${hex(fr)})->(${hex(rref.cdval)})`);
			else softlog(`${hex(op)}: OPF(${hex(fr,4)})->(${hex(rref.cdval,4)})`);
			if(opl.md == OPM.IMPL) softlog(`warn: (${hex(op)}) OPM.IMPL with OPF`);
		} else if(opl.aop !== undefined) {// Core operations
			let ocd = rref.cdval;
			switch(opl.aop) {
			case AOP.ADD:
				if(opl.w == TXS.B) {
					rref.cdval = this.flags_a8vmfl(rref.srcval, rref.cdval, 0);
					softlog(`AOP:ADD ${hex(rref.srcval)}+${hex(ocd)}->${hex(rref.cdval)}`);
				} else {
					rref.cdval = this.flags_a16vmfl(rref.srcval, rref.cdval, 0);
					softlog(`AOP:ADD ${hex(rref.srcval,4)}+${hex(ocd,4)}->${hex(rref.cdval,4)}`);
				}
				break;
			case AOP.SUB:
				if(opl.w == TXS.B) {
					rref.cdval = this.flags_a8vmfl(rref.srcval, rref.cdval, 1);
					softlog(`AOP:SUB ${hex(rref.srcval)}+${hex(ocd)}->${hex(rref.cdval)}`);
				} else {
					rref.cdval = this.flags_a16vmfl(rref.srcval, rref.cdval, 1);
					softlog(`AOP:SUB ${hex(rref.srcval,4)}+${hex(ocd,4)}->${hex(rref.cdval,4)}`);
				}
				break;
			case AOP.XFR:
				if(opl.w == TXS.B) rref.cdval = this.flags_8vm(rref.srcval);
				else rref.cdval = this.flags_16vm(rref.srcval);
				softlog(`AOP:XFR ${hex(rref.srcval)}->${hex(rref.cdval)}`);
				break;
			case AOP.AND:
				if(opl.w == TXS.B)
					rref.cdval = this.flags_n8vmfl(rref.cdval, rref.srcval & rref.cdval);
				else rref.cdval = this.flags_n16vmfl(rref.cdval, rref.srcval & rref.cdval);
				break;
			case AOP.ORI:
				if(opl.w == TXS.B)
					rref.cdval = this.flags_n8vmfl(rref.cdval, rref.srcval | rref.cdval);
				else rref.cdval = this.flags_n16vmfl(rref.cdval, rref.srcval | rref.cdval);
				break;
			case AOP.XOR:
				if(opl.w == TXS.B)
					rref.cdval = this.flags_n8vmfl(rref.cdval, rref.srcval ^ rref.cdval);
				else rref.cdval = this.flags_n16vmfl(rref.cdval, rref.srcval ^ rref.cdval);
				break;
			case AOP.NOT:
				if(opl.w == TXS.B)
					rref.cdval = this.flags_8vm(rref.srcval ^ 255);
				else rref.cdval = this.flags_16vm(rref.srcval ^ 65535);
				break;
			case AOP.CLR:
				if(opl.w == TXS.B)
					rref.cdval = this.flags_8vmfl(rref.cdval, 0, 0);
				else rref.cdval = this.flags_16vmfl(rref.cdval, 0, 0);
				break;
			}
		} else if(opl.x == OPL_EXT.MEM) {// MEM.
			const ib = this.pcfetch();
			const sel = ib >> 4;
			let iml:number;
			if(opl.sr != undefined) iml = this.levelreg.al;
			else iml = this.pcfetch();
			switch(sel) {
			case 0:/*CVX*/break;
			case 1:/*CPV*/break;
			case 2:/*MVV*/break;
			case 3:/*SCN*/break;
			case 4:/*MVF*/{
				const ex = this.ex_decode(ib, iml+1);
				let z = 0;
				this.cc &= CC_NV & CC_NM;
				let c = this.fetch(ex.srcval);
				z |= c;
				this.write(ex.addr, c);
				if((c & 128) != 0) this.cc |= CC_M;
				while(iml > 0) {
					ex.srcval = (ex.srcval + 1) & 65535;
					ex.addr = (ex.addr + 1) & 65535;
					let c = this.fetch(ex.srcval);
					z |= c;
					this.write(ex.addr, c);
					iml -= 1;
				}
				this.cc &= CC_NV;
				if(z == 0) this.cc |= CC_V;
				//this.levelreg.y = ex.sv;
				//this.levelreg.z = ex.ea;
				return;
			}
			case 5:/*ANC*/break;
			case 6:/*ORC*/break;
			case 7:/*XRC*/break;
			case 8:/*CPF*/{
				const ex = this.ex_decode(ib, iml+1);
				let c, d;
				while(iml > -1) {
					c = this.fetch(ex.srcval);
					d = this.fetch(ex.addr);
					this.flags_a8vml(d, c, 1);
					if((this.cc & CC_V) == 0) break;
					ex.srcval = (ex.srcval + 1) & 65535;
					ex.addr = (ex.addr + 1) & 65535;
					iml -= 1;
				}
				this.cc &= CC_NF;
				if(iml == -1) this.cc |= CC_F;
				return;
			}
			case 9:{/*FIL*/
				const ex = this.ex_decode(ib, 1);
				let c = this.fetch(ex.srcval);
				while(true) {
					this.write(ex.addr, c);
					if(iml == 0) break;
					ex.addr = (ex.addr + 1) & 65535;
					iml -= 1;
				}
				return;
			}
			default: break;
			}
			softlog(`(${hex(op)}) is TODO`);
			throw {soi: soi};
		} else if(opl.x == OPL_EXT.BIG) {
			const lenb = this.pcfetch();
			const ib = this.pcfetch();
			const sel = ib >> 4;
			switch(sel) {
			case 0:/*A*/ break;
			case 1:/*S*/ break;
			case 2:/*C*/ break;
			case 3:/*ZAD*/{
				let sl = (lenb>>4)& 15;
				let dl = lenb&15;
				const ex = this.ex_decode(ib, sl+1);
				let src_addr = (ex.srcval + sl) & 65535;
				let dst_addr = (ex.addr + dl) & 65535;
				const src_sign = this.fetch(ex.srcval);
				let dst_sign = 0;
				let dst_zero = 0;
				this.cc &= CC_NF & CC_NM & CC_NV;
				while(dl > -1) {
					let c = 0;
					if(sl > -1) {
						c = this.fetch(src_addr);
						src_addr = (src_addr - 1) & 65535;
						sl -= 1;
					}
					dst_zero |= c;
					this.write(dst_addr, c);
					dst_addr = (dst_addr - 1) & 65535;
					if(dl == 0) {
						dst_sign = c;
						break;
					}
					dl -= 1;
				}
				console.log('ZAD',hex(ex.srcval,4),this.fetch_hex(ex.srcval, ((lenb>>4)& 15)), hex(ex.addr,4), this.fetch_hex(ex.addr, (lenb&15)));
				if(dst_zero == 0) this.cc |= CC_V;
				if(src_sign > 127) this.cc |= CC_M;
				if((dst_sign ^ src_sign) > 127) this.cc |= CC_F;
				return;
			}
			case 4:/*ZSU*/ break;
			case 5:/*M*/ break;
			case 6:/*D*/ break;
			case 7:/*DRM*/ break;
			case 8:/*CTB*/{
				const b = ((lenb>>4) & 15) + 2;
				let sl = this.levelreg.al;
				const dl = lenb&15;
				const ex = this.ex_decode(ib, sl+1);
				for(;sl > 0;sl -= 1) {
					let c = this.fetch(ex.srcval);
					ex.srcval = (ex.srcval + 1) & 65535;
					if(c == 0) continue;
					c &= 0x4f;
					if(c > 15) c -= 55;
					let dptr = ex.addr;
					let v = 0;
					let dcount = dl;
					while(dcount > -1) {
						v = this.fetch(dptr);
						v *= b;
						if(dcount==0) v += c;
						this.write(dptr, v);
						let a = v>>8;
						let rcount = dcount;
						const sptr = dptr + 1;
						while((a != 0) && (rcount < dl)) {
							dptr -= 1;
							v = a + this.fetch(dptr);
							a = v>>8;
							this.write(dptr, v);
							rcount += 1;
						}
						dcount -= 1;
						dptr = sptr;
					}
				}
				this.cc &= CC_NL;
				return;
			}
			case 9:/*CFB*/ break;
			}
		} else {
			softlog(`(${hex(op)}) is TODO`);
			throw {soi: soi};
		}
		switch(opl.md) { // generic RMW write backs
		case OPM.IMPL: return;
		case OPM.IMM:
		case OPM.DIR:
		case OPM.IND:
		case OPM.PCO:
		case OPM.MOD:
		case OPM.IMPL_R_DIR:
			if(opl.w == TXS.B) this.write(rref.addr, rref.cdval);
			else this.writew(rref.addr, rref.cdval);
			return;
		case OPM.RR:
		case OPM.RC:
		case OPM.RRS: // XFR
		case OPM.RRSR: // STR
			if(opl.w == TXS.B) {
				this.set_rb(rref.dstreg, rref.cdval);
			} else if(rref.is_addr) {
				this.writew(rref.addr, rref.cdval);
			} else this.set_rw(rref.dstreg, rref.cdval);
			return;
		case OPM.IMPL_R:
			if(opl.w == TXS.B) this.set_rb(rref.dstreg, rref.cdval);
			else this.set_rw(rref.dstreg, rref.cdval);
			return;
		}

		throw {soi: soi};
		switch(op) {
		case 4: break; /*EI*/
		case 5: break; /*DI*/
		case 0x0a:/*RI*/break;
		case 0x0b: throw 1; // illegal
		case 0x0d:/*PCX*/break;
		case 0x0f:/*RSV*/break;
		// 2X
		case 0x26:/*RRRB*/{
			const rc = this.rcfetchb();
			let v = rc.srcval;
			let link = 0;
			while(rc.cdval > -1) {
				link = v & 1;
				v = (v >> 1) | ((this.cc & 0x10) << 3);
				rc.cdval -= 1;
			}
			this.set_rb(rc.srcreg, this.flags_8vmfl(v, 0, link));
			return;
		}
		case 0x27:/*RLRB*/ break;
		//case 0x2c:/*SRAB*/levelreg.al = this.flags_8vml((levelreg.al >> 1) | (levelreg.al & 128), levelreg.al & 1); return;
		//case 0x2d:/*SLAB*/levelreg.al = this.flags_8vml((levelreg.al << 1) & 255, (levelreg.al & 128)!=0?1:0); return;
		case 0x2e: // page
			//"LDM","STM","LSM","SSM","FLM","MFM"
			break;
		case 0x2f: // DMA
			// 'SAD','RAD','SCT','RCT','SDV','RDV'
			// 'EAB','DAB','SMN','RMN'
			break;
		// 3X
		case 0x36:/*RRR*/ {
			const rc = this.rcfetchw();
			if(rc.cdval!=0) break;
			if((rc.srcreg & 1) != 0) {
				break;
			} else {
				let v = rc.srcval;
				let link = v & 1;
				v = (v >> 1) | ((this.cc & 0x10) << 11);
				this.set_rw(rc.srcreg, this.flags_16vmfl(v, 0, link));
				return;
			}
		}
		case 0x37:/*RLR*/ break;
		// 4X
		case 0x46: {// BIG.
			
			break;
		}

		// 5X
		case 0x56:/*EAO*/break;
		case 0x57:/*DAO*/break;
		// 6X
		case 0x6e:/*LST*/break;
		case 0x6f:/*SST*/break;
		// 7X
		case 0x70: throw 1; // !ill70
		case 0x76:/*EPE*/break;
		case 0x77:/*MUL*/break;
		case 0x78:/*DIV*/break;
		// 8X
		case 0x86:/*DPE // priv*/break;
		case 0x87: throw 1; // !ill87
		// 9X
		case 0x96:/*SOP*/break;
		case 0x97: throw 1; // !ill97
		// AX
		case 0xa6:/*SEP*/break;
		case 0xa7: throw 1; // !illA7
		// BX
		case 0xb6:/*ECK*/break;
		case 0xb7: throw 1; // !illB7
		// CX
		case 0xc6:/*DCK*/break;
		case 0xc7: throw 1; // !illC7
		// DX
		case 0xd7:/*SAR*/break;
		// EX
		case 0xe6:/*LAR*/break;
		case 0xe7: throw 1; // !illE7
		// FX
		case 0xf6:/*LIO/SIO*/break;
		case 0xf7:/*MVL*/break;
		}
	}
}

class CPU6 {

	// TODO backplane
	mem: MemAccess;
	page_ram: Uint8Array;
	_map: number = 0;
	constructor(m: MemAccess, page: Uint8Array) {
		this.mem = m;
		this.page_ram = page;
	}
	get map():number {
		return this._map >> 5;
	}
	set map(v:number) {
		this._map = v << 5;
	}
	fetch(address:number):number {
		return this.mem.readmeta(address) & 255;
	}
	phys(address:number) {
		let page = this.page_ram[this._map | (address >> 11)] & 0x7f;
		return (page << 11) | (address & 2047)
	}
	disassembly(address:number, ret:DisAsmResult):void {
		const DREF_L = ['','[','('][name_conv];
		const DREF_R = ['',']',')'][name_conv];
		const DDREF_L = ['*','[[','(('][name_conv];
		const DDREF_R = ['',']]','))'][name_conv];
		let vpc = address;
		let page = address >> 11;
		let ppc = this.phys(vpc++);
		ret.pa = ppc;
		ret.pg = page;
		let meta = this.mem.readmeta(ppc);
		if ((meta & MEMSTAT.IO) != 0) {
			ret.hb = '??';
			ret.asc = '';
			ret.l = 1;
			return;
		}
		let op = meta & 255;
		let is_brk = (meta & MEMSTAT.ALL_BRK) != 0;
		let datah:number[] = [];

		let opcs = oplist[op];
		let anpre = '';
		let anstr = '';
		let opname: string;
		let opsfx = '';
		if(typeof opcs.n != 'string') {
			if(opcs.n.length > name_conv) {
				opname = opcs.n[name_conv];
			} else {
				opname = opcs.n[0];
			}
		} else {
			opname = opcs.n;
		}
		let anno_data = '';
		datah.push(op);
		function check_anno(a:number) {
			let anno = annotation_data.get(a);
			if (anno) {
				if (anno.pre != null) {
					for (let com of anno.pre) {
						anpre += `<div class="cmm">${com}</div>`;
					}
				}
				if (anno.comm != null) {
					for (let com of anno.comm) {
						anstr += `<div class="cmm">${com}</div>`;
					}
				}
				if (anno.label && anno.label.length > 0) {
					anpre += `<div class="sym">${anno.label[0]}:</div>`;
				}
				if (anno.data != null) {
					anno_data = anno.data;
					//throw {is_data:true, data_class:anno.data};
				}
			}
		}
		
		function is_hiascii(v:number):boolean {
			return (v > 0x9f && v < 0xff) || (v == 0x89) || (v == 0x8a) || (v == 0x8c) || (v == 0x8d);
		}
		function ascenc(v:number):string {
			if (v >= 0xa0 && v < 0xff) {
				return String.fromCodePoint(v & 0x7f);
			} else if (v == 0x89) {
				return "\u2192";
			} else if (v == 0x8a) {
				return "\u2193";
			} else if (v == 0x8c) {
				return "\u21ca";
			} else if (v == 0x8d) {
				return "\u21b5";
			} else {
				return "_";
			}
		}
		function addrrefw(a:number):string {
			a &= 0xffff;
			if (mmwlist.has(a)) {
				return `${hexlist(a, 4)} <${mmwlist.get(a)}>`;
			} else {
				let anno = annotation_data.get(a);
				if (anno && anno.label && anno.label.length > 0) {
					return `${hexlist(a, 4)} <${anno.label[0]}>`;
				}
				return hexlist(a, 4);
			}
		}
		function addrref(a:number):string {
			a &= 0xffff;
			if (mmiolist.has(a)) {
				return `${hexlist(a, 4)} <${mmiolist.get(a)}>`;
			} else {
				let anno = annotation_data.get(a);
				if (anno && anno.label && anno.label.length > 0) {
					return `${hexlist(a, 4)} <${anno.label[0]}>`;
				}
				return hexlist(a, 4);
			}
		}
		let astr = ascenc(op);
		let dfetch = ()=> {
			let ppc = this.phys(vpc++);
			check_anno(ppc);
			let emeta = this.mem.readmeta(ppc);
			if((meta & MEMSTAT.ALL_BRK) != 0) is_brk = true;
			let rv = emeta & 255;
			datah.push(rv)
			astr += ascenc(rv);
			return rv;
		}
		let psstr = '';
		let pstr = '';

		check_anno(address);
		if (anno_data == 'byte') {
			for(let i = 0; i < datah.length; i++) {
				//@ts-ignore
				datah[i] = hex(datah[i]);
			}
			ret.hb = datah.join(' ');
			ret.asc = astr;
			ret.ins = '.byte';
			ret.par = hexlist(op, 2);
			ret.l = vpc - address;
			if (anpre.length > 0) ret.pre = anpre;
			if (anstr.length > 0) ret.post = anstr;
			return;
		} else if (anno_data == 'word') {
			let vl = dfetch();
			for(let i = 0; i < datah.length; i++) {
				//@ts-ignore
				datah[i] = hex(datah[i]);
			}
			ret.hb = datah.join(' ');
			ret.asc = astr;
			ret.ins = '.word';
			ret.par = hexlist((op << 8) | vl, 4);
			ret.l = vpc - address;
			if (anpre.length > 0) ret.pre = anpre;
			if (anstr.length > 0) ret.post = anstr;
			return;
		}
		let vstr = '';
		if (op == 0 && this.fetch(this.phys(vpc)) > 3) { // TODO does not cover long strings!
			let vstart = vpc + 1;
			let vpcs = vstart;
			let pre = this.fetch(this.phys(vpc));
			//check_anno(vpc);
			//check_anno(vpcs);
			let f = this.fetch(this.phys(vpcs++));
			let slen = 0;
			let nonspace = false;
			while(is_hiascii(f)) {
				slen = (vpcs - vstart);
				if (slen > 160) break;
				if (f == 0x89) {
					vstr += '\\t';
				} else if (f == 0x8a) {
					vstr += '\\n';
				} else if (f == 0x8d) {
					vstr += '\\r';
				} else {
					vstr += ascenc(f);
					if (f != 0xa0) nonspace = true;
				}
				if (pre == slen && slen >= 2 && nonspace) {
					// pascal string
					ret.hb = '';
					ret.asc = '';
					ret.ins = '.npstringhi ';
					ret.ic = 'pstr';
					ret.par = vstr;
					ret.l = vpcs - address;
					if (anpre.length > 0) {
						ret.pre = anpre;
					}
					if (anstr.length > 0) {
						ret.post = anstr;
					}
					return;
				}
				//check_anno(vpcs);
				f = this.fetch(this.phys(vpcs++));
			}
			slen = (vpcs - vpc);
			if (pre == slen && slen >= 2 && nonspace) {
				// pascal string
				vpcs--;
				ret.hb = '';
				ret.asc = '';
				ret.ins = '.npstringhi ';
				ret.par = vstr;
				ret.ic = "pstr";
				ret.l = vpcs - address;
				if (anpre.length > 0) {
					ret.pre = anpre;
				}
				if (anstr.length > 0) {
					ret.post = anstr;
				}
				return;
			}
			if (!nonspace) {
				vstr = '';
			}
		} else if (is_hiascii(op)) {
			let vpcs = vpc - 1;
			let pre = (this.fetch(this.phys(vpc - 3)) << 8) | this.fetch(this.phys(vpc - 2));
			let f = this.fetch(this.phys(vpcs++));
			let slen = 0;
			vstr = '';
			let nonspace = false;
			while(is_hiascii(f)) {
				if ((vpcs - vpc) > 160) break;
				if (f == 0x89) {
					vstr += '\\t';
				} else if (f == 0x8a) {
					vstr += '\\n';
				} else if (f == 0x8d) {
					vstr += '\\r';
				} else {
					vstr += ascenc(f);
					if (f != 0xa0) nonspace = true;
				}
				slen = (vpcs - vpc);
				if (pre == slen && slen >= 2 && nonspace) {
					// pascal string
					ret.hb = ''; ret.asc = ''; ret.ic = "pstr";
					ret.ins = '.pstringhi '; ret.par = vstr;
					ret.l = vpcs - address;
					if (anpre.length > 0) {
						ret.pre = anpre;
					}
					if (anstr.length > 0) {
						ret.post = anstr;
					}
					return;
				}
				//check_anno(vpcs);
				f = this.fetch(this.phys(vpcs++));
			}
			slen = (vpcs - vpc);
			if (pre == slen && slen >= 2 && nonspace) {
				// pascal string
				vpcs--;
				ret.hb = ''; ret.asc = ''; ret.ic = "pstr";
				ret.ins = '.pstringhi '; ret.par = vstr;
				ret.l = vpcs - address;
				if (anpre.length > 0) {
					ret.pre = anpre;
				}
				if (anstr.length > 0) {
					ret.post = anstr;
				}
				return;
			} else if(f == 0 && slen > 3 && nonspace) {
				// zstring/cstring
				ret.hb = ''; ret.asc = ''; ret.ic = "zstr";
				ret.ins = '.zstringhi '; ret.par = vstr;
				ret.l = vpcs - address;
				if (anpre.length > 0) {
					ret.pre = anpre;
				}
				if (anstr.length > 0) {
					ret.post = anstr;
				}
				return;
			}
			if (!nonspace) {
				vstr = '';
			}
		}
		let r = 1;
		if (opcs.l !== undefined) {
			while(r < opcs.l) {
				dfetch();
				r++;
			}
		}
		let rsh = 0;
		if (opcs.w == TXS.W || opcs.w == TXS.F) {
			rsh = 1;
		}
		let regdst = 0;
		let regsrc = 0;
		const litpfx = LIT_PFX[name_conv];
		const regconv = regname[name_conv == NAMECON.MEI ? 1:0];
		const is_cent = (name_conv == NAMECON.CENT);
		function decode_mode(mode:OPM, is_write:boolean, regm?:REG):string {
			let disp;
			let rvc:number;
			let advh:number, advl:number, adr:number;
			switch(mode) {
			case OPM.IMPL: return '';
			case OPM.IMM:
				opsfx = '=';
				if (opcs.w == TXS.B) {
					return (is_write?litpfx.sw:litpfx.sr) + hexlistc(sbyte(dfetch()));
				}
				if (opcs.w == TXS.W) {
					let hi = dfetch();
					let lo = dfetch();
					return (is_write?litpfx.sw:litpfx.sr) + hexlistc(sword((hi << 8) | lo), 4);
				}
				return (is_write?litpfx.sw:litpfx.sr) + '<invalid>';
			case OPM.DIR:
				opsfx = '/';
				advh = dfetch();
				advl = dfetch();
				adr = (advh << 8) | advl;
				if(is_cent) {
					return hexlist(adr,4);
				}
				switch (opcs.w) {
				case TXS.F: return `:${addrref(adr)}`;
				case TXS.B: return `${DREF_L}${addrref(adr)}${DREF_R}`;
				case TXS.W: return `${DREF_L}${addrrefw(adr)}${DREF_R}`;
				}
				return '<#invalid>';
			case OPM.IND:
				opsfx = '$';
				advh = dfetch();
				advl = dfetch();
				adr = (advh << 8) | advl;
				if(is_cent) {
					return hexlist(adr,4);
				}
				if (opcs.w == TXS.F) {
					return ':' + DREF_L + addrref(adr) + DREF_R;
				}
				return DDREF_L + addrref(adr) + DDREF_R;
			case OPM.PCO:
				disp = sbyte(dfetch());
				if(is_cent) {
					return hexlist((vpc + disp) & 65535,4);
				}
				if (opcs.w == TXS.F) {
					return `PC${hexlistp(disp)} \u21d2 ${addrrefw(vpc + disp)}`;
				} else if (opcs.w == TXS.W) {
					return `${DREF_L} PC${hexlistp(disp)} \u21d2 ${addrrefw(vpc + disp)} ${DREF_R}`;
				}
				return `${DREF_L} PC${hexlistp(disp)} \u21d2 ${addrref(vpc + disp)} ${DREF_R}`;
			case OPM.IPO:
				opsfx = '*';
				disp = sbyte(dfetch());
				if(is_cent) {
					return hexlist((vpc + disp) & 65535,4);
				}
				if (opcs.w == TXS.F) {
					return `${DREF_L} PC${hexlistp(disp)} \u21d2 ${addrrefw(vpc + disp)} ${DREF_R}`;
				} else if (opcs.w == TXS.W) {
					return `${DDREF_L} PC${hexlistp(disp)} \u21d2 ${addrrefw(vpc + disp)} ${DDREF_R}`;
				}
				return `${DDREF_L} PC${hexlistp(disp)} \u21d2 ${addrref(vpc + disp)} ${DDREF_R}`;
			case OPM.MOD: {
				opsfx = '+';
				rvc = dfetch();
				const modv = rvc & 15;
				const incdec = rvc & 3;
				const reg = rvc >> 4;
				disp = 0;
				let res = regconv[1][reg];
				if((reg & 1) != 0) {
					return '<invalid>' + res;
				}
				
				if (incdec == 2) {
					if(name_conv == NAMECON.MEI)
						res = '--' + res;
					else
						res += '-';
				} else if (incdec == 1) {
					if(name_conv == NAMECON.MEI)
						res += '++';
					else
						res += '+';
				}
				if ((modv & 8) > 0) {
					disp = dfetch();
					if(name_conv == NAMECON.MEI) {
						res = `${res}${hexlistp(sbyte(disp))}`;
					} else {
						res = `${res},${hexlistcrp(sbyte(disp))}`;
					}
				}
				if(name_conv == NAMECON.MEI) {
					res = `${DREF_L}${res}${DREF_R}`;
					if ((modv & 4) > 0) {
						res = `${DREF_L}${res}${DREF_R}`;
					}
				} else if ((modv & 4) > 0) {
					res = '*' + res;
				}
				return res;
			}
			case OPM.RR:
			case OPM.RRX:
			case OPM.RRS:
			case OPM.RRSR: {
				if(!is_write) throw new Error('RR* in source operand, should be in dest');
				rvc = dfetch();
				regsrc = (rvc >> 4);
				regdst = (rvc & 15);
				const rrmode = ((regsrc & 1) << 1) | (regdst & 1);
				let strdst:string;
				if(opcs.w == TXS.W) {
					regsrc = regsrc & 14;
					regdst = regdst & 14;
					if (!is_cent && mode == OPM.RRX && (regdst != (regdst|2)))
						strdst = `${regconv[1][regdst]}:${regconv[1][regdst|2]}`;
					else
						strdst = regconv[1][regdst];
				} else {
					strdst = regconv[0][regdst];
				}
				if (opcs.w == TXS.W && rrmode > 0) {
					// nibbles mismatch
					// example with SUB:
					// 51 12 hh ll: (mode 2)
					//    ^ 1:odd src A, 2:even dst B
					//    B = hhll - A  ; uses literal
					// 51 03 hh ll: (mode 1)
					//    ^ 0:even src A, 3:odd dst B
					//    B = [hhll] - A
					// 51 13 hh ll: (mode 3)
					//    ^ 1:odd src A, 3:odd dst B
					//    B = [hhll + A] - B
					advh = dfetch();
					advl = dfetch();
					adr = (advh << 8) | advl;
					if(is_cent) {
						if (mode == OPM.RRSR) { // only STR
							if (rrmode == 2) {
								// MSN odd
								opsfx = litpfx.iw;
								return `${hexlistc(adr, 4)},${strdst}`;
							} else if (rrmode == 1) {
								// MSN even
								opsfx = '/';
								return `${hexlist(adr,4)},${strdst}`;
							}
							opsfx = '-';
							return `${regconv[1][regsrc]},${hexlistc(sword(adr),4)},${strdst}`;
						}
						if (mode == OPM.RRS) { // only XFR
							if (rrmode == 2) {
								// MSN odd
								opsfx = litpfx.ir;
								return `${hexlistc(adr, 4)},${strdst}`;
							} else if (rrmode == 1) {
								// MSN even
								opsfx = '/';
								return `${hexlist(adr, 4)},${strdst}`;
							} // else both odd
							opsfx = '-';
							return `${regconv[1][regsrc]},${hexlistc(adr, 4)},${strdst}`;
						}
						if (rrmode == 2) {
							// MSN odd
							opsfx = litpfx.ir;
							if(regsrc == regdst)
								return `${hexlistc(adr, 4)},${strdst}`;
							return `${hexlistc(adr, 4)},${regconv[1][regsrc]},${strdst}`;
						} else if (rrmode == 1) {
							// MSN even
							opsfx = '/';
							if(regsrc == regdst)
								return `${hexlist(adr, 4)},${strdst}`;
							return `${hexlist(adr, 4)},${regconv[1][regsrc]},${strdst}`;
						} // else both odd
						opsfx = '-';
						return `${regconv[1][regsrc]},${hexlistc(adr, 4)},${strdst}`;
					} else {
						if (mode == OPM.RRSR) { // only STR
							if (rrmode == 2) {
								// MSN odd
								return `${strdst}, ${litpfx.iw}${hexlist(adr, 4)}`;
							} else if (rrmode == 1) {
								// MSN even
								return `${strdst}, ${DREF_L}${addrrefw(sword(adr))}${DREF_R}`;
							} // else both odd
							return `${strdst}, ${DREF_L}${regconv[1][regsrc]}${hexlistp(sword(adr))}${DREF_R}`;
						} else if (mode == OPM.RRS) { // only XFR
							if (rrmode == 2) {
								// MSN odd
								return `${litpfx.sr}${hexlist(adr, 4)}, ${strdst}`;
							} else if (rrmode == 1) {
								// MSN even
								return `${DREF_L}${addrrefw(sword(adr))}${DREF_R}, ${strdst}`;
							} // else both odd
							return `${DREF_L}${regconv[1][regsrc]}${hexlistp(sword(adr))}${DREF_R}, ${strdst}`;
						}
						if (rrmode == 2) {
							// MSN odd
							return `${litpfx.ir}${hexlist(adr, 4)}, ${regconv[1][regsrc]} \u21d2 ${strdst}`;
						} else if (rrmode == 1) {
							// MSN even
							return `${DREF_L}${addrrefw(sword(adr))}${DREF_R}, ${regconv[1][regsrc]} \u21d2 ${strdst}`;
						} // else both odd
						return `${DREF_L}${regconv[1][regsrc]}${hexlistp(sword(adr))}${DREF_R}, ${regconv[1][regdst]} \u21d2 ${strdst}`;
					}
				} else {
					if(is_cent) return `${regconv[rsh][regsrc]},${regconv[rsh][regdst]}`;
					return `${regconv[rsh][regsrc]}, ${regconv[rsh][regdst]}`;
				}
			}
			case OPM.RC: {
				if(!is_write) throw new Error('RC in source operand, should be in dest');
				rvc = dfetch();
				regdst = rvc >> 4;
				regsrc = rvc & 15;
				let i_spec = '';
				let i_val = 0;
				if (opcs.i !== undefined) {
					i_val = opcs.i;
				}
				if (is_cent && (regsrc != 0)) {
					i_spec = `,${regsrc + i_val}`;
				} else if ((regsrc != 0) || (name_conv == NAMECON.MEI)) {
					i_spec = `, ${regsrc + i_val}`;
				}
				if ((opcs.w == TXS.W) && ((regdst & 1) != 0)) {
					// some nmemonics are different when accessing memory
					if(opcs.nm != undefined) {
						if(typeof opcs.nm != 'string') {
							if(opcs.nm.length > name_conv) {
								opname = opcs.nm[name_conv];
							} else {
								opname = opcs.nm[0];
							}
						} else {
							opname = opcs.nm;
						}
					}
					advh = dfetch();
					advl = dfetch();
					adr = (advh << 8) | advl;
					regdst = regdst & 14;
					if(is_cent) {
						if(regdst == 0) {
							opsfx = '/'
							return `${hexlist(adr,4)}${i_spec}`;
						}
						opsfx = '-'
						return `${regconv[1][regdst]},${hexlistcrp(sword(adr),4)}${i_spec}`;
					}
					if(regdst == 0) return `${DREF_L}${addrref(adr)}${DREF_R}${i_spec}`;
					return `${DREF_L}${regconv[1][regdst]}${hexlistp(sword(adr),4)}${DREF_R}${i_spec}`;
				} else {
					return `${regconv[rsh][regdst]}${i_spec}`;
				}
			}
			case OPM.IMPL_R:
				if (name_conv != NAMECON.MEI) {
					return '';
				}
				if (regm != undefined) {
					return regconv[rsh][regm];
				} else {
					return '!R';
				}
			case OPM.IMPL_R_DIR:
				if (name_conv != NAMECON.MEI) {
					return '';
				}
				if (regm != undefined) {
					return `${DREF_L}${regconv[1][regm]}${DREF_R}`;
				} else {
					return `${DREF_L}!R${DREF_R}`;
				}
			}
		}
		let exm_data = 0;
		let exm_reg = false;
		function decode_exmode(mode:number, is_dest:boolean, par_len?:number):string {
			let v0:number;
			if(mode == 2 && exm_reg) v0 = exm_data;
			else v0 = dfetch();
			let regh = v0>>4;
			let regl = v0&15;
			switch(mode) {
			case 0:
				let al = dfetch();
				if(is_cent) return `/${hexlist((v0<<8)|al,4)}`;
				return `${DREF_L}${hexlist((v0<<8)|al,4)}${DREF_R}`;
			case 1:
			{
				let litv = dfetch();
				if((regl&1)!=0) {
					throw 0;
				}
				if((regh & 1) != 0) {
					litv = sword((litv << 8) | dfetch());
					regh &= 14;
				} else {
					litv = sbyte(litv);
				}
				let rh = regconv[1][regh];
				let rl = regconv[1][regl];
				if(is_cent) return `-${rh}${(regl != 0) ? '*'+rl:''}${hexlistcp(litv)}`;
				return `${DREF_L}${rh}${(regl != 0) ? ' + '+rl:''}${hexlistp(litv)}${DREF_R}`;
			}
			case 2:
			{
				let reg_id;
				if(is_dest) {
					if((regl&1)!=0) {
						throw 0;
					}
					reg_id = regconv[1][regl];
				} else {
					if((regh&1)!=0) {
						throw 0;
					}
					reg_id = regconv[1][regh];
					exm_data = v0;
					exm_reg = true;
				}
				if(is_cent) return `-${reg_id}`;
					return `${DREF_L}${reg_id}${DREF_R}`;
			}
			case 3:
				let lits = hex(v0);
				if(par_len != undefined) {
					while(par_len > 1) {
						lits += hex(dfetch());
						par_len -= 1;
					}
				}
				return litpfx.ir+hexcs(lits);
			}
			throw 0;
		}
		if (opcs.ms != null) {
			pstr = decode_mode(opcs.ms, false, opcs.sr);
			psstr = decode_mode(opcs.md, true, opcs.dr);
		} else {
			pstr = decode_mode(opcs.md, true, opcs.dr);
		}

		extenc:switch(opcs.x) {
		case undefined:
			break;
		case OPL_EXT.MPUSH:
		case OPL_EXT.MPOP: {
			let rstart = regdst;
			let rcount = regsrc+1;
			let com;
			if((rstart & 1) == 0 && rcount > 1) {
				com = regconv[1][rstart];
				rstart += 2;
				rcount -= 2;
			} else {
				com = regconv[0][rstart++];
				rcount -= 1;
			}
			while(rcount > 1) {
				com += ',' + regconv[1][rstart];
				rstart+=2;
				if(rstart > 15) rstart -= 16;
				rcount-=2;
			}
			if(rcount > 0) {
				com += ',' + regconv[0][rstart];
			}
			if(!is_cent) pstr = com; else anstr = com;
			break;
		}
		case OPL_EXT.PAGE: {
			let rvc = dfetch();
			let mod1 = (rvc >> 2) & 3;
			let mod2 = rvc & 3;
			let sel = (rvc >> 4);
			const opr1 = (opcs.xd[0] as string[])[sel];
			const ncon = opcs.xd[name_conv == NAMECON.MEI ? 2 : 1] as string[];
			if(sel < ncon.length) {
				opname += ncon[sel];
			} else {
				opname += hex(sel, 1);
			}
			if(opr1 == undefined) {
				pstr='<#invalid>';
			} else try {
				if(is_cent) {
					if(mod1 == 3) {
						let v = dfetch();
						pstr = `=${hexlist(v,2)}`;
					} else {
						pstr = `${decode_exmode(mod1, false)}`;
					}
				} else if(mod1 == 3) {
					let v = dfetch();
					pstr = `m=#${v&7},${opr1}=#${v>>3}`;
				} else {
					pstr = `(m,${opr1})=${decode_exmode(mod1, false)}`;
				}
				if(mod2 == 3) {
					pstr = '<#invalid>';
				} else {
					psstr = decode_exmode(mod2, true);
				}
			} catch(e) {
				pstr = '<#invalid>';
			}
			break; }
		case OPL_EXT.DMA: {
			let rvc = dfetch();
			let reg = (rvc >> 4);
			let sel = (rvc & 15);
			const ncon = opcs.xd[name_conv] as string[];
			if(sel < ncon.length) {
				opname += ncon[sel];
			} else {
				opname += hex(sel, 1);
			}
			switch(sel) {
			case 0: pstr = regconv[1][reg]; break;
			case 1: psstr = regconv[1][reg]; break;
			case 2: pstr = regconv[1][reg]; break;
			case 3: psstr = regconv[1][reg]; break;
			case 4: psstr = litpfx.ir + hexlistc(reg,1); break;
			case 5: psstr = regconv[0][reg|1]; break;
			case 6: break;
			case 7: break;
			case 8: psstr = regconv[0][reg|1]; break;
			case 9: pstr = regconv[0][reg|1]; break;
			}
			break; }
		case OPL_EXT.BIG: {
			let osb = dfetch();
			let rvc = dfetch();
			const oss = (osb>>4)+1;
			const osd = (osb&15)+1;
			const mod1 = (rvc >> 2) & 3;
			const mod2 = rvc & 3;
			const sel = (rvc >> 4);
			const ncon = opcs.xd[name_conv == NAMECON.MEI ? 1 : 0] as string[];
			if(sel < ncon.length) {
				opname += ncon[sel];
			} else {
				opname += hex(sel, 1);
				pstr='<invalid-bigop>';
				break;
			}
			try {
				if(is_cent) {
					pstr = `${decode_exmode(mod1, false, oss)}(${oss})`;
					if(mod2 == 3 && sel < 8) {
						psstr = `<invalid-dest>(${osd})`;
					} else {
						psstr = `${decode_exmode(mod2, true)}(${osd})`;
					}
				} else {
					pstr = `${oss}/${decode_exmode(mod1, false, oss)}`;
					if(mod2 == 3 && sel < 8) {
						psstr = `${osd}/<invalid-dest>`;
					} else {
						psstr = `${osd}/${decode_exmode(mod2, true)}`;
					}
				}
			} catch(e) {
				pstr = '<invalid-reg>';
			}
			break;
		}
		case OPL_EXT.MEM: {
			const rvc = dfetch();
			const mod1 = (rvc >> 2) & 3;
			const mod2 = rvc & 3;
			const sel = (rvc >> 4);
			const ncon = opcs.xd[name_conv == NAMECON.MEI ? 2:1];
			if(sel < ncon.length) {
				opname += ncon[sel];
			} else {
				opname += hex(sel, 1);
				pstr = '<invalid-memop>';
				break;
			}
			const nci = opcs.xd[0][sel];
			// 0: none
			// 1: len=#FF, term=AH
			// 2: len=AL, term=AH
			// 3: len=AL
			// 4: len=AL
			// 5: len=AL
			// 6: len=AL
			// 7: len=AL
			// 8: len=AL
			// 9: srclen=1, dstlen=AL
			let lvlen = -1;
			if(opcs.sr !== undefined) {
				if(name_conv == NAMECON.MEI) {
					if((nci & 2) != 0) {
						pstr = 'l=AL, ';
					}
					if((nci & 1) != 0) {
						pstr += 't=AH, ';
					}
				}
				if(sel != 9 && (mod1 == 3) && ((nci & 4) != 0) && lvlen == -1) {
					pstr += '<!unknown length>';
				}
			} else {
				if((nci & 2) != 0) {
					lvlen = dfetch()+1;
					if(name_conv == NAMECON.MEI) {
						pstr = `l=#${lvlen}, `;
					} else if(is_cent) {
						pstr = `(${lvlen}`;
					} else {
						pstr = `${lvlen}, `;
					}
				}
				if((nci & 1) != 0) {
					const lvt = dfetch();
					if(name_conv == NAMECON.MEI) {
						pstr += `${'t=#'}${hexlist(lvt)}, `;
					} else if(is_cent && ((nci & 2) != 0)) {
						pstr += `,${hexlist(lvt)})`;
					} else if(is_cent) {
						pstr += `(${hexlist(lvt)})`;
					} else {
						pstr += `${hexlist(lvt)}, `;
					}
				} else if((nci & 2) != 0 && is_cent) pstr += ')';
			}
			try {
				if((mod2 == 3) || ((mod1 == 3) && ((nci & 4) == 0))) {
					pstr = '<#invalid-dest>';
				} else {
					if(sel == 9) lvlen = 1;
					pstr += decode_exmode(mod1, false, lvlen!=-1?lvlen:1);
					psstr = decode_exmode(mod2, true);
				}
			} catch(e) {
				pstr = '<#invalid-reg>';
			}
			break;
		}
		case OPL_EXT.RII: { // LAR/SAR
			const rvc = dfetch();
			const level = rvc >> 4;
			if(opcs.i == 1)
				pstr = `${level},${regconv[1][rvc & 15]}`;
			else psstr = `${level},${regconv[1][rvc & 15]}`;
			break;
		}
		case OPL_EXT.XIO: {
			const rvc = dfetch();
			const rvd = sbyte(dfetch());
			const regh = (rvc>>4);
			const regl = rvc&14;
			// F6 JK D8
			// this is a system mode instruction, traps from user mode
			// uses low bits from J,K
			// D8 is signed 8 bit displacement
			// EA = (KW + D8) | 0x3F000 // always I/O area
			// 0,0: LIO  JW = [EA] // always reads I/O area
			// 1,0: LIOB JL = [EA] // always reads I/O area
			// 0,1: SIO  EA = [JW] // always writes I/O area
			// 1,1: SIOB EA = [JL] // always writes I/O area
			pstr = `${DREF_L}${regconv[1][regl]}${hexlistcp(rvd)}${DREF_R}`;
			const xiobyte = (rvc & 16) != 0
			if((rvc & 1) != 0) {
				opname = name_conv == NAMECON.MEI ? 'S.IO':'SIO';
				if(xiobyte && (name_conv != NAMECON.MEI)) opname += 'B';
				psstr = pstr;
				pstr = regconv[xiobyte ? 0:1][regh];
			} else {
				if(name_conv == NAMECON.MEI) opname = 'L.IO';
				if(xiobyte && (name_conv != NAMECON.MEI)) opname += 'B';
				if(is_cent) {
					psstr = pstr;
					pstr = regconv[xiobyte ? 0:1][regh];
				} else psstr = regconv[xiobyte ? 0:1][regh];
			}
			break;
		}
		default: opname += '<.unhandled>';
		}
		if (pstr.length > 0 && psstr.length > 0) {
			if(is_cent) pstr += ',';
			else pstr += ', ';
		}
		for(let i = 0; i < datah.length; i++) {
			//@ts-ignore
			datah[i] = hex(datah[i]);
		}

		ret.hb = (datah.join(datah.length > 5?'':' ') + ' ').padEnd(20);
		ret.asc = datah.length > 5?'':astr;
		if(is_cent) {
			ret.ins = opname + opsfx;
		} else { ret.ins = opname; }
		if(pstr.length > 0 || psstr.length > 0) {
			ret.ins = ret.ins.padEnd(5);
			ret.par = ` ${pstr}${psstr}`;
		}
		ret.is_brk = is_brk;
		ret.l = vpc - address;

		if (anpre.length > 0) {
			ret.pre = anpre;
		}
		if (anstr.length > 0) {
			ret.par = (ret.par + ' ').padEnd(12);
			ret.post = anstr;
		} else if (vstr.length > 5) {
			ret.post = `; "${vstr}"`;
		}
	}
}

const nullrom = new NullROM();
const diag1 = new ROM2k();
const diag2 = new ROM2k();
const diag3 = new ROM2k();
const diag4 = new ROM2k();
loadbin(diag1, diag.f1);
loadbin(diag2, diag.f2);
loadbin(diag3, diag.f3);
loadbin(diag4, diag.f4);
const mmio_mux = new MMIOMux();
const mem0 = new SysMem();
const mem1 = new SysMem();
const bpl_rom_fc = new ROM512();
const mmio_0 = new MMIOMulti();
const mmio_1 = new MMIOMulti();
const mmio_7 = new MMIOMulti();
const mmio_8 = new MMIOMulti();
const prt_0 = new MockPrinter();
const dsk2_0 = new DSK2();
const mmio_t = new MMIOTrace();
const test_tape = new MockTape9Tk();
const main_ffc = new FinchFloppyControl();
const test_cmd = new TestCMD();
loadbin(bpl_rom_fc, bpl_romc, {invert:true, remap:[0,1,2,3,4,8,5,6,7]});
run_hw.push(dsk2_0);
bpl.configio(0, mmio_mux);
bpl.configio(1, dsk2_0);
mmio_0.adddev(0xe0, 0x10, prt_0);
mmio_1.adddev(0, 0x20, cx_diag0);
mmio_1.adddev(0x40, 0x10, dsk2_0);
mmio_7.adddev(0, 16, test_tape);
mmio_7.adddev(0x10, 240, mmio_t);
bpl.configio(2, main_ffc);
mmio_8.adddev(0, 2, main_ffc);
run_hshw.push(main_ffc);
run_hshw.push(test_cmd);
mmio_8.adddev(0x08, 2, test_cmd);
mcsim.dma_register(dsk2_0);
mcsim.dma_register(main_ffc);
mcsim.dma_register(test_cmd);
function setupmemory() {
	bpl.configmemory(0x0000, mem0, 0x20000);
	bpl.configmemory(0x20000, mem1, 0x1f000);
	bpl.configmemory(0x3f000, mmio_0, 256);
	bpl.configmemory(0x3f100, mmio_1, 256);
	bpl.configmemory(0x3f200, mmio_mux, 256);
	bpl.configmemory(0x3f700, mmio_7, 256);
	bpl.configmemory(0x3f800, mmio_8, 256);
	bpl.configmemory(0x3fc00, bpl_rom_fc, 512);
	if (in_diagins.checked) {
		bpl.clearmemory(0x8000, 0x4000);
		bpl.configmemory(0x8000, diag1, 2048);
		bpl.configmemory(0x8800, diag2, 2048);
		bpl.configmemory(0x9000, diag3, 2048);
		bpl.configmemory(0x9800, diag4, 2048);
		bpl.configmemory(0xa000, nullrom, 2048);
		bpl.configmemory(0xa800, nullrom, 2048);
		bpl.configmemory(0xb000, nullrom, 2048);
		bpl.configmemory(0xb800, new RAM2k(), 2048);
	}
}
function serial_ui_change(ev: Event) {
	update_serial_config();
}
function init_serial_ui() {
	// serial config will reset to the standard config for now
	// (not persist)
	for(let i = 0; i < 3; i++) {
		com_conf.crt[i].value = '0';
		com_conf.crt[i].addEventListener('change', serial_ui_change);
	}
	for(let i = 0; i < 4; i++) {
		com_conf.mux[i].value = '0';
		com_conf.mux[i].addEventListener('change', serial_ui_change);
	}
}
function update_serial_ui() {
	for(let x = 0; x < 4; x++) {
		const c_ext = com_conf.ext[x];
		const sel_elem = c_ext.sel;
		const dev_count = com_conf.net.length;
		sel_elem.disabled = dev_count < 1 || !com_conf.have_net;
		if(dev_count < c_ext.opts.length) {
			const limit = (dev_count > 2) ? dev_count : 2;
			for(let i = c_ext.opts.length; i > limit;) {
				i--;
				const c_opt = c_ext.opts[i];
				if(sel_elem.value == c_opt.value) sel_elem.value = '0';
				sel_elem.removeChild(c_opt);
			}
			c_ext.opts.length = limit;
		}
		for(let i = 0; i < dev_count; i++) {
			const c_com = com_conf.net[i];
			let c_opt = c_ext.opts[i];
			if(!com_conf.have_net) c_com.conn = null;
			if(c_opt == undefined) {
				c_opt = document.createElement('option');
				c_opt.value = c_com.dev_index.toString();
				c_opt.innerText = c_com.name;
				c_opt.addEventListener('change', serial_ui_change);
				sel_elem.appendChild(c_opt);
				c_ext.opts.push(c_opt);
			} else {
				c_opt.innerText = c_com.name;
			}
		}
	}
}
function update_serial_config() {
	for(let i = 0; i < com_conf.net.length; i++) {
		const ext_port = com_conf.net[i];
		ext_port.dev_count = 0;
	}
	for(let i = 0; i < 3; i++) {
		let ext_id = parseInt(com_conf.ext[i].sel.value);
		let ext_avail = false;
		let ext_port:NetSerial | undefined;
		if(!isNaN(ext_id)) {
			ext_port = com_conf.net[ext_id];
			if(ext_port) ext_avail =
				(ext_port.conn != null) && (ext_port.dev_count == 0);
		}
		const mux_port = mmio_mux.muxports[i];
		const crt_port = cx_crt[i];
		const mux_to_crt = !ext_avail || (
			(com_conf.mux[i].value == '0') &&
			(com_conf.crt[i].value == '0') );
		let mux_target: CharDevice | undefined;
		let crt_target: CharDevice | undefined;
		let ext_target: CharDevice | undefined;
		if(mux_to_crt) {
			mux_target = crt_port;
			crt_target = mux_port;
		} else if(ext_port) {
			if(com_conf.mux[i].value != '0') {
				mux_target = ext_port;
				ext_target = mux_port;
			} else if(com_conf.crt[i].value != '0') {
				crt_target = ext_port;
				ext_target = crt_port;
			}
		}
		if(mux_target != mux_port.get_dev()) mux_port.bind_dev(mux_target);
		if(crt_target != crt_port.get_dev()) crt_port.bind_dev(crt_target);
		if(ext_port && ext_target) {
			ext_port.dev_count++;
			if(ext_port.get_dev() != ext_target) ext_port.bind_dev(ext_target);
		}
	}
	if(com_conf.mux[3].value == '0') {
		mmio_mux.muxports[3].bind_dev(prt_0);
	} else {
		let ext_id = parseInt(com_conf.ext[3].sel.value);
		let ext_avail = false;
		let ext_port:NetSerial | undefined;
		if(!isNaN(ext_id)) {
			ext_port = com_conf.net[ext_id];
			if(ext_port) ext_avail =
				(ext_port.conn != null) && (ext_port.dev_count == 0);
		}
		const mux_port = mmio_mux.muxports[3];
		let mux_target: CharDevice | undefined;
		if(!ext_avail) {
			mux_target = prt_0;
		} else if(ext_port) {
			mux_target = ext_port;
			ext_port.dev_count++;
			if(ext_port.get_dev() != mux_port) ext_port.bind_dev(mux_port);
		}
		if(mux_target != mux_port.get_dev()) mux_port.bind_dev(mux_target);
	}
	for(let i = 0; i < com_conf.net.length; i++) {
		const ext_port = com_conf.net[i];
		if(ext_port.dev_count == 0) {
			ext_port.bind_dev(undefined);
			ext_port.reset();
		}
	}
}
init_serial_ui();
update_serial_config();

type BRObject = {[index:string|number]:BRValue};
type BRValue = undefined|null|boolean|number|string|BRObject|BRValue[];
function brload(buffer:ArrayBuffer | DataView, into?:BRValue):BRValue {
	let offset = 0;
	let dv: DataView;
	if(buffer instanceof DataView) dv = buffer;
	else dv = new DataView(buffer);
	const limit = dv.byteLength;
	function brload_rec(depth:number, into?:BRValue):BRValue {
		let b = dv.getUint8(offset++);
		const m = b >> 5;
		const v = b & 31;
		let n = false;
		function read_enc():number | undefined {
			if(v < 24) return v;
			if(v == 24) {
				if(offset+1 > limit) throw new Error();
				let q = dv.getUint8(offset++);
				if(q < 24) throw new Error();
				return q;
			} else if(v == 25) {
				if(offset+2 > limit) throw new Error();
				let q = dv.getUint16(offset);
				offset += 2;
				if(q < 256) throw new Error();
				return q;
			} else if(v == 26) {
				if(offset+4 > limit) throw new Error();
				let q = dv.getUint32(offset);
				offset += 4;
				if(q < 65536) throw new Error();
				return q;
			} else if(v == 27) {
				if(offset+8 > limit) throw new Error();
				let qh = dv.getUint32(offset);
				let ql = dv.getUint32(offset+4);
				offset += 8;
				if((qh == 0) || (qh >= 1048576)) throw new Error();
				return qh * 4294967296 + ql;
			}
			if(v == 31 && m == 4) return undefined;
			throw new Error();
		}
		switch(m) {
		case 0: return read_enc() as number;
		case 1: return -(read_enc() as number+1);
		case 2: throw new Error();
		case 3: {
			const len = read_enc() as number;
			let s = '';
			for(let i = 0; i < len; i++) {
				if(offset+1 > limit) throw new Error();
				const c = dv.getUint8(offset++);
				if(c < 128) s += String.fromCharCode(c);
				else if((c & 248)==240) { // 3
					if(offset+3 > limit) throw new Error();
					const c2 = dv.getUint8(offset++); if((c2 & 192)!=128) throw new Error();
					const c1 = dv.getUint8(offset++); if((c1 & 192)!=128) throw new Error();
					const c0 = dv.getUint8(offset++); if((c0 & 192)!=128) throw new Error();
					s += String.fromCharCode(((c&31)<<18) | ((c2&63)<<12) | ((c1&63)<<6) | (c0&63));
				}
				else if((c & 240)==224) { // 2
					if(offset+2 > limit) throw new Error();
					const c1 = dv.getUint8(offset++); if((c1 & 192)!=128) throw new Error();
					const c0 = dv.getUint8(offset++); if((c0 & 192)!=128) throw new Error();
					s += String.fromCharCode(((c&31)<<12) | ((c1&63)<<6) | (c0&63));
				}
				else if((c & 224)==192) { // 1
					if(offset+1 > limit) throw new Error();
					const c0 = dv.getUint8(offset++); if((c0 & 192)!=128) throw new Error();
					s += String.fromCharCode(((c&31)<<6) | (c0&63));
				}
				else throw new Error();
			}
			return s;
		}
		case 4: {
			const len = read_enc();
			if(into !== undefined) {
				if(typeof into != 'object' || !Array.isArray(into)) {
					throw new Error();
				}
			}
			const a:BRValue[] = (into !== undefined) ? into:[];
			if(len == undefined) {
				let i = 0;
				while(dv.getUint8(offset) != 0xff) {
					a[i] = brload_rec(depth+1, a[i]);
					i++;
				}
				offset++;
				return a;
			}
			for(let i = 0; i < len; i++) {
				a[i] = brload_rec(depth+1, a[i]);
			}
			return a;
		}
		case 5: {
			const len = read_enc();
			if(into !== undefined) {
				if(into == null
					|| typeof into != 'object'
					|| Array.isArray(into)) throw new Error();
			}
			const o:{[index:string|number]:BRValue} =
				(into !== undefined) ? into : {};
			if(len == undefined) {
				while(dv.getUint8(offset) != 0xff) {
					const k = brload_rec(depth+1);
					if(typeof k == 'number' || typeof k == 'string') {
						const v = brload_rec(depth+1, o[k]);
						o[k] = v;
					} else throw new Error();
				}
				offset++;
				return o;
			}
			for(let i = 0; i < len; i++) {
				const k = brload_rec(depth+1);
				if(typeof k == 'number' || typeof k == 'string') {
					const v = brload_rec(depth+1, o[k]);
					o[k] = v;
				} else throw new Error();
			}
			return o;
		}
		case 6:{
			const tv = read_enc();
			const item = brload_rec(depth+1);
			if(typeof item == 'number') {
				if(tv == 6) {
					if(into !== undefined) {
						if(typeof into == 'object' && Array.isArray(into)) {
							for(let i = 0; i < 8 && i < into.length; i++) {
								if(into[i] === false || into[i] === true) {
									into[i] = (item & (1<<i)) != 0;
								} else throw new Error();
							}
							return into;
						}
						throw new Error();
					}
					return [
						(item&1)!=0,(item&2)!=0,(item&4)!=0,(item&8)!=0,
						(item&16)!=0,(item&32)!=0,(item&64)!=0,(item&128)!=0,
					];
				}
			}
			return item;
			}
		case 7: {
			if(v == 20) {
				if(into != undefined && into != null && typeof into != 'boolean')
					return into;
				return false;
			}
			if(v == 21) {
				if(into != undefined && into != null && typeof into != 'boolean')
					return into;
				return true;
			}
			if(v == 22) return null;
			if(v == 23) return undefined;
			throw new Error();
			}
		}
		throw new Error();
	}
	return brload_rec(0, into);
}
const brscratch = new Uint8Array(16);
const brscratchv = new DataView(brscratch.buffer);
function brenc_int(value:number):number {
	if(value < 24) {
		brscratch[0] |= value;
		return 1;
	} else if(value < 256) {
		brscratch[0] |= 24;
		brscratchv.setUint8(1, value);
		return 2;
	} else if(value < 65536) {
		brscratch[0] |= 25;
		brscratchv.setUint16(1, value, false);
		return 3;
	} else if(value < 4294967296) {
		brscratch[0] |= 26;
		brscratchv.setUint32(1, value, false);
		return 5;
	}
	throw new Error();
}
function brsave(value:BRValue) {
	let ds = '';
	function brsave_rec(value:BRValue) {
		if(value === false) {
			ds += String.fromCharCode(244);
			return;
		} else if(value === true) {
			ds += String.fromCharCode(245);
			return;
		} else if(value === null) {
			ds += String.fromCharCode(246);
			return;
		} else if(value === undefined) {
			ds += String.fromCharCode(247);
			return;
		} else if(typeof value == 'number') {
			if(Math.floor(value) != value) throw new Error();
			brscratch[0] = 0;
			if(value < 0) {
				brscratch[0] = 32;
				value = -(value+1);
			}
			let dlen = brenc_int(value);
			for(let i = 0; i < dlen; i++) {
				ds += String.fromCharCode(brscratch[i]);
			}
			return;
		} else if(typeof value == 'string') {
			brscratch[0] = 96;
			let eslen = 0;
			for(let c of value) {
				if(c.codePointAt(0) as number > 127) throw new Error();
				eslen++;
			}
			const dlen = brenc_int(eslen);
			for(let i = 0; i < dlen; i++) {
				ds += String.fromCharCode(brscratch[i]);
			}
			for(let c of value) {
				ds += c;
			}
			return;
		} else if(typeof value == 'object') {
			if(Array.isArray(value)) {
				let is_b = value.length > 1;
				let b_val = 0;
				for(let i = 0; is_b && i < value.length; i++) {
					if(value[i] === true) {
						b_val |= 1<<i;
					} else if(value[i] !== false) {
						is_b = false;
						break;
					}
				}
				if(is_b && value.length < 8) {
					ds += String.fromCharCode(198);
					brsave_rec(b_val);
					return;
				}
				brscratch[0] = 128;
				const dlen = brenc_int(value.length);
				for(let i = 0; i < dlen; i++) {
					ds += String.fromCharCode(brscratch[i]);
				}
				for(let i = 0; i < value.length; i++) {
					brsave_rec(value[i]);
				}
			} else {
				brscratch[0] = 160;
				const kv = Object.entries(value);
				const dlen = brenc_int(kv.length);
				for(let i = 0; i < dlen; i++) {
					ds += String.fromCharCode(brscratch[i]);
				}
				for(let i = 0; i < kv.length; i++) {
					if(/^0|(?:[1-9][0-9]*)$/.test(kv[i][0])) {
						const kn = parseInt(kv[i][0]);
						brsave_rec(kn);
					} else {
						brsave_rec(kv[i][0]);
					}
					brsave_rec(kv[i][1]);
				}
			}
			return;
		}
		throw new Error();
	}
	brsave_rec(value);
	const bv = new Uint8Array(ds.length);
	for(let i = 0; i<ds.length; i++) {
		bv[i] = ds.charCodeAt(i);
	}
	return bv;
}
function to_csr(buffer:ArrayBuffer):string {
	const dv = new DataView(buffer);
	let s = '';
	let i = 0;
	const limit = buffer.byteLength;
	while(i < limit) {
		let v:number;
		if(i+3 < limit) {
			v = dv.getUint32(i, true);
		} else if(i+2 < limit) {
			v = dv.getUint8(i) | (dv.getUint8(i+1)<<8) | (dv.getUint8(i+2)<<16);
			v += 4328521728;
		} else if(i+1 < limit) {
			v = dv.getUint8(i) | (dv.getUint8(i+1)<<8);
			v += 4311744512;
		} else {
			v = dv.getUint8(i);
			v += 4294967296;
		}
		const v0 = v % 95; v = (v / 95) | 0;
		const v1 = v % 95; v = (v / 95) | 0;
		const v2 = v % 95; v = (v / 95) | 0;
		const v3 = v % 95; v = (v / 95) | 0;
		s += String.fromCharCode(32 + v) +
		String.fromCharCode(32 + v0) +
		String.fromCharCode(32 + v1) +
		String.fromCharCode(32 + v2) +
		String.fromCharCode(32 + v3);
		i+=4;
	}
	return s;
}
function from_csr(s:string):ArrayBuffer {
	const blocks = (s.length / 5) | 0;
	const buffer = new ArrayBuffer(blocks * 4);
	const dv = new DataView(buffer);
	const limit = blocks * 5;
	let i = 0;
	let o = 0;
	while(i+4 < limit) {
		const sv = s.charCodeAt(i) - 32;
		const sv0 = s.charCodeAt(i+1) - 32;
		const sv1 = s.charCodeAt(i+2) - 32;
		const sv2 = s.charCodeAt(i+3) - 32;
		const sv3 = s.charCodeAt(i+4) - 32;
		let v = sv * 95 + sv3;
		v = v * 95 + sv2;
		v = v * 95 + sv1;
		v = v * 95 + sv0;
		if(v > 4294967295) v -= 4294967296;
		dv.setUint32(o, v, true);
		o+=4;
		i+=5;
	}
	return buffer;
}

function config_load() {
	// config_load must be called before:
	// update_layout()
	// setupmemory()
	// update_runrate()
	// update_sense()
	// update_diagsw()
	{ // uicore
		crtcol.value = CONFIG.vt_color_scheme.toString();
		crtcrev.checked = CONFIG.vt_reverse;
		check_sound.checked = CONFIG.sound;
	}
	{ // cpu
		// 0: Array<boolean>
		//  > view_int.checked = show_int = val[0];
		//  > view_uop.checked = show_uop = val[1];
		//  > view_reg.checked = show_reg = val[2];
		//  > view_page.checked = show_page = val[3];
		// 1:
		//  load val
		//    sense_switch = val & 15;
		//    dswitch = (val >> 4) & 14;
		//  save val = sense_switch | (dswitch << 4);
		const show = CONFIG.cpu[0];
		view_int.checked = show_int = show[0];
		view_uop.checked = show_uop = show[1];
		view_reg.checked = show_reg = show[2];
		view_page.checked = show_page = show[3];
		const sense = CONFIG.cpu[1];
		sense_switch = sense & 15;
		dswitch = (sense >> 4) & 14;
		const rtcsrc = CONFIG.cpu[2];
		opt_rtc[0].checked = rtcsrc == 0;
		opt_rtc[1].checked = rtcsrc == 1;
		opt_rtc[2].checked = rtcsrc == 2;
	}
	{
		// 0: number run_rate = RUNRATES[val];
		const rsel = CONFIG.emu[0];
		run_rate = RUNRATES[rsel];
	}
	// net
	{
		// [0] 0: bool auto connect
		// [0] 1: bool net sync disks
		// [0] 2: verify memory
		// [0] 3: verify state
		// [0] 4: verify hw state
		// [1] number control mode
		// [2] view mode
		// [3] state sync mode
		// [4] memory mode
		// [5] TODO I/O forwards
		let autoconn = CONFIG.net[0][0];
		let syncdisks = CONFIG.net[0][1];
		nio.memv.checked = CONFIG.net[0][2];
		nio.rss.checked = CONFIG.net[0][3];
		nio.rsh.checked = CONFIG.net[0][4];
		let ctlmode = CONFIG.net[1];
		nio.sim[ctlmode].checked = true;
		let viewmode = CONFIG.net[2];
		nio.disp[viewmode].checked = true;
		let syncmode = CONFIG.net[3];
		nio.sts[syncmode].checked = true;
		let memmode = CONFIG.net[4];
		nio.mem[memmode].checked = true;
	}
	{
		// 0: bool show_dis = view_dis.checked;
		// 1: bool HEX_CONV = false -- (impl)
		// 2: number NAME_CONV 0|1|2; -- (impl)
		show_dis = CONFIG.disassm[0];
		view_dis.checked = show_dis;
		HEX_CONV = CONFIG.disassm[1];
		conv_hex.checked = HEX_CONV;
		name_conv = CONFIG.disassm[2] as NAMECON;
	}
	{
		// 0: bool in_diagins.checked // diag roms
		// 1: number cx_diag0.dip = cx_dip = value
		in_diagins.checked = CONFIG.diag[0];
		cx_dip = CONFIG.diag[1] & 15;
		cx_diag0.dip = cx_dip;
	}
	{
		const crts = CONFIG.crt;
		// [n][0] 0: bool view_crt0 // show
		// [n][0] 1: bool inp_crtsize // tall/aspect f=1:1,t=1:2
		// [n][0] 2: bool inp_crtwide // wide (deprecated)
		// [n][0] 3: bool loc_crt0 // f=top/t=bottom
		// [n][0] 4: bool float // f=docked/t=window
		// [n][1] number size // 0=1x, 1=2x
		// [n][2] number winx // 0=default
		// [n][3] number winy // 0=default
		for(let i = 0; i < crts.length; i++) {
			const crt = crts[i];
			const viewopts = crt[0];
			if(ui_crts[i]) {
				ui_crts[i].view.checked = viewopts[0];
				let aspect = viewopts[1];
				let wide = viewopts[2];
				if(wide) { // convert old format
					// wide+tall->size 1, block (false) aspect
					crt[1] = aspect ? 1:0; aspect = !aspect;
					viewopts[1] = aspect;
					viewopts[2] = false;
					CONFIG.updated();
				}
				ui_crts[i].tall.checked = aspect;
				ui_crts[i].size.value = crt[1].toString();
			}
			if(i == 0) {
				if(viewopts[3]) { // f=top/t=bottom
					loc_crt0[0].checked = false; //top
					loc_crt0[1].checked = true; //bottom
				} else {
					loc_crt0[1].checked = false; //bottom
					loc_crt0[0].checked = true; //top
				}
			}
		}
	}
	do {
		const ffcs = CONFIG.ffc;
		if(ffcs == undefined) break;
		// [n][0] bool installed -- N/A
		// [n][1] bool show_ffc = view_ffc.checked;
		for(let i = 0; i < ffcs.length; i++) {
			const ffc = ffcs[i];
			show_ffc = ffc[1];
			view_ffc.checked = show_ffc;
		}
	} while(false);
}

function config_save() {
	// TODO uicore
	// 0: string -- UI font -- N/A could be a thing though
	{ // cpu
		// 0: Array<boolean>
		//  > view_int.checked = show_int = val[0];
		//  > view_uop.checked = show_uop = val[1];
		//  > view_reg.checked = show_reg = val[2];
		//  > view_page.checked = show_page = val[3];
		// 1:
		//  u8 bits: dswitch[3..1] | 0 | sense_switch[3..0]
		//  save val = sense_switch | (dswitch << 4);
		const show = CONFIG.cpu[0];
		show[0] = show_int;
		show[1] = show_uop;
		show[2] = show_reg;
		show[3] = show_page;
		CONFIG.cpu[1] = sense_switch | (dswitch << 4);
		let rtcsrc = 0;
		if(opt_rtc[2].checked) rtcsrc = 2;
		if(opt_rtc[1].checked) rtcsrc = 1;
		if(opt_rtc[0].checked) rtcsrc = 0;
		CONFIG.cpu[2] = rtcsrc;
	}
	{
		// 0: number run_rate = RUNRATES[val];
		for(let i = 0; i < RUNRATES.length; i++) {
			if(RUNRATES[i] == run_rate) {
				CONFIG.emu[0] = i;
				break;
			}
		}
	}
	// net
	{
		// [0] 0: bool auto connect
		// [0] 1: bool net sync disks
		// [0] 2: verify memory
		// [0] 3: verify state
		// [0] 4: verify hw state
		// [1] number control mode
		// [2] view mode
		// [3] state sync mode
		// [4] memory mode
		// [5] TODO I/O forwards
		//let autoconn = CONFIG.net[0][0];
		//let syncdisks = CONFIG.net[0][1];
		CONFIG.net[0][2] = nio.memv.checked;
		CONFIG.net[0][3] = nio.rss.checked;
		CONFIG.net[0][4] = nio.rsh.checked;
		for(let i = 0; i < nio.sim.length; i++) {
			if(nio.sim[i].checked) { CONFIG.net[1] = i; break; }
		}
		for(let i = 0; i < nio.sim.length; i++) {
			if(nio.disp[i].checked) { CONFIG.net[2] = i; break; }
		}
		for(let i = 0; i < nio.sim.length; i++) {
			if(nio.sts[i].checked) { CONFIG.net[3] = i; break; }
		}
		for(let i = 0; i < nio.sim.length; i++) {
			if(nio.mem[i].checked) { CONFIG.net[4] = i; break; }
		}
	}
	{
		// 0: bool show_dis = view_dis.checked;
		// 1: bool HEX_CONV = false -- (impl)
		// 2: number NAME_CONV 1|2|3; -- (impl)
		CONFIG.disassm[0] = show_dis;
		CONFIG.disassm[1] = HEX_CONV;
		CONFIG.disassm[2] = name_conv;
	}
	{
		// 0: bool in_diagins.checked // diag roms
		// 1: number cx_diag0.dip = cx_dip = value
		CONFIG.diag[0] = in_diagins.checked;
		CONFIG.diag[1] = cx_diag0.dip & 15;
	}
	{
		const crts = CONFIG.crt;
		// [n][0] 0: bool view_crt0 // show
		// [n][0] 1: bool inp_crtsize // tall
		// [n][0] 2: bool inp_crtwide // wide
		// [n][0] 3: bool loc_crt0 // f=top/t=bottom
		for(let i = 0; i < crts.length; i++) {
			const crt = crts[i];
			const viewopts = crt[0];
			if(ui_crts[i]) {
				let size = parseInt(ui_crts[i].size.value);
				if(isNaN(size)) { size = 0; }
				viewopts[0] = ui_crts[i].view.checked;
				viewopts[1] = ui_crts[i].tall.checked;
				crt[1] = size;
			}
			if(i == 0) {
				viewopts[3] = loc_crt0[1].checked;
			}
		}
	}
	do {
		const ffcs = CONFIG.ffc;
		if(ffcs == undefined) break;
		// [n][0] bool installed -- N/A
		// [n][1] bool show_ffc = view_ffc.checked;
		for(let i = 0; i < ffcs.length; i++) {
			const ffc = ffcs[i];
			if(i==0) {
				ffc[1] = show_ffc;
			}
		}
	} while(false);
}

//@ts-ignore
window.rtd = rtd;
//@ts-ignore
window.brsave = brsave;
//@ts-ignore
window.brload = brload;
//@ts-ignore
window.to_csr = to_csr;
//@ts-ignore
window.from_csr = from_csr;
function rtd() {
	config_save();
	let d:Uint8Array = brsave(CONFIG_LL);
	let csr = to_csr(d.buffer);
	try {
		localStorage.setItem('cencfg', csr);
	} catch(ex) {
		console.warn('unable to save config string:',[csr]);
	}
}

function config_initialize() {
	let lsv = localStorage.getItem('cencfg');
	if(lsv == null) return;
	try {
		const bv = new Uint8Array(from_csr(lsv));
		console.log('loading config');
		brload(bv.buffer, CONFIG_LL);
		config_load();
	} catch(ex) {
		console.warn('unable to load config:',[lsv],ex);
	}
}
config_initialize();

//@ts-ignore
if (name_conv == NAMECON.CENT) conv_ee.checked = true;
if (name_conv == NAMECON.MEI) conv_mei.checked = true;
//@ts-ignore
if (name_conv == NAMECON.WIKI) conv_uew.checked = true;
//cx_crt[0].show_ui = ui_crts[0].view.checked;
frame_crt1.show = ui_crts[1].view.checked;
frame_crt2.show = ui_crts[2].view.checked;

function nio_update_sim() {
	run_control(false);
	if (active_connection == null || !net_provides_rc) {
		selsim = mcsim;
	} else {
		if (nio.sim[0].checked) {
			selsim = mcsim;
		}
		if (nio.sim[1].checked) {
			selsim = remcpu;
		}
		if (nio.sim[2].checked || nio.sim[3].checked) {
			selsim = mixcpu;
		}
	}
	CONFIG.updated();
}
function nio_update_disp() {
	if (active_connection == null || !net_provides_rc) {
		selcdsp = mcsim;
	} else {
		if (nio.disp[0].checked) {
			selcdsp = mcsim;
		} else if (nio.disp[1].checked) {
			selcdsp = remcpu;
		}
	}
	CONFIG.updated();
	selcdsp.step(true);
	selcdsp.showstate(true);
}
function nio_update_sts() {
	CONFIG.updated();
}
function nio_update_mem() {
	CONFIG.updated();
}
function remote_check() {
	if(active_connection != null) {
		active_connection.close(4000);
		return;
	}
	new WSConnection();
}

setupmemory();

update_microlist();
nio_update_sim();
nio_update_disp();
//mcsim.step(true);
//mcsim.showstate(true);
main_ffc.step(true);

//@ts-ignore
window.io_ffc = main_ffc;
//@ts-ignore
window.io_dsk2 = dsk2_0;
//@ts-ignore
window.io_mux = mmio_mux;
//@ts-ignore
window.io_trace = mmio_t;
//@ts-ignore
window.bpl = bpl;
//@ts-ignore
window.sim = mcsim;
//@ts-ignore
window.disk_images = disk_images;
//@ts-ignore
window.export_disk_image = export_disk;

const cpu = new CPU6(bpl, mcsim.page_ram);
const ucpu = new UMCPU6();
const udiscpu = new CPU6(ucpu.mem, ucpu.page);
//@ts-ignore
window.umc = ucpu;
loadhex(mem0, program_rotr, 0x100);
//mem.loadbin(wipl_dump);

function show_disasm() {
	let vpc:number = 0;
	const last_exec = listing[dis_last_exec];
	style_off(last_exec.line, 'exec');
	let target_map = run_follow ? last_map : dis_map;
	if(cpu.map != target_map) {
		cpu.map = target_map;
		vpc = run_follow ? last_pc : dis_vpc;
		dis_meminval = true; // invalidate the listing, the map changed
	} else if(run_follow) {
		let set_vpc = last_pc;
		const s_cutoff = 25;
		for(let n = 0; n < listmax; n++) {
			const row = listing[n];
			if(row.v_ref == last_pc) {
				if(n < s_cutoff) {
					set_vpc = listing[0].v_ref; // leave the listing alone
					dis_last_exec = n;
				} else { // vpc too far forward
					set_vpc = listing[n - 16].v_ref; // catch up!
					dis_meminval = true; // we are moving the listing base
					dis_last_exec = n - s_cutoff;
				}
				style_if(listing[dis_last_exec].line, 'exec', true);
				break;
			}
		}
		vpc = set_vpc;
	} else {
		for(let n = 0; n < listmax; n++) {
			const row = listing[n];
			if(row.v_ref == last_pc) {
				style_if(row.line, 'exec', true);
				dis_last_exec = n;
				break;
			}
		}
		vpc = dis_vpc;
	}
	// did the listing move? or did memory update?
	if(listing[0].v_ref == vpc && !dis_meminval) return;
	dis_ppc = cpu.phys(vpc);
	const empty = '';
	const ret:DisAsmResult = {
		hb: empty,
		asc: empty,
		ins: empty,
		par: empty,
		l: 0,
		pa: 0,
		pg: 0,
		ic: null,
		pre: empty,
		post: empty,
		is_brk: false,
	};
	for (let i = 0; i < listmax; i++) {
		const listitem = listing[i];
		try {
			ret.hb = empty;
			ret.asc = empty;
			ret.ins = empty;
			ret.par = empty;
			ret.pre = empty;
			ret.post = empty;
			ret.is_brk = false;
			cpu.disassembly(vpc, ret);
			listitem.v_ref = vpc;
			listitem.a_ref = ret.pa;
			listitem.addrp.innerText = hex(ret.pa >> 8, 3);
			listitem.addrv.innerText = `${hex(vpc, 4)}: `;
			style_if(listitem.line, 'brk', ret.is_brk);
			listitem.pre.innerText = ret.pre;
			listitem.hex.innerText = ret.hb;
			listitem.ascii.innerText = ret.asc;
			listitem.inst.innerText = ret.ins;
			listitem.param.innerText = ret.par;
			listitem.comm.innerText = ret.post;
			vpc = (vpc + ret.l) & 0xffff;
		} catch(e) {
			listitem.hex.innerText = '';
			listitem.inst.innerText = '';
			listitem.comm.innerText = '{{ERROR}}';
			vpc = (vpc + 1) & 0xffff;
		}
	}
	dis_ppc_end = ret.pa + ret.l;
}
const rex_hex4 = /^[0-9a-fA-F]{1,4}$/;
const rex_hex4m = /^([0-9a-fA-F]{1,4})\/([0-7])$/;
function handle_dbg_input(cmd:HTMLInputElement) {
	let r = rex_hex4m.exec(cmd.value);
	if (r) {
		dis_vpc = parseInt(r[1], 16) & 0xffff;
		dis_map = parseInt(r[2], 16) & 0x7;
		run_follow = false;
	} else if (rex_hex4.test(cmd.value)) {
		dis_vpc = parseInt(cmd.value, 16) & 0xffff;
		run_follow = false;
	} else {
		run_follow = true;
	}
}
handle_dbg_input(in_dbgcmd);
function um_reset() {
	ucpu.loadxrec(programx_xassm, 0x8000);
	ucpu.reset();
}
const xassm_ignore_branches = new Set<number>();
{
	const v = xassm_ignore_branches;
	const b = 0x8000;
	[
	0x153,0x8b5,0x8bc,
	0xa7a, // BEGin
	0x13c4, // end of reg table
	0x1812,0x186b,0x1870,
	0x2150,0x2156,0x215b,
	0x235f,0x236a,0x236d,//RTrim
	].forEach((n)=>v.add(b+n));
}

function um_xassm() {
	// listing string: 0x21BD (+0x1FBD)
	// source string: 0x514 (+0x0314)
	// Eval stack: 0x2343 (+0x2143)
	const b = 0x8000;
	let mem_hi = ucpu.fetchw(b+0x06E9);
	let mem_endh = ucpu.fetchw(b+0x06EB);
	let mem_sttb = ucpu.fetchw(b+0x06ED);
	let mem_exlen = ucpu.fetchw(b+0x06EF);
	let ops = ucpu.fetch(b+0x089D); // B: L_operandsize: 0x0A9D
	let f9a = ucpu.fetch(b+0x089a); // B: 0a9a
	let f9b = ucpu.fetchw(b+0x089b); // W: 0a9b
	let loc = ucpu.fetchw(b+0x089E); // W: location counter: 0x0A9E
	let opf = ucpu.fetch(b+0x08A0); // B: operand flag?: 0x0AA0
	let lptr1 = ucpu.fetchw(b+0x08A1); // W: Line ptr ?: 0x0AA1
	let lptr2 = ucpu.fetchw(b+0x08A3); // W: Line end?: 0x0AA3
	let lptr3 = ucpu.fetchw(b+0x08A5); // W: Line ptr ?: 0x0AA5
	let lptr4 = ucpu.fetchw(b+0x08A9); // W: Line skip spc ptr: 0x0AA9
	let lptr5 = ucpu.fetchw(b+0x08AB); // W: Line ptr ?: 0x0AAB
	let lptr6 = ucpu.fetchw(b+0x08AD); // W: Line ptr ?: 0x0AAD
	let lptr7 = ucpu.fetchw(b+0x08AF); // W: F_LineEndPtr: 0x0AAF
	let lerr = ucpu.fetch(b+0x185F); // B: Line Error flag: 0x1A5F
	let err_count = ucpu.fetchw(b+0x026D); // W: Error count: 0x046D
	let lst_str = ucpu.fetch_str(b+0x1FBD);
	let src_str = ucpu.fetch_str(b+0x314);
	let head_str = ucpu.fetch_str(b+0x282);
	let evl_str = '';
	for(let r = 0; r < 16; r++) {
		evl_str += hex(ucpu.fetch(b+0x2143-r));
	}
	return `SML:${hex(mem_hi,4)} TS:${hex(mem_sttb,4)} TE:${hex(mem_endh,4)} XL:${mem_exlen}\n`+
	`OS:${ops} 9A:${f9a} 9B:${hex(f9b,4)} LOC:${hex(loc,4)} OF:${opf} LE:${lerr} EC:${err_count}\n`+
	`LP: ${hex(lptr1,4)} ${hex(lptr2,4)} ${hex(lptr3,4)} ${hex(lptr4,4)} ${hex(lptr5,4)} ${hex(lptr6,4)} ${hex(lptr7,4)}`+
	`\nHD:${head_str}\nLST:"${lst_str}"\nSRC:"${src_str}"\nEVAL:${evl_str}`;
}
function um_show_soi(st:number) {
	const ret: DisAsmResult = {
		asc: '', hb: '', ic: null, ins: '',
		is_brk: false, l: 0,pa: 0, pg: 0,
		par: '', post: '', pre: ''
	};
	udiscpu.disassembly(st, ret);
	return `${hex(st,4)}: ${
	ret.pre} ${ret.hb} ${ret.ins}${ret.par} ${ret.post}`;
}
interface BRTrace {
	oaddr: number;
	opr: string;
	opp: string[];
	tcount: number;
	taddr: number;
	fcount: number;
}
let brtrace = new Map<number, BRTrace>();
function um_run(ncount = 1) {
	let soi = ucpu.pc;
	let pass_flag = 0;
	const b = 0x8000;
	for(let k = 0; k < ncount; k++) {
		try {
			if(ucpu.pc == b+0x8b1) {
				if(k > 0 && ucpu.src_pointer < ucpu.src_buffer.length) break;
				if(pass_flag == 0) {
					console.log('clrtrace');
					brtrace.clear();
				}
				pass_flag++;
			}
			soi = ucpu.pc;
			let op_byte = ucpu.fetch(soi);
			ucpu.step();
			if(um_enable_sync) {
				if(op_byte != 0x66) {
					let r = 0;
					while(mcsim.at_boundry && r < 10000) {
						mcsim.step(false);
						r++;
					}
					while(!mcsim.at_boundry && r < 10000) {
						mcsim.step(false);
						r++;
					}
				} else {
					mcsim.set_pc(ucpu._pc);
				}
			}
			if(soi == b+0x185b) {
				break; // Line Error!
			}
			if(um_enable_sync) {
				if(mcsim.pc != ucpu.pc) {
					console.log('!v fail: PC','h',hex(mcsim.pc,4),'u',hex(ucpu.pc,4), um_show_soi(soi));
					break;
				}
				if(mcsim.cc != ucpu.cc) {
					console.log('!v fail: CC','h',ccr_str(mcsim.cc),'u',ccr_str(ucpu.cc), um_show_soi(soi));
				}
				if(mcsim.reg.a != ucpu.levelreg.a) {
					console.log('!v fail: A','h',hex(mcsim.reg.a,4),'u',hex(ucpu.levelreg.a,4), um_show_soi(soi));
					break;
				}
				if(mcsim.reg.b != ucpu.levelreg.b) {
					console.log('!v fail: B','h',hex(mcsim.reg.b,4),'u',hex(ucpu.levelreg.b,4), um_show_soi(soi));
					break;
				}
				if(mcsim.reg.x != ucpu.levelreg.x) {
					console.log('!v fail: X','h',hex(mcsim.reg.x,4),'u',hex(ucpu.levelreg.x,4), um_show_soi(soi));
					break;
				}
				if(mcsim.reg.y != ucpu.levelreg.y) {
					console.log('!v fail: Y','h',hex(mcsim.reg.y,4),'u',hex(ucpu.levelreg.y,4), um_show_soi(soi));
					break;
				}
				if(mcsim.reg.z != ucpu.levelreg.z) {
					console.log('!v fail: Z','h',hex(mcsim.reg.z,4),'u',hex(ucpu.levelreg.z,4), um_show_soi(soi));
					break;
				}
				if(mcsim.reg.s != ucpu.levelreg.s) {
					console.log('!v fail: S','h',hex(mcsim.reg.s,4),'u',hex(ucpu.levelreg.s,4), um_show_soi(soi));
					break;
				}
			}
			if(ucpu.trace.count > 0) {
				let memfail = false;
				if(um_enable_sync) {
					for(let i = 0; i < ucpu.trace.count; i++) {
						let tr = ucpu.trace.list[i];
						if(tr.op == 'ST' && tr.wh) {
							let c = ucpu.fetch(tr.wh);
							let v = bpl.readmeta(tr.wh) & 255;
							if(v != c) {
								console.log('!v fail: MEM', `${hex(tr.wh,4)}: h ${hex(v)} != u ${hex(c)}`, um_show_soi(soi));
								memfail = true;
							}
						}
					}
				}
				if(memfail) break;
				// if(xassm_ignore_branches.has(soi)) {
				// 	continue;
				// }
				let ti = brtrace.get(soi);
				let tr = ucpu.trace.list[0];
				if(ti == undefined) {
					ti = {
						oaddr: soi,
						tcount: 0, fcount: 0,
						taddr: tr.wh as number,
						opr: tr.op, opp: [],
					};
					brtrace.set(soi, ti);
				} else {
					ti.opr = tr.op;
				}
				if(tr.tk !== undefined) {
					if(tr.param !== undefined) {
						if(!ti.opp.includes(tr.param)) {
							ti.opp.push(tr.param);
						}
					}
					if(tr.tk) ti.tcount++; else ti.fcount++;
					//ti = `${hex(soi,4)} ${tr.op} ${tr.tk?'T':'F'} ${hex(tr.wh as number)}; `;
					
				} else if(tr.wh) {
					if(tr.wh == b+0x185F) {
						//ti = `${hex(soi,4)} ${tr.op} > ${hex(tr.wh)}; `;
					}
				}
			}
			softlog(um_show_soi(soi));
		} catch(e) {
			ucpu.pc = soi;
			if(e === 0) { // priv
				softlog('ucpu: priv:'+ um_show_soi(soi));
			} else if(e === 1) { // ill
				softlog('ucpu: ill:'+ um_show_soi(soi));
			} else if(typeof e == 'object' && e != null) { // NYI
				softlog(`ucpu: NYI: ${JSON.stringify(e)} ${um_show_soi(soi)}`);
				console.error('ucpu: NYI:',e,um_show_soi(soi));
			}
			break;
		}
	}
	if(um_enable_sync) mcsim.showstate(true);
	let strace = '';
	let slc = 0;
	brtrace.forEach((v,k)=>{
		strace += `${hex(v.oaddr,4)} ${v.opr} ${v.opp.join(' ')} ${hex(v.taddr,4)}`;
		if(v.tcount > 0) strace += ` T${v.tcount}`;
		if(v.fcount > 0) strace += ` F${v.fcount}`;
		strace += '; ';
		if(++slc > 7) {
			//strace += '\n';
			slc = 0;
		}
	});
	/*`cpu: ${ucpu.showreg()
	}\nstep: ${um_show_soi(soi)
	}\nnext: ${um_show_soi(ucpu.pc)}\nBR:${strace}\n` + um_xassm();
	*/
}
vc_sync.addEventListener('click', function(ev) {
	um_enable_sync = !um_enable_sync;
	style_if(this, 'active', um_enable_sync);
})
vc_reset.addEventListener('click', function(ev) {
	um_reset();
	brtrace.clear();
	let r = 0;
	ucpu.src_buffer.length = 0;
	const model = editors.edit1;
	if(model) {
		ucpu.src_buffer = model.getLinesContent();
	}
	//vc_input.value.split('\n');
	if(um_enable_sync) {
		while(!mcsim.at_boundry && r < 10000) {
			mcsim.step(false);
			r++;
		}
		if(mcsim.at_boundry) {
			mcsim.set_pc(ucpu._pc);
		}
		mcsim.showstate(true);
		if (show_dis) show_disasm();
		if (memv_after) update_memview();
	}
});
vc_step.addEventListener('click', function(ev) {
	um_run();
	if(um_enable_sync) {
		if (show_dis) show_disasm();
		if (memv_after) update_memview();
	}
});
vc_snap.addEventListener('click', function(ev) {
	ucpu.snap();
	brtrace.clear();
});
vc_restore.addEventListener('click', function(ev) {
	ucpu.restore();
	brtrace.clear();
	//vc_log.value = `cpu: ${ucpu.showreg()}\n<restore>\nnext: ${um_show_soi(ucpu.pc)}`;
	if(um_enable_sync) {
		if (show_dis) show_disasm();
		if (memv_after) update_memview();
	}
});
vc_run.addEventListener('click', function(ev) {
	um_run(50);
	if(um_enable_sync) {
		if (show_dis) show_disasm();
		if (memv_after) update_memview();
	}
});
vc_rerun.addEventListener('click', function(ev) {
	ucpu.restore();
	brtrace.clear();
	um_run(2000);
	if(um_enable_sync) {
		if (show_dis) show_disasm();
		if (memv_after) update_memview();
	}
});
// vc_input.addEventListener('input', function(ev) {
// 	ucpu.src_buffer = vc_input.value.split('\n');
// 	ucpu.restore();
// 	brtrace.clear();
// 	um_run(1500);
// 	if(um_enable_sync) {
// 		if (show_dis) show_disasm();
// 		if (memv_after) update_memview();
// 	}
// });
vc_clear.addEventListener('click', function(ev) {
	editors.out_m?.setValue('');
});
in_dbgcmd.addEventListener('input', function(ev) {
	handle_dbg_input(this);
	show_disasm();
});
in_dbgcmd.addEventListener('keypress', function(ev) {
	if (ev.code == 'Enter' || ev.code == 'NumpadEnter') {
		handle_dbg_input(this);
		show_disasm();
	}
});
in_diagins.addEventListener('change', function(ev) {
	setupmemory(); CONFIG.updated();
});
// sense_switch
function update_sense() {
	style_if(btn_ss1,'active',(sense_switch & 1) > 0);
	style_if(btn_ss2,'active',(sense_switch & 2) > 0);
	style_if(btn_ss3,'active',(sense_switch & 4) > 0);
	style_if(btn_ss4,'active',(sense_switch & 8) > 0);
	style_if(fp_rf,'active',(sense_switch & 8) > 0);
	style_if(btn_ssR,'active',(dswitch & 8) > 0);
	style_if(btn_ssH,'active',(dswitch & 4) > 0);
	style_if(btn_ssI,'active',(dswitch & 2) > 0);
}
function update_diagsw() {
	style_if(btn_dt1,'active',(cx_dip & 1) != 0);
	style_if(btn_dt2,'active',(cx_dip & 2) != 0);
	style_if(btn_dt4,'active',(cx_dip & 4) != 0);
	style_if(btn_dt8,'active',(cx_dip & 8) != 0);
	style_if(sts_dt1,'active',(cx_diag0.dip & 1) != 0);
	style_if(sts_dt2,'active',(cx_diag0.dip & 2) != 0);
	style_if(sts_dt4,'active',(cx_diag0.dip & 4) != 0);
	style_if(sts_dt8,'active',(cx_diag0.dip & 8) != 0);
}
update_sense();
update_diagsw();

class NetSerial implements CharDevice {
	dev: CharDevice | undefined = undefined;
	rts: boolean = false;
	cts: boolean = false;
	rx_buf: number[] = [];
	tx_buf: number[] = [];
	name: string;
	dev_index: number;
	dev_count: number = 0;
	rx_flag = false;
	conn: WSConnection | null = null;
	constructor(name:string, index:number) {
		this.name = name;
		this.dev_index = index;
	}
	reset(): void {
		this.rx_buf.length = 0;
		this.tx_buf.length = 0;
	}
	receive(c: number): void {
		this.rx_buf.push(c);
		if(!this.rx_flag && this.dev) {
			this.rx_flag = true;
			let l: number;
			let k = 0;
			do {
				l = this.rx_buf.length;
				this.dev.check_send();
				k++;
			} while(k < 20 && l != this.rx_buf.length);
			this.rx_flag = false;
			if(this.conn) {
				this.conn.handle_tx_tick();
			}
		}
	}
	can_receive(): boolean {
		return com_conf.have_net;
	}
	check_send(): void {
		if(this.tx_buf.length > 0 && this.dev && this.dev.can_receive()) {
			do {
				let c = this.tx_buf.shift() as number;
				this.dev.receive(c);
			} while(this.tx_buf.length > 0 && !this.dev.emu_linked && this.dev.can_receive());
		}
	}
	set_rts(value: boolean): void {
		this.rts = value;
		if(this.dev) {
			this.dev.set_cts(this.rts);
		}
	}
	get_dev(): CharDevice | undefined {
		return this.dev;
	}
	bind_dev(dev: CharDevice | undefined): void {
		this.dev = dev;
		if(dev) {
			this.set_cts(dev.rts);
		}
	}
	set_cts(value: boolean): void {
		this.rx_buf.push(value ? 0x101 : 0x100);
		this.cts = value;
	}
}
class WSConnection {
	socket:WebSocket;
	ext_count = 0;
	opt_count = 0;
	onmessage:((data:ArrayBuffer)=>void);
	buf = new ArrayBuffer(4096);
	constructor() {
		active_connection = this;
		style_if(local_button, 'warn', true);
		console.log('network connecting');
		let addr = ws_addr.value;
		if(addr == '') addr = '127.0.0.1';
		else if(/[^:]+:[0-9]+$/.test(addr) == false) addr += ':42646';
		this.socket = new WebSocket(`ws://${addr}/`);
		this.socket.binaryType = 'arraybuffer';
		this.onmessage = this.msg_hello;
		this.socket.onopen = () => {
			style_if(local_button, 'active', true);
			style_if(local_button, 'warn', false);
			const req = new DataView(this.buf, 0, 24);
			req.setUint16(0, 0x0020, true);
			req.setUint16(2, 0x0300);
			req.setUint16(4, 0x5765);
			req.setUint32(6, 0x6243656e);
			req.setUint32(10, 0);
			req.setUint32(14, 0);
			req.setUint32(18, 0);
			req.setUint16(22, 0x0200);
			this.socket.send(req);
			console.log('network open');
		};
		this.socket.onclose = (ev) => {
			console.log('network closed', ev.code, `${ev.reason}`);
			this.close();
			style_if(local_button, 'active', false);
			style_if(local_button, 'warn', false);
		};
		this.socket.onerror = () => {
			console.warn('network error');
			this.close();
		};
		this.socket.onmessage = (ev) => {
			if(typeof ev.data == 'string') {
				this.message_str(ev.data);
			} else if(ev.data instanceof ArrayBuffer) {
				if(ev.data.byteLength < 4) return;
				try {
				this.onmessage(ev.data);
				} catch(e) {
					console.warn('protocol error', e);
					this.close(4001);
				}
			} else {
				console.warn('unknown message', ev);
			}
		};
	}
	close(code?:number) {
		const state = this.socket.readyState;
		if(state != WebSocket.CLOSING && state != WebSocket.CLOSED) {
			this.socket.close(code);
		}
		active_connection = null;
		net_provides_rc = false;
		style_if(local_button, 'active', false);
		style_if(local_button, 'warn', true);
		remcpu.can_step = false;
		com_conf.have_net = false;
		update_serial_ui();
		update_serial_config();
	}
	message_str(data:string) {}
	validate_hello(dv:DataView) {
		if(dv.getUint16(0, true) != 0x20 ||
			dv.getUint16(2) != 0x0300 ||
			dv.getUint32(18) == 0
			) return false;
		this.ext_count = dv.getUint8(22);
		this.opt_count = dv.getUint8(23);
		return true;
	}
	msg_hello(data:ArrayBuffer) {
		const message = new DataView(data);
		if(!this.validate_hello(message)) {
			this.close(4002);
			return;
		}
		const req = new Uint16Array(this.buf, 0, 1);
		req[0] = 0x40; // get extension points
		this.socket.send(req);
		this.onmessage = this.message;
	}
	handle_tx_tick() {
		const dp = new Uint8Array(this.buf, 2);
		for(let i = 0; i < com_conf.net.length; i++) {
			const com = com_conf.net[i];
			if(com && com.conn == this) {
				let k = 0;
				if(com.rx_buf.length > 0) {
					dp[0] = com.dev_index;
					for(; k < com.rx_buf.length && k < 1020; k++) {
						let c = com.rx_buf[k];
						if(c > 0xff) {
							if(k > 0) {
								const req = new DataView(this.buf, 0, 3 + k);
								req.setUint16(0, 0x1820, true); // ser data
								this.socket.send(req);
								com.rx_buf.splice(0, k);
							}
							const req = new DataView(this.buf, 0, 4);
							dp[1] = c & 0xff;
							req.setUint16(0, 0x1830, true); // ser control
							this.socket.send(req);
							com.rx_buf.shift();
							k = -1;
							continue;
						} else {
							dp[1+k] = c;
						}
					}
					if(k > 0) {
						const req = new DataView(this.buf, 0, 3 + k);
						req.setUint16(0, 0x1820, true); // ser data
						this.socket.send(req);
						com.rx_buf.length = 0;
					}
				}
				com.check_send();
			}
		}
	}
	message(data:ArrayBuffer) {
		const message = new DataView(data);
		const payload_ofs = 2;
		switch(message.getUint16(0, true)) {
		case 0x048:{
			let ext = new Uint16Array(data, payload_ofs);
			console.log('ext resp',ext);
			for(let i = 0; i < ext.length; i++) {
				if(ext[i] == 0) { // remote control
					remcpu.can_step = true;
					nio_update_sim();
					nio_update_disp();
				}
				if(ext[i] == 2) { // filesystem
					const req = new DataView(this.buf, 0, 2);
					req.setUint16(0, 0x2000, true);
					this.socket.send(req);
				}
				if(ext[i] == 3) { // data ports (i.e. Serial)
					const req = new DataView(this.buf, 0, 2);
					req.setUint16(0, 0x1800, true);
					this.socket.send(req);
				}
			}
			break;}
		case 0x4a0:
			remcpu.decode_bytes(new Uint8Array(data, payload_ofs), 0);
			if(selcdsp === remcpu) selcdsp.showstate(false);
			break;
		case 0x4b0:
			remcpu.decode_bytes(new Uint8Array(data, payload_ofs), 0);
			if(selcdsp === remcpu) selcdsp.showstate(false);
			remcpu.can_step = true;
			break;
		case 0x1808:{
			let listing = brload(new DataView(data, payload_ofs));
			if(Array.isArray(listing)) {
				if(listing.length > 0) {
					com_conf.have_net = true;
				}
				let i:number;
				if(com_conf.net.length > listing.length) {
					com_conf.net.length = listing.length;
				}
				for(i = 0; i < listing.length; i++) {
					const com_elem = listing[i] as [string, string, any];
					const com_name = `${com_elem[0]} / ${com_elem[1]}`;
					if(i >= com_conf.net.length) {
						com_conf.net.push(new NetSerial(com_name, i));
					}
					const c_com = com_conf.net[i];
					c_com.name = com_name;
					c_com.conn = this;
					c_com.dev_count = 0;
					c_com.reset();
				}
				update_serial_ui();
				update_serial_config();
			}
			console.log(listing);
			break; }
		case 0x1820:{
			let i = message.getUint8(2);
			const c_com = com_conf.net[i];
			const dp = new Uint8Array(data, 3);
			if(c_com && c_com.dev_count != 0) {
				for(let i = 0; i < data.byteLength - 3; i++) {
					c_com.tx_buf.push(dp[i]);
				}
				c_com.check_send();
			}
			break;
		}
		case 0x1830:{
			let i = message.getUint8(2);
			const c_com = com_conf.net[i];
			if(c_com) {
				c_com.set_rts(message.getUint8(3) != 0);
			}
			break;
		}
		case 0x2008:{
			let listing = brload(new DataView(data, payload_ofs));
			console.log(listing);
			break; }
		default:
			break;
		}
	}
}

nio.sim[0].addEventListener('change', nio_update_sim);
nio.sim[1].addEventListener('change', nio_update_sim);
nio.sim[2].addEventListener('change', nio_update_sim);
nio.sim[3].addEventListener('change', nio_update_sim);
nio.disp[0].addEventListener('change', nio_update_disp);
nio.disp[1].addEventListener('change', nio_update_disp);
nio.mem[0].addEventListener('change',nio_update_mem);
nio.mem[1].addEventListener('change',nio_update_mem);
nio.mem[2].addEventListener('change',nio_update_mem);
nio.memv.addEventListener('change',nio_update_mem);
nio.sts[0].addEventListener('change',nio_update_sts);
nio.sts[1].addEventListener('change',nio_update_sts);
nio.sts[2].addEventListener('change',nio_update_sts);
nio.sts[3].addEventListener('change',nio_update_sts);
nio.rss.addEventListener('change',nio_update_sts);
nio.rsh.addEventListener('change',nio_update_sts);

btn_ss1.addEventListener('click', function(ev) { sense_switch ^= 1; update_sense(); CONFIG.updated(); });
btn_ss2.addEventListener('click', function(ev) { sense_switch ^= 2; update_sense(); CONFIG.updated(); });
btn_ss3.addEventListener('click', function(ev) { sense_switch ^= 4; update_sense(); CONFIG.updated(); });
btn_ss4.addEventListener('click', function(ev) { sense_switch ^= 8; update_sense(); CONFIG.updated(); });
btn_ssR.addEventListener('click', function(ev) { dswitch ^= 8; update_sense(); CONFIG.updated(); });
btn_ssH.addEventListener('click', function(ev) { dswitch ^= 4; update_sense(); CONFIG.updated(); });
btn_ssI.addEventListener('click', function(ev) { dswitch ^= 2; update_sense(); CONFIG.updated(); });
btn_dt1.addEventListener('click', function(ev) { cx_dip ^= 1; update_diagsw(); });
btn_dt2.addEventListener('click', function(ev) { cx_dip ^= 2; update_diagsw(); });
btn_dt4.addEventListener('click', function(ev) { cx_dip ^= 4; update_diagsw(); });
btn_dt8.addEventListener('click', function(ev) { cx_dip ^= 8; update_diagsw(); });
btn_dtrun.addEventListener('click', function(ev) { cx_diag0.dip = cx_dip; update_diagsw(); CONFIG.updated(); });
local_button.addEventListener('click', remote_check);
fp_rf.addEventListener('click', function(ev) { sense_switch ^= 8; update_sense(); CONFIG.updated(); });
fp_load.addEventListener('click', function(ev) {
	if((sense_switch|2)!=sense_switch) {
		sense_switch |= 2; CONFIG.updated();
		update_sense();
	}
	for(let i = 0; i < 3; i++) cx_crt[i].clear_buffer();
	selsim.reset();
	selcdsp.showstate(true);
});
fp_select.addEventListener('click', function(ev) {
	if((sense_switch & 253)!=sense_switch) {
		sense_switch &= 253; CONFIG.updated();
		update_sense();
	}
	for(let i = 0; i < 3; i++) cx_crt[i].clear_buffer();
	selsim.reset();
	selcdsp.showstate(true);
});
assm_button.addEventListener('click', function(ev) {
	frame_manager.toggle_show_raise(frame_assm);
	if(!editor_loaded) load_editor();
});
micro_button.addEventListener('click', function(ev) {
	frame_manager.toggle_show_raise(frame_mclist);
});
memory_button.addEventListener('click', function(ev) {
	show_mem = !show_mem;
	frame_memory.show = show_mem;
	if(show_mem) {
		frame_manager.raise_frame(frame_memory);
		update_memview();
	}
});
disk_button.addEventListener('click', function(ev) {
	frame_manager.toggle_show_raise(frame_disks);
	if(frame_disks.show) disk_view.update();
});

run_button.addEventListener('click', function(ev) {
	if(check_sound.checked && wa == undefined) wa = wa_setup();
	run_control(run_ctl == 0);
});
function update_runrate(new_rate:number) {
	run_rate = new_rate; CONFIG.updated();
	style_if(run_rate1,'active',run_rate == 1);
	style_if(run_rate2,'active',run_rate == 10);
	style_if(run_rate3,'active',run_rate == 100);
	style_if(run_rate4,'active',run_rate == 1000);
	style_if(run_rate5,'active',run_rate == 10000);
	style_if(run_rate6,'active',run_rate == 50000);
	style_if(run_rate7,'active',run_rate == 100000);
	style_if(run_rate8,'active',run_rate == 150000);
}
update_runrate(run_rate);
run_rate1.addEventListener('click', function(ev) { update_runrate(1); });
run_rate2.addEventListener('click', function(ev) { update_runrate(10); });
run_rate3.addEventListener('click', function(ev) { update_runrate(100); });
run_rate4.addEventListener('click', function(ev) { update_runrate(1000); });
run_rate5.addEventListener('click', function(ev) { update_runrate(10000); });
// can't handle this speed ;)
run_rate6.addEventListener('click', function(ev) { update_runrate(50000); });
run_rate7.addEventListener('click', function(ev) { update_runrate(100000); });
run_rate8.addEventListener('click', function(ev) { update_runrate(150000); });
step_button.addEventListener('click', function(ev) {
	run_once = true;
	run_step = true;
	run_follow = true;
	if(check_sound.checked && wa == undefined) wa = wa_setup();
	show_disasm();
	run_stop = function() {
		handle_dbg_input(in_dbgcmd);
		show_disasm();
	}
	run_control(true);
});
microstep_button.addEventListener('click', function(ev) {
	run_once = true;
	if(check_sound.checked && wa == undefined) wa = wa_setup();
	selsim.step(false);
	selcdsp.step(true);
	selcdsp.showstate(true);
	main_ffc.step(true);
	if (show_dis) show_disasm();
	if (memv_after) update_memview();
});
btn_rcon.addEventListener('click', function(ev) {
	if (win_rcon.style.display == 'none') {
		win_rcon.style.display = 'flex';
	} else {
		win_rcon.style.display = 'none';
	}
});
btn_settings.addEventListener('click', function(ev) {
	if (win_settings.style.display == 'none') {
		win_settings.style.display = '';
	} else {
		win_settings.style.display = 'none';
	}
});

// btn_cm_import.addEventListener('click', function(ev) {
// 	annotation_import(txt_anno.value);
// 	show_disasm();
// });
btn_cm_tocrt.addEventListener('click', function(ev) {
	console_text_import(txt_anno.value);
});
btn_cm_clear.addEventListener('click', function(ev) {
	txt_anno.value = '';
});
opt_rtc[0].addEventListener('change', function(ev) { if(this.checked) CONFIG.cpu[2] = 0; });
opt_rtc[1].addEventListener('change', function(ev) { if(this.checked) CONFIG.cpu[2] = 1; });
opt_rtc[2].addEventListener('change', function(ev) { if(this.checked) CONFIG.cpu[2] = 2; });
conv_ee.addEventListener('change', function(ev) {
	name_conv = NAMECON.CENT; CONFIG.updated();
	show_disasm();
});
conv_mei.addEventListener('change', function(ev) {
	name_conv = NAMECON.MEI; CONFIG.updated();
	show_disasm();
});
conv_uew.addEventListener('change', function(ev) {
	name_conv = NAMECON.WIKI; CONFIG.updated();
	show_disasm();
});
conv_hex.addEventListener('change', function(ev) {
	HEX_CONV = this.checked; CONFIG.updated();
	show_disasm();
});

document.body.addEventListener('dragstart', function(ev) {
	const dt = ev.dataTransfer;
	if(dt) {
		dt.dropEffect = 'copy';
	}
	ev.preventDefault();
});
document.body.addEventListener('dragover', function(ev) {
	const dt = ev.dataTransfer;
	if(!dt) {
		ev.preventDefault();
		return;
	}
	if(dt && dt.items.length > 0 && dt.items[0].kind == 'file') {
		dt.dropEffect = 'copy';
	} else if (dt && dt.types.length > 0) {
		dt.dropEffect = 'copy';
	} else {
		dt.dropEffect = 'none';
	}
	ev.preventDefault();
});

const crt_sizesy = [250, 500, 750, 1000];
const crt_sizesx = [640, 1280, 1920];
const crt_size_v = [1,1,1];
function update_layout() {
	display_if(dc_regs, show_reg);
	display_if(dc_int, show_int);
	display_if(dc_pages, show_page);
	display_if(dc_uop, show_uop);
	display_if(dc_listing, view_dis.checked);
	display_if(dc_ffc, show_ffc);
	display_if(dc_crt0, ui_crts[0].view.checked);
	for(let i = 0; i < 3; i++) {
		crt_size_v[i] = parseInt(ui_crts[i].size.value);
		style_if(cx_crt[i].canv,'size2x', crt_size_v[i] == 1);
		style_if(cx_crt[i].canv,'size3x', crt_size_v[i] == 2);
		style_if(cx_crt[i].canv,'tall',ui_crts[i].tall.checked);
		if(cx_crt[i].glv && ui_crts[i].view.checked) {
			cx_crt[i].canv.height = crt_sizesy[crt_size_v[i] + (ui_crts[i].tall.checked ? 1:0)];
			cx_crt[i].canv.width = crt_sizesx[crt_size_v[i]];
		}
	}
	style_if(cx_crt[0].canv,'boxed', window.innerWidth <= cx_crt[0].canv.clientWidth + 4);
	frame_crt1.show = ui_crts[1].view.checked;
	frame_crt2.show = ui_crts[2].view.checked;
	dc_regs.parentElement?.removeChild(dc_regs);
	dc_crt0.parentElement?.removeChild(dc_crt0);
	con_rows[1].removeChild(con_row2col2);
	let crt_wide_layout = crt_size_v[0] > 0 && !loc_crt0[1].checked;
	let crt_tall_layout = ui_crts[0].tall.checked;
	const row1_reg_width = 1690;
	const row1_crt_width = 1410;
	const reg_fits_on_first_row = show_reg && window.innerWidth >= row1_reg_width;
	const crt_fits_on_first_row = crt_size_v[0] == 0 && !loc_crt0[1].checked && ui_crts[0].view.checked && window.innerWidth >= row1_crt_width;
	let show_reg_layout = show_reg;
	let first_row_hp = !show_int || !show_uop || !reg_fits_on_first_row;
	if(crt_wide_layout && reg_fits_on_first_row) {
		first_row_hp = false;
	}
	if(window.innerWidth < 1392) {
		crt_wide_layout = true;
		show_reg_layout = false;
	}
	if(loc_crt0[1].checked) { // crt bottom
		if(first_row_hp || !reg_fits_on_first_row) {
			con_rows[1].appendChild(dc_regs);
			crt_wide_layout = true;
			crt_tall_layout = false;
			show_reg_layout = false;
		} else {
			con_rows[0].appendChild(dc_regs);
			crt_wide_layout = true;
		}
	} else { // crt top
		if(!crt_fits_on_first_row && reg_fits_on_first_row) {
			con_rows[0].appendChild(dc_regs);
			con_rows[1].appendChild(dc_crt0);
		} else {
			con_rows[0].appendChild(dc_crt0);
			con_rows[1].appendChild(dc_regs);
		}
	}
	con_rows[1].appendChild(con_row2col2);
	dc_pages.parentElement?.removeChild(dc_pages);
	dc_hawk.parentElement?.removeChild(dc_hawk);
	if(first_row_hp && !crt_fits_on_first_row) {
		//console.log('hk/pg r1c2');
		con_row1col2.appendChild(dc_hawk);
		con_row1col2.appendChild(dc_pages);
	} else if(crt_tall_layout && crt_fits_on_first_row) {
		//console.log('hk/pg r1c1');
		con_row1col1.appendChild(dc_hawk);
		con_row1col1.appendChild(dc_pages);
	} else if(show_reg_layout && crt_fits_on_first_row) {
		//console.log('hk r1/pg r2');
		con_row1col1.appendChild(dc_hawk);
		con_row2col2.appendChild(dc_pages);
	} else {
		//console.log('hk r1/pg r3', window.innerWidth);
		con_rows[2].appendChild(dc_pages);
		con_row1col1.appendChild(dc_hawk);
	}
	if(loc_crt0[1].checked) {
		con_row6col2.appendChild(dc_crt0);
		con_row6col2.appendChild(dc_textio);
	}
}
window.addEventListener('resize', update_layout);
function layout_and_config() {
	update_layout(); CONFIG.updated();
}
loc_crt0[0].addEventListener('change', layout_and_config);
loc_crt0[1].addEventListener('change', layout_and_config);
ui_crts[0].view.addEventListener('change', layout_and_config);
ui_crts[0].tall.addEventListener('change', layout_and_config);
ui_crts[0].size.addEventListener('change', layout_and_config);
ui_crts[1].view.addEventListener('change', layout_and_config);
ui_crts[1].tall.addEventListener('change', layout_and_config);
ui_crts[1].size.addEventListener('change', layout_and_config);
ui_crts[2].view.addEventListener('change', layout_and_config);
ui_crts[2].tall.addEventListener('change', layout_and_config);
ui_crts[2].size.addEventListener('change', layout_and_config);

view_reg.addEventListener('change', function() {
	show_reg = this.checked; CONFIG.updated();
	update_layout();
});
view_page.addEventListener('change', function() {
	show_page = this.checked; CONFIG.updated();
	update_layout();
});
view_int.addEventListener('change', function() {
	show_int = this.checked; CONFIG.updated();
	update_layout();
});
view_uop.addEventListener('change', function() {
	show_uop = this.checked; CONFIG.updated();
	update_layout();
});
view_dis.addEventListener('change', function() {
	show_dis = this.checked; CONFIG.updated();
	update_layout();
});
view_ffc.addEventListener('change', function() {
	show_ffc = this.checked; CONFIG.updated();
	update_layout();
});
update_layout();

interface DiskTemplate {
	kind:'hawk'|'finch',
	stride:number,
	size:number
}
const disk_templates:DiskTemplate[] = [
	{kind: 'hawk', stride: 512, size: 6651904},
	{kind: 'hawk', stride: 400, size: 5196800},
	{kind: 'finch', stride: FINCH_TRACK, size: FINCH_PLAT*4},
	{kind: 'finch', stride: FINCH_TRACK, size: FINCH_PLAT*3},
	{kind: 'finch', stride: FINCH_TRACK, size: FINCH_PLAT*2},
	{kind: 'finch', stride: 400, size: 28072000},
	{kind: 'finch', stride: 512, size: 35932160},
];
class DiskImageUI {
	sta: HTMLSpanElement;
	wp: HTMLInputElement;
	selrem: HTMLButtonElement;
	newdl: HTMLButtonElement;
	remtimeout?: number;
	image?: DiskImage;
	drive: DiskContainer;
	newdisk: DiskTemplate;
	constructor(id_base:string, newdisk:DiskTemplate, drive:DiskContainer) {
		this.sta = document.getElementById(`${id_base}_sta`) as HTMLSpanElement;
		this.wp = document.getElementById(`${id_base}wp`) as HTMLInputElement;
		this.selrem = document.getElementById(`${id_base}sel`) as HTMLButtonElement;
		this.newdl = document.getElementById(`${id_base}new`) as HTMLButtonElement;
		this.drive = drive;
		this.newdisk = newdisk;
		const self = this;
		this.newdl.addEventListener('click', function (ev) {
			self.click_newdl();
		});
		this.selrem.addEventListener('click', (ev)=> {
			if(this.image) {
				this.setactive(null);
			} else {
				console.error('not implemented');
			}
		});
		this.wp.addEventListener('change', function(ev) {
			if(self.image != null) {
				self.image.protect = this.checked;
			}
		})
	}
	click_newdl():void {
		if(this.image != null) {
			export_disk(this.image);
		} else {
			const buf = new ArrayBuffer(this.newdisk.size);
			const new_image: DiskImage = {
				type: this.newdisk.kind,
				stride: this.newdisk.stride,
				filename: 'NEW' + this.newdisk.kind.toUpperCase(),
				backing_data: buf,
				protect: false,
				data: new Uint8Array(buf)
			};
			this.setactive(new_image);
		}
	}
	setactive(image:DiskImage|null):void {
		if(image != null) {
			image.identifier = this.sta.id.substring(0,4);
			const luid = disk_image_luid(image);
			let index = disk_images_lu[luid];
			if(index == undefined) {
				disk_images_lu[luid] = disk_images.length;
				disk_images.push(image);
			}
			this.image = image;
			image.protect = this.wp.checked;
			this.sta.innerText = image.filename;
			this.selrem.innerText = 'Rem';
			this.newdl.innerText = 'Save';
		} else {
			delete this.image;
			this.sta.innerText = '';
			this.selrem.innerText = 'Sel';
			this.newdl.innerText = 'New';
		}
		this.drive.set_disk(image);
	}
}
diskui.push(new DiskImageUI('dsk0', disk_templates[0], dsk2_0.units[0]));
diskui.push(new DiskImageUI('dsk1', disk_templates[0], dsk2_0.units[1]));
diskui.push(new DiskImageUI('ffc1', disk_templates[2], main_ffc.unit_1));

function select_crt_color() {
	let color = parseInt(crtcol.value);
	if(isNaN(color) || color < 0 || color >= vt_colors.length) {
		color = 0;
	}
	CONFIG.vt_color_scheme = color;
}
crtcol.addEventListener('change', select_crt_color);
crtcrev.addEventListener('change', function(ev) { CONFIG.vt_reverse = crtcrev.checked; });

function sl_init(ev: KeyboardEvent | MouseEvent) {
	//@ts-ignore
	document.body.removeEventListener(ev.type, sl_init);
	//@ts-ignore
	document.body.addEventListener(ev.type, sl_control);
	return sl_control(ev);
}
function sl_control(ev: KeyboardEvent | MouseEvent) {
	const cl = ev.getModifierState('CapsLock');
	caps_lock = cl;
}
document.body.addEventListener('mouseover', sl_init);
document.body.addEventListener('mouseleave', sl_init);
document.body.addEventListener('keydown', sl_init);
document.body.addEventListener('drop', async function(ev) {
	const dt = ev.dataTransfer;
	ev.preventDefault();
	if (dt == null || dt.files.length < 1) {
		return;
	}
	let file = dt.files[0];
	let accept = false;
	if (file.name.match(/\.(img|dsk|ffi)$/i) != null) {
		let buf = await file.arrayBuffer();
		let im_kind:'empty'|'hawk'|'finch' = 'empty';
		let im_stride = 512;
		for(let i = 0; i < disk_templates.length; i++) {
			const tmpl = disk_templates[i];
			if(file.size == tmpl.size) {
				im_kind = tmpl.kind;
				im_stride = tmpl.stride;
			}
		}
		const loaded_image: DiskImage = {
			type: im_kind,
			stride: im_stride,
			filename: file.name,
			backing_data: buf,
			protect: false,
			data: new Uint8Array(buf)
		};
		if(im_kind == 'hawk') {
			if (diskui[1].image == null) {
				diskui[1].setactive(loaded_image);
				console.log(`loaded disk image as Hawk0 fixed @ ${im_stride} B/sec`);
			} else {
				diskui[0].setactive(loaded_image);
				console.log(`loaded disk image as Hawk0 removable @ ${im_stride} B/sec`);
			}
			accept = true;
		} else if(im_kind == 'finch') {
			diskui[2].setactive(loaded_image);
			if(im_stride == FINCH_TRACK) {
				console.log('loaded disk image as Finch0 Raw Track Data');
			} else {
				console.log(`loaded disk image as Finch0 @ ${im_stride} B/sec`);
			}
			accept = true;
		}
		if(accept && frame_disks.show) disk_view.update();
	}
	if (!accept && (
		file.name.match(/\.bin$/i) != null ||
		file.type === '' ||
		file.type == 'application/octet-stream'
	)) {
		win_load.show(file).then(function(res) {
			console.log('load file', file.name, 'at', res.address, 'as', res.kind);
			const address = res.address;
			const kind = res.kind;
			file.arrayBuffer().then(function(b) {
				let bv = new DataView(b);
				const l = b.byteLength;
				for(let ofs = 0; ofs < l; ofs++) {
					bpl.writebyte((address + ofs) & 0x3ffff, bv.getUint8(ofs));
				}
			});
		}, function() {console.log('cancel file', file.name);});
		accept = true;
	}
	if (!accept) {
		console.log('unknown drop!', file.name, file.type);
	}
});

let editor_loaded = false;

function load_editor() {
	require(['monaco-editor'], function(mod:{
		editor:typeof monaco.editor,
		languages:typeof monaco.languages
	}) {
		editor_loaded = true;
		const monaco = mod;
	monaco.languages.register({
		id: 'centasm',
	});
	monaco.languages.register({
		id: 'cjcl',
	});
	monaco.languages.register({
		id: 'cpl',
	});
	// @ts-ignore
	monaco.languages.setMonarchTokensProvider('centasm', {
		ignoreCase: true,
		defaultToken: 'invalid',
		tokenizer: {
			root: [
				[/TIT[\w@]*/, "function"]
			]
		}
	})
	editors.editor1 = monaco.editor.create(con_assm_edit, {
		value: ` TITLE 'Program'\n BEGIN 0\nFOREVER JMP FOREVER\n END FOREVER\n`,
		language: 'centasm',
		cursorBlinking: 'phase',
		cursorStyle: 'underline',
		rulers: [
			{column:80, color: '#886666'}
		],
		roundedSelection: false,
		selectOnLineNumbers: true,
	});
	let m = editors.editor1.getModel();
	if(m) editors.edit1 = m;
	editors.output1 = monaco.editor.create(con_assm_out, {
		value: 'TEST',
		minimap: {enabled:false},
		readOnly: true,
		cursorBlinking: 'phase',
		cursorStyle: 'underline',
		roundedSelection: false,
		selectOnLineNumbers: true,
	});
	m = editors.output1.getModel();
	if(m) editors.out_m = m;
});
}// */

show_disasm(); // initial disassembly
export const __meisaka = 'meisaka';
