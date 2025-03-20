.log
.job shrink1 abort=cancel
.cancel p07
.del @spool1 1
.new @spool1 1 'q' 20
.start p07 s.unspool @spool1 1 prt1
con
.end
