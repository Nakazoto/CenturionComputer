"use strict";
//@ts-ignore
window.cen_ts_version = 15;
window.addEventListener('load', async function () {
    // hi there
    const view_reg = document.getElementById('view_reg');
    const view_page = document.getElementById('view_page');
    const view_int = document.getElementById('view_int');
    const view_uop = document.getElementById('view_uop');
    const view_dis = document.getElementById('view_dis');
    const view_ffc = document.getElementById('view_ffc');
    const loc_crt0 = [
        document.getElementById('crt0loc_t'),
        document.getElementById('crt0loc_b')
    ];
    const ui_crts = [
        {
            view: document.getElementById('view_crt0'),
            tall: document.getElementById('crttall0'),
            wide: document.getElementById('crtwide0')
        },
        {
            view: document.getElementById('view_crt1'),
            tall: document.getElementById('crttall1'),
            wide: document.getElementById('crtwide1')
        },
        {
            view: document.getElementById('view_crt2'),
            tall: document.getElementById('crttall2'),
            wide: document.getElementById('crtwide2')
        }
    ];
    const opt_rtc = [
        document.getElementById('rtc_0'),
        document.getElementById('rtc_1'),
        document.getElementById('rtc_2')
    ];
    const conv_hex = document.getElementById('conv_hex');
    const conv_ee = document.getElementById('conv_ee');
    const conv_mei = document.getElementById('conv_mei');
    const conv_uew = document.getElementById('conv_uew');
    const dc_fpd = document.getElementById('dcfpd');
    const dc_crt0 = document.getElementById('dccrt0');
    const win_crt1 = document.getElementById('crtc1');
    const win_crt2 = document.getElementById('crtc2');
    const dc_int = document.getElementById('dcint');
    const dc_pages = document.getElementById('dcpages');
    const dc_uop = document.getElementById('dcuop');
    const dc_hawk = document.getElementById('dchawk');
    const dc_ffc = document.getElementById('dcffc');
    const dc_regs = document.getElementById('dcregs');
    const dc_listing = document.getElementById('dclisting');
    const dc_textio = document.getElementById('dc_textio');
    const con_rows = [
        document.getElementById('cd_r1'),
        document.getElementById('cd_r2'),
        document.getElementById('cd_r3'),
        document.getElementById('cd_r4'),
        document.getElementById('cd_r5'),
        document.getElementById('cd_r6'),
    ];
    const con_row1col1 = document.getElementById('cd_r1c1');
    const con_row1col2 = document.getElementById('cd_r1c2');
    const con_row2col2 = document.getElementById('ccr2');
    const con_row6col2 = document.getElementById('cd_r6c2');
    const down_div = document.getElementById('dld');
    const reset_button = document.getElementById('b_reset');
    const step_button = document.getElementById('b_step');
    const run_button = document.getElementById('b_run');
    const run_rate1 = document.getElementById('b_r1');
    const run_rate2 = document.getElementById('b_r2');
    const run_rate3 = document.getElementById('b_r3');
    const run_rate4 = document.getElementById('b_r4');
    const run_rate5 = document.getElementById('b_r5');
    const run_rate6 = document.getElementById('b_r6');
    const run_rate7 = document.getElementById('b_r7');
    const run_rate8 = document.getElementById('b_r8');
    const memory_view = document.getElementById('memview');
    const memory_button = document.getElementById('b_memory');
    const memory_elem = [];
    const win_disk = document.getElementById('diskview');
    const disk_button = document.getElementById('b_disks');
    const micro_button = document.getElementById('b_micro');
    const local_button = document.getElementById('b_local');
    const win_micro = document.getElementById('mclisting');
    const microstep_button = document.getElementById('b_mstep');
    const btn_ss1 = document.getElementById('ss1');
    const btn_ss2 = document.getElementById('ss2');
    const btn_ss3 = document.getElementById('ss3');
    const btn_ss4 = document.getElementById('ss4');
    const btn_ssR = document.getElementById('ssR');
    const btn_ssH = document.getElementById('ssH');
    const btn_ssI = document.getElementById('ssI');
    const btn_dt1 = document.getElementById('diag1');
    const btn_dt2 = document.getElementById('diag2');
    const btn_dt4 = document.getElementById('diag4');
    const btn_dt8 = document.getElementById('diag8');
    const sts_dt1 = document.getElementById('diag1s');
    const sts_dt2 = document.getElementById('diag2s');
    const sts_dt4 = document.getElementById('diag4s');
    const sts_dt8 = document.getElementById('diag8s');
    const btn_settings = document.getElementById('b_settings');
    const win_settings = document.getElementById('wset');
    const btn_dtrun = document.getElementById('diagrun');
    const fp_rf = document.getElementById('fp_r');
    const fp_load = document.getElementById('fp_l');
    const fp_select = document.getElementById('fp_s');
    const fp_addr = document.getElementById('fp_addr');
    const fp_level = document.getElementById('fp_level');
    const fp_perf = document.getElementById('fp_perf');
    const mcs_p = document.getElementById('mcs_p');
    const mcs_s = document.getElementById('mcs_s');
    const mcs_alu = document.getElementById('mcs_alu');
    const mcs_alu2 = document.getElementById('mcs_alu2');
    const mcs_alu3 = document.getElementById('mcs_alu3');
    const mcr_res = document.getElementById('mcr_res');
    const mcr_bus = document.getElementById('mcr_bus');
    const mcr_sys = document.getElementById('mcr_sys');
    const mcr_addr = document.getElementById('mcr_addr');
    const mcr_swap = document.getElementById('mcr_swap');
    const fp_runhalt = [
        document.getElementById('fp_runstate').children[0],
        document.getElementById('fp_runstate').children[1],
    ];
    const fp_extcon = document.getElementById('fp_extstate');
    const fp_ext = [
        document.getElementById('fp_runstate').children[2],
        fp_extcon.children[0],
        fp_extcon.children[1],
    ];
    const mcpage = [
        document.getElementById('mcp_0'),
        document.getElementById('mcp_1'),
        document.getElementById('mcp_2'),
        document.getElementById('mcp_3'),
    ];
    const mcr_file = [
        document.getElementById('mcr_file0'),
        document.getElementById('mcr_file2'),
        document.getElementById('mcr_file4'),
        document.getElementById('mcr_file6'),
        document.getElementById('mcr_file8'),
        document.getElementById('mcr_fileA'),
        document.getElementById('mcr_fileC'),
        document.getElementById('mcr_fileE')
    ];
    const mcr_level = document.getElementById('mcr_level');
    const mcr_rfir = document.getElementById('mcr_rfir');
    const mcr_rfdr = document.getElementById('mcr_rfdr');
    const mcr_pta = document.getElementById('mcr_pta');
    const mcs_op = document.getElementById('mcs_op');
    const mcs_op_alu = document.getElementById('mcs_op_alu');
    const mcs_op_bus = document.getElementById('mcs_op_bus');
    const ffc_op_seq = document.getElementById('ffc_op');
    const ffc_op_alu = document.getElementById('ffc_op_alu');
    const ffc_op_bus = document.getElementById('ffc_op_bus');
    const ffc_addr = document.getElementById('ffc_addr');
    const ffc_ctrl = document.getElementById('ffc_ctrl');
    const ffc_ipl = document.getElementById('ffc_ipl');
    const ffc_sys = document.getElementById('ffc_sys');
    const ffc_status = document.getElementById('ffc_status');
    const ffc_track = document.getElementById('ffc_track');
    const ffc_disk = document.getElementById('ffc_disk');
    const ffc_alu = document.getElementById('ffc_alu');
    const ffc_alu2 = document.getElementById('ffc_alu2');
    const ffc_alu3 = document.getElementById('ffc_alu3');
    const ffc_log = document.getElementById('ffc_log');
    const d_listing = document.getElementById('listing');
    const d_listingc = document.getElementById('listingc');
    const d_micro = document.getElementById('micro');
    const in_diagins = document.getElementById('diagins');
    const in_dbgcmd = document.getElementById('dbgcmd');
    const btn_cm_import = document.getElementById('cm_imp');
    const btn_cm_tocrt = document.getElementById('cm_vki');
    const btn_cm_clear = document.getElementById('cm_clear');
    const txt_anno = document.getElementById('anno');
    const cv_diag = document.getElementById('fp_diag');
    const cx_diag = cv_diag.getContext('2d');
    const RUNRATES = [1, 10, 100, 1000, 10000, 50000, 100000, 150000];
    const CONFIG_LL = {
        0: [],
        1: [[false, false, false, false], 0, 0],
        2: [0],
        3: [false],
        4: [false, false, 1],
        5: [false, 13],
        16: [
            [/*0:viewopts*/ [true, false, false, false]],
            [/*0:viewopts*/ [false, false, false, false]],
            [/*0:viewopts*/ [false, false, false, false]]
        ],
        //17: [ // MUX[]
        //[]
        //],
        //18: [ // DSK[]
        //],
        19: [ // Hawk[]
        ],
        20: [
            [true, false]
        ]
    };
    const CONFIG = {
        uicore: CONFIG_LL[0],
        cpu: CONFIG_LL[1],
        emu: CONFIG_LL[2],
        net: CONFIG_LL[3],
        disassm: CONFIG_LL[4],
        diag: CONFIG_LL[5],
        crt: CONFIG_LL[16],
        ffc: CONFIG_LL[20], // ffc[]
    };
    const diskui = [];
    function style_if(elem, domclass, cond) {
        if (cond) {
            elem.classList.add(domclass);
        }
        else {
            elem.classList.remove(domclass);
        }
    }
    function display_if(elem, cond) {
        if (cond) {
            elem.style.removeProperty('display');
        }
        else {
            elem.style.display = 'none';
        }
    }
    class FrameManager {
        constructor() {
            this.frames = [];
            this.drag_origin_x = 0;
            this.drag_origin_y = 0;
            this.last_client_x = 0;
            this.last_client_y = 0;
            window.addEventListener('mousemove', (ev) => {
                let nx = 0, ny = 0;
                if (this.drag_frame) {
                    this.last_client_x = ev.clientX;
                    this.last_client_y = ev.clientY;
                    nx = this.drag_origin_x + ev.clientX;
                    ny = this.drag_origin_y + ev.clientY;
                    if (!this.drag_frame.fixed) {
                        nx += (window.scrollX | 0);
                        ny += (window.scrollY | 0);
                    }
                    if (nx < -10)
                        nx = -10;
                    if (ny < -10)
                        ny = -10;
                    this.drag_frame.base.style.left = `${nx}px`;
                    this.drag_frame.base.style.top = `${ny}px`;
                    ev.preventDefault();
                }
            });
            window.addEventListener('mouseup', (ev) => {
                delete this.drag_frame;
            });
            window.addEventListener('scroll', (ev) => {
                if (this.drag_frame && !this.drag_frame.fixed) {
                    let nx = this.drag_origin_x + this.last_client_x + (window.scrollX | 0);
                    let ny = this.drag_origin_y + this.last_client_y + (window.scrollY | 0);
                    if (nx < -10)
                        nx = -10;
                    if (ny < -10)
                        ny = -10;
                    this.drag_frame.base.style.left = `${nx}px`;
                    this.drag_frame.base.style.top = `${ny}px`;
                }
            });
        }
        raise_frame(frame) {
            let l = this.frames.indexOf(frame);
            if (l == -1) {
                this.frames.push(frame);
            }
            else {
                let i = l;
                for (; i < this.frames.length - 1; i++) {
                    this.frames[i] = this.frames[i + 1];
                    this.frames[i].base.style.zIndex = `${i + 1}`;
                }
                this.frames[i] = frame;
                frame.base.style.zIndex = `${i + 1}`;
            }
        }
        toggle_show_raise(frame) {
            let vis = !frame.show;
            frame.show = vis;
            if (vis)
                this.raise_frame(frame);
        }
        begin_drag(frame, event) {
            this.drag_frame = frame;
            const szre = /^(-?[0-9]+)([a-z%]*)$/;
            let reres = szre.exec(frame.base.style.left);
            let f_x = 0;
            let f_y = 0;
            if (reres != null && reres[1] != '') {
                f_x = parseInt(reres[1]);
            }
            reres = szre.exec(frame.base.style.top);
            if (reres != null && reres[1] != '') {
                f_y = parseInt(reres[1]);
            }
            let t_x = f_x - event.clientX;
            let t_y = f_y - event.clientY;
            if (!frame.fixed) {
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
        constructor(basis) {
            this.base = basis;
            this._show = this.base.style.display != 'none';
            if (this._show)
                this.base.style.display = 'flex';
            this._fixed = this.base.style.position == 'fixed' || this.base.style.position == '';
            if (basis.children.length < 2)
                throw (new Error("bad content format"));
            this.header = basis.children[0];
            this.title = this.header.children[0];
            this.content = basis.children[1];
            if (this.header.tagName.toUpperCase() != "DIV")
                throw (new Error("bad content format"));
            if (this.content.tagName.toUpperCase() != "DIV")
                throw (new Error("bad content format"));
            frame_manager.frames.push(this);
            this.base.addEventListener('mousedown', (ev) => {
                frame_manager.raise_frame(this);
            });
            this.header.addEventListener('mousedown', (ev) => {
                ev.preventDefault();
                frame_manager.begin_drag(this, ev);
            });
        }
        get show() {
            return this._show;
        }
        set show(v) {
            this._show = v;
            this.base.style.display = this._show ? 'flex' : 'none';
        }
        get fixed() {
            return this._fixed;
        }
    }
    const frame_crt1 = new ModFrame(win_crt1);
    const frame_crt2 = new ModFrame(win_crt2);
    const frame_memory = new ModFrame(memory_view);
    const frame_disks = new ModFrame(win_disk);
    const frame_mclist = new ModFrame(win_micro);
    const win_load = (function () {
        let accept_fn = null;
        let cancel_fn = null;
        function do_cancel() {
            let f = cancel_fn;
            accept_fn = null;
            cancel_fn = null;
            if (f != null) {
                f();
            }
        }
        const con_win = document.getElementById('wload');
        const file_name = document.getElementById('wload_fn');
        const file_type = document.getElementById('wload_ft');
        const file_size = document.getElementById('wload_fs');
        const load_addr = document.getElementById('wload_addr');
        const load_opt = [
            document.getElementById('wload_lt0'),
            document.getElementById('wload_lt1')
        ];
        const o = {
            show(file) {
                do_cancel();
                file_name.innerText = file.name;
                file_type.innerText = file.type;
                file_size.innerText = `${file.size} (0x${hex(file.size, 1)}) bytes`;
                con_win.style.display = '';
                return new Promise(function (resolve, reject) {
                    accept_fn = resolve;
                    cancel_fn = reject;
                });
            },
            hide() {
                con_win.style.display = 'none';
            }
        };
        document.getElementById('wload_h').addEventListener('click', function (ev) {
            o.hide();
            let f = accept_fn;
            accept_fn = null;
            cancel_fn = null;
            if (f != null) {
                let address = parseInt(load_addr.value, 16);
                if (isNaN(address)) {
                    address = 0x100;
                }
                let r = { address, kind: '' };
                if (load_opt[0].checked) {
                    r.kind = 'raw';
                }
                f(r);
            }
        });
        document.getElementById('wload_c').addEventListener('click', function (ev) {
            o.hide();
            do_cancel();
        });
        return o;
    })();
    const cv_term0 = document.getElementById('term0');
    const cv_term1 = document.getElementById('term1');
    const cv_term2 = document.getElementById('term2');
    const cv_map = document.getElementById('fp_flagsc');
    const cx_map = cv_map.getContext('2d');
    const cv_addr = document.getElementById('fp_addrc');
    const cx_addr = cv_addr.getContext('2d');
    const cv_level = document.getElementById('fp_levelc');
    const cx_level = cv_level.getContext('2d');
    cx_diag.fillStyle = '#ff3232';
    cx_diag.font = '16px Consolas, "Envy Code R", monospace';
    cx_map.font = '20px Consolas, "Envy Code R", monospace';
    cx_addr.font = '10px Consolas, "Envy Code R", monospace';
    cx_level.font = '20px Consolas, "Envy Code R", monospace';
    let show_reg = view_reg.checked;
    let show_page = view_page.checked;
    let show_int = view_int.checked;
    let show_uop = view_uop.checked;
    let show_dis = view_dis.checked;
    let show_ffc = view_ffc.checked;
    let show_mem = false;
    let run_ctl = 0;
    let run_rate = 10000;
    let run_step = false;
    let run_busy = false;
    let dis_after = false;
    let memv_after = false;
    let run_follow = false;
    let last_pc = 0;
    let last_map = 0;
    let dis_vpc = 0x100;
    let dis_map = 0;
    let dis_ppc = 0x100; // computed from vpc
    let dis_ppc_end = 0x200; // computed from vpc
    let memv_begin = 0;
    let memv_end = 0;
    let run_accu = 0;
    let run_accutime = 0;
    let run_once = false;
    const run_hw = [];
    const run_hshw = [];
    let hs_wait = 0;
    let run_stop;
    function do_run_stop() {
        if (run_stop) {
            run_stop();
            run_stop = null;
        }
    }
    function run_hw_steps(inc) {
        for (let i = 0; i < run_hw.length; i++) {
            run_hw[i].run(inc);
        }
    }
    function run_hshw_steps() {
        for (let i = 0; i < run_hshw.length; i++) {
            run_hshw[i].run(5);
        }
    }
    function run_control(run) {
        if (!run && (run_ctl !== 0)) {
            clearInterval(run_ctl);
            fp_ext[1].classList.remove('a');
            run_ctl = 0;
            run_step = false;
            if (!run_busy) {
                do_run_stop();
                mcsim.step(true);
                mcsim.showstate(true);
                main_ffc.step(true);
            }
            return;
        }
        if (run && (run_ctl == 0)) {
            run_once = true;
            fp_ext[1].classList.add('a');
            run_ctl = setInterval(function () {
                run_busy = true;
                let runtime = Date.now();
                if (run_rate > 10000) {
                    let hsr = (run_rate / 100) | 0;
                    mcsim.hspre();
                    for (let i = 0; i < hsr; i++) {
                        run_hw_steps(100);
                        for (let ql = 0; ql < 20; ql++) {
                            mcsim.hsstep();
                            mcsim.hsstep();
                            mcsim.hsstep();
                            mcsim.hsstep();
                            mcsim.hsstep();
                        }
                        if (run_ctl == 0) {
                            do_run_stop();
                            break;
                        }
                    }
                    mcsim.hsend();
                }
                else {
                    for (let i = 0; i < run_rate; i++) {
                        run_hw_steps(1);
                        mcsim.step(false);
                        if (run_ctl == 0) {
                            do_run_stop();
                            break;
                        }
                    }
                    mcsim.step(true);
                }
                runtime = Date.now() - runtime;
                run_accutime += runtime;
                run_accu += run_rate;
                run_busy = false;
                if (run_ctl == 0) {
                    mcsim.showstate(true);
                }
                else {
                    mcsim.showstate(false);
                }
                main_ffc.step(true);
                if (dis_after)
                    show_disasm();
                if (memv_after)
                    update_memview();
            }, 20);
        }
    }
    function handle_break() {
        if (run_once)
            return false;
        run_control(false);
        dis_after = show_dis;
        return true;
    }
    this.setInterval(function () {
        let runtime = run_accutime;
        let runcount = run_accu;
        run_accutime = 0;
        run_accu = 0;
        fp_perf.innerText = runcount.toString().padStart(6, '0') + ':' + (run_rate >= 10000 ? 'F' : 'R') + ':' + runtime.toString().padStart(4, '0');
    }, 1000);
    function bload(v) {
        const bv = atob(v);
        const a = new Uint8Array(bv.length);
        let i = 0;
        for (let c of bv) {
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
    const wipl_test = bload(`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
AAAAAAAAAA==`);
    const wipl_dump = bload(`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
AAAAAA==`);
    const diag = {
        f1: bload(`ADqxuAAFDqHxT6HyDaHyD5DAAF8iMhQLkIB3sQD+OrEA/HY6ofEJofELofENofEPgfEQwA9CMaHx
EKHxBsANSRUDcYcowfEQFrc90IBVWJmh8Qh1AIABgI6BG4GDgdyCA4JHgoSC44N/hG+FnYayhyiA
AYABc4otLS0twA9I4fEQofEMofELofEGOnEAADJAwBEvQi8DUUAVQ8AhL0AvAVFAFTkgUCBAFeaQ
ABJcVWC7IHAgcBX3kAASXICoQXEUBZtRYBUVIHAgcBXvofEKgfEQwA9CMSkVnHOzwDF7BHPuc5Lh
8RCh8Quh8QyB8RAtFiCh8QeQAGQOORX8ofEGkABkDjkV/JAPAIHxEEIBFdNzz4HxEMAPShTHCZCB
cbEA/pAPAIHxEEIBKSkVtJABAF0WBvUBc/lzqpABANhZFSY4OBf4kAEAXFVgO7VhVWYX95ABAFyb
XTMgUWIVCZVhF/Sh8QpztYDwQgEoKE17yHOqwARJFANxgHeA8EKBKChNcYB+YAAQkBAAQFC1SAyQ
gaO1SA6QABBAFRXrkBAAVQwKcwNVxApgABCVSASA8EIQRVHAEEAxQRAVF0A1Feuh8QqQDwCB8RBC
ASkpKRS1cYABRVEoKChNeYDjc6eAxaHyAJAPAIHxEEIBKSkpKRQDcYABgfIALCwR6IDVofIBeykE
c96AxaHyAJAPAIHxEEIBwAVJFANxgAGB8gAsEeqB8gGh8gF7AwVz34HyAMAcShUFofEKPglFMS0t
xUFIofELofEM4fEQCYDFofIAgAah8gqQgm+xAG46sQBsBKHyDpAPAIHxEEIBwAZJFPNxgAGB8g8V
DZHyAKHyAZEACl97qQYKc+syQFVGRVGh8UAoofFBKKHxQiih8UPB8UCAB0pCcUkVOCBwwCeB8UFB
cRUvIHDAN4HxQkFxFSQgcMBHgfFDQXEVGYAPwfEQSoAHSRQDcYABIFAVr6HxCnOqwBd5gONzo6Hx
TTJAkP//e1IVRFVAPT09PXtIFTqB8RDAD0qACEkUA3GAAT4+kAMsUUAV3z8/VUA9PT09eyUVF4Hx
EMAPSoAISRQDcYABPz8X5KHxCnOwLS0tLcAISHmA43OkXRcLOqHxQLHxQYADcwmx8UEqofFAgAKh
8UiQAZDQIADB8UVCIxUIDjkV8oAJcwWB8UR7AQlNFQEJKigkMBH7CaHxTZD//3u4FSqQMr+x8UGQ
/m8vApABAC8ALwQvBiqh8Uh5hFLAIEoVGU0VBMCpcw15g3Sh8U0tLS0twAlIeYDjc72QhGexAC46
sQAsofFPofFOBGAAAdAPCYHxEEIhSRQDcYABKqEAIFVAeYM/FcSBACAVBMC5c8UqoQAgkOb/LwKQ
AQAvAC8GKqHxSHtEFaCBACAVBMDJc6QvAzgUBMDZc5svAdAaAFkUBMDpc4+QAA9QQNHxQVkUBMD5
c+M1QIAZDikV/JBAAFFAFYqh8Qpxg3+QAZDB8UQkMBEHDjkV9YAJCYHxRAkgAKHxTwpz+LWiofEK
sQAQkAAS9QFtAVVi9QFVgvUBVaIwIDAg9QFVwvUBVeL1AYDFofIAhaF7eoWhe3bAXHtne1dFMcBN
SRQzwEdJFArAUUkV6ZCAAXMEe3lVgLEAINAAHplVDpUiVQyVIl+VIl6VIlxlItUikQAQcgAge1VV
hot7L3tORZHBv5IUAasTBDBgc/ARpzBgc+d7VYHyACwR+IHyAcB/SoHyACwsEfnh8gEJewVFAXsB
CSIANgA2ADYANgAmAMAKSRYFwDdIc9jAMHP5Ol6hv5J7v3slFwEJNYA1gDWANYBDGYABob+Sc+iA
D8HxEEqACkkVAQlxgAFzpkUxwDBJFhPAR0kXHsBAShQEwAlAMcAPQjEJwCBJFQIrCcAsSRUEAgcr
CcAKe9DAf3vMKisJofINofFNofEKgMWkeoCMofIBDg57cMS9AHt8wMhJ5aIUBcDGSRVOe27AUEAx
FkbFoRR9wANJGD3QDwD1ojIg9aLAiOWi0IMA9aLQgQAGJzApF/v1oi8ULwYvoJD/9i8CeyJDkAEA
LwCQ8P8vAnt+RRUDcQEDew+NisXS0s/SjYoAB3OQc2eB8gAsLBH5hUEVAQmh8gFz73tthOwsEfmE
88CAQzHA4EkWBMDfQjGk5AnAB0kYwKHxQJQt0AAQWhS1OrHxQXs1A5Qe0AQAWhWm0AAgWhTyLwQv
BpABAC8AkOofLwJ7FgCB8UQVinOFhUGh+ACB+AEpFfqE9gmFQaHxSITlLBD7CYAPwfEQSoALSRUB
CXGAAdAPDIHxEEIhSRQDcYABYIAAOoVBQBDQh/lRQhX1ikEBFUmQuABbXNAEAKg4MSAV+tAEAIpB
URU6PjEgFfbQBABVZEVRK6VBMSAV99AEAFVkiitBURUcPjEgFfWh8Qyh8Qqh8Q6AiKHxEHOVwBx5
gONzjsAsc/eh8QiAxaHyAA55hiOMm5zB1djJzMnB0tmg1MXT1NONiooAYIgAOlyVQRkh0Af/WRgb
MGDQ+ABSQlAgtaJVYHmFGcC9eYUOxUEV+XPb0PgAUiSQCABQBJDwAFFAFcp5hiONisXO1MXSoNTF
09SgztXNwsXSugAyQIAPwfEQSoANSRQDcYABgfIALBHswfIBgF9BMRkDgN9K4fIBeYVoFgw1QDVA
NUA1QEMVc8xVQBgDcYcoUWAW+VVAPTs40MAAUCCYVSpggAHQ+ABaVSih8Q51AD4AAAAAAAA=`),
        f2: bload(`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`),
        f3: bload(`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`),
        f4: bload(`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`),
    };
    const uc = {
        c0: new Uint32Array(2048),
        c1: new Uint32Array(2048),
        e: bload(`wAAADQABDS2TUnAAUJoAACAAGgoQEAEACoAAAAEQAAAAAAAAgAENAAAAcC0AAAAtCQoAABAQAAAA
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
        f: bload(`qwABEwFjAEs5AwEBAQMBAKIBAQABgQABCzEbAAMBSwE7ASOjAVNLiwABGwEDAQHLABu7AQGBAYEj
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
        h: bload(`xgAD/gN+//9/fgMDA3/GAC8Df3lzcn8DfwKSAH5yLmotAgZxA37/8goCDv4yAgI2/n8HAnNyAlIv
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
        j: bload(`gQAA9ACEgIABgoQAbxPIAEB0AIIAhgBgAIGAAIDChMDAgIKAAISAgICEhICIhICAgAQA9ACGgMBA
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
        k: bload(`QgBAQMDgQEBAYEBAQEBEAERAQEBGxkBAQEBAAADgQEBAQPBBwOBAQlBASEBQQOBBQEBBQEXFQEpA
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
        l: bload(`GAD+HvwY+Pj/GZn+//8cAP7//5j8G/7//xgeABAbGKCYHB2Y/Br4Fh0HeAAXHBwVHPn+GPwbHrj/
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
        m: bload(`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`),
        map: bload(`iwEZT4uLha97k4uOyn6Li/39/Pz7+/r6Vvn+7t7Ougfv7+/v7+/v7x0eIiMkIYuL+Pj4+Pj4+Pgu
LyolTU4fH0VFRUVFRUugQUFBQEBAQECJiYmJiYl8fUNDQ0BAQEBAFGVlZWVlt7AxZGRkZGRQUwlU
VFRUVIuJiWRkZGRkkJAbUVFRUVGLPTM1NTU1NTU1FVRUVFRUiwkzNTU1NTU1NStRUVFRUYsJMzU1
NTU1NTU8VFRUVFSLCTM1NTU1NTU1LGBgYGBgiwk0NjY2NjY2Nj5iYmJiYmuLNDY2NjY2NjYmYGBg
YGCLCTQ2NjY2NjY2MGJiYmJiixM0NjY2NjY2Ng==`)
    };
    const ffcmc = {
        r1: bload(`AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
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
        r2: bload(`f8/fH4+f/58Pn/i/j58vb8+f/8/6v/////////////+Pn6/P/4///6n//////////////4+a/4+a
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
        r3: bload(`AwMDAwMDowMDA0MDAwMDAwMDEwMDAwMDU1NTU1NTEwMDAwMDEwNzEwMTE1NTU1NTU1MTEwMDEwMD
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
        r4: bload(`BAgAAAD/+gAAAAAACgEx/gCQtQgA8AAA2uHh1HNpEgAIAAAAEgARHgC7H8zhxeGzg4IetQ8AtRAA
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
        r5: bload(`AKDw4AAAAAAAAAAAAAAAAAAAAAAAEBABAQEBAQEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
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
        r6: bload(`h4eHh4eHmoeHz4eHh4ePh8SHh4f3h8HRgICAgICAh4eHgoKHh4Slh/eHh5SUlJSUlJSHh4f3h4f3
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
        r7: bload(`AAEBAwEBgAEBAQEBAQEBAQEBAQEDAwADgICAgICBAAABAQEBAQEBAQEBAYODg4ODg4MBAQGBAQGB
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
        r8: bload(`AQEBAQEBBgEBBQIBAQEBAQEBhAEBAQEBBgYGBgYGAAEBAQEBBgEQBgGEBgYGBgYGBgYGhAEBhAEB
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
        tsm: bload(`pRn/l/8T/xP///////////8TgDH/lxMe/xv/khn/HP+18LD//6dkLv8r/6Ip/yz//zSg/zq3wbb/
Oz2yOSY8//9xw8X/xnb//////////////////////////////////////xb//////////////7Vy
c3X/wnd5/3D//////7Wlgf+X/4X/Ef///////////5OAsf+Xkx7/G/+SGf8c/7X/sP//p+Qu/yv/
oin/LP+VtKD/urfBtv87vbI5pjz//3HDxf/Gdv//////////////////////////////////////
lv//////////////tXJzdf/Cd3n/cP//////tQ==`),
        mfm: bload(`ICABAQAAAQEgIAEBAAABASAIAQIAAAQBECABAgAABAE=`)
    };
    const mclisting = [];
    const disk_images = {};
    function export_disk(image) {
        const unitdata = image;
        if (unitdata == null)
            return;
        const link = document.createElement('a');
        let filename = unitdata.filename;
        let ext_at = unitdata.filename.lastIndexOf('.');
        if (ext_at > -1)
            filename = filename.substring(0, ext_at);
        const reg = /(_EX)([0-9]+)(?:\.\w*)?$/i;
        if (filename.match(reg) != null) {
            filename = filename.replace(reg, function (v, x, n) { return `${x}${(parseInt(n) + 1).toString().padStart(3, '0')}`; });
        }
        else {
            filename += '_EX000';
        }
        filename += '.IMG';
        const ex_blob = new Blob([unitdata.backing_data], { type: 'application/octet-stream' });
        link.download = filename;
        const url = URL.createObjectURL(ex_blob);
        link.href = url;
        down_div.appendChild(link);
        link.click();
        setTimeout(function () {
            down_div.removeChild(link);
            URL.revokeObjectURL(url);
        }, 0);
    }
    const vt_width = 8;
    const vt_height = 10;
    const vt_font_data = new ImageData(128, 160);
    function update_font_data(main_color) {
        const vtf = new Uint32Array(vt_font_data.data.buffer);
        let vrow = 0;
        let vcrow = 0;
        let vcid = 0;
        for (let y = 0; y < 160; y++) {
            const line0 = y * 128;
            const vtline = ((vcid * 8) + vcrow) * 16;
            if (vrow > 1 || vcid >= 8)
                for (let x = 0; x < 128; x++) {
                    let bs = (x & 7);
                    let v = (vtfont[vtline + (x >> 3)] >> bs) & 1;
                    if (v > 0) {
                        vtf[line0 + x] = 0xff000000 | main_color;
                        if (bs > 0) {
                            vtf[line0 + x - 1] |= 0x2f000000 | main_color;
                        }
                        if (bs < 7) {
                            vtf[line0 + x + 1] |= 0x2f000000 | main_color;
                        }
                    }
                }
            if (vrow > 1 && vcrow < 7)
                vcrow++;
            if (++vrow >= 10) {
                vrow = 0;
                vcrow = 0;
                vcid++;
            }
        }
    }
    update_font_data(0xf0aa66);
    //update_font_data(0xc0aaaa);
    //update_font_data(0x147ae0);
    const vt_font_bmp = await createImageBitmap(vt_font_data);
    const vtctrlkeys = {
        Digit2: 0, KeyA: 1, KeyB: 2, KeyC: 3,
        KeyD: 4, KeyE: 5, KeyF: 6, KeyG: 7,
        KeyH: 8, KeyI: 9, KeyJ: 10, KeyK: 11,
        KeyL: 12, KeyM: 13, KeyN: 14, KeyO: 15,
        KeyP: 16, KeyQ: 17, KeyR: 18, KeyS: 19,
        KeyT: 20, KeyU: 21, KeyV: 22, KeyW: 23,
        KeyX: 24, KeyY: 25, KeyZ: 26, BracketLeft: 27,
        Backslash: 28, BracketRight: 29, Digit6: 30, Minus: 31,
    };
    const fn_key_norm = ['1', '2', '3', '4', '5', '6', '7', '8'];
    const fn_key_shift = ['!', '"', '#', '$', '%', '&', "'", '('];
    class VTerm {
        constructor(c, div_crt) {
            this.buffer = new Uint8Array(80 * 24);
            this.show_ui = true;
            this.blink = false;
            this.cursor_x = 0;
            this.cursor_y = 0;
            this.input_interval = 0;
            this.input_buf = [];
            this.import_buf = [];
            this.input_control = false;
            this.mux = null;
            this.esc_mode = 0 /* VTEscapeModes.NORMAL */;
            this.esc_extra = 0;
            this.vbel_id = 0;
            this.vcontrol = false;
            const vctrl = div_crt.children[0];
            this.vbell = div_crt.children[1];
            const lok = div_crt.children[2].children[0];
            let fnkeys = [
                div_crt.children[3],
                div_crt.children[4],
                div_crt.children[5],
                div_crt.children[6],
                div_crt.children[7],
                div_crt.children[8],
                div_crt.children[9],
                div_crt.children[10]
            ];
            const canv = c;
            const self = this;
            const ctx = c.getContext('2d');
            this.canv = canv;
            this.ctx = ctx;
            ctx.fillStyle = '#6ac';
            ctx.strokeStyle = '#6ac';
            let i = 20;
            let k = 80 * 2;
            this.buffer[k + i] = 128;
            this.buffer[k + 80 + i] = 164;
            this.buffer[k + 160 + i] = 164;
            this.buffer[k + 240 + i] = 136;
            i++;
            const s1 = '   Centurion VI Simulator   ';
            //@ts-ignore
            const s2 = `   2023 v0.${window.cen_ts_version}  by Meisaka   `;
            const len = s1.length;
            for (let c = 0; c < len; c++) {
                this.buffer[k + i] = 160;
                this.buffer[k + 80 + i] = s1.charCodeAt(c);
                this.buffer[k + 160 + i] = s2.charCodeAt(c);
                this.buffer[k + 240 + i] = 160;
                i++;
            }
            this.buffer[k + i] = 132;
            this.buffer[k + 80 + i] = 164;
            this.buffer[k + 160 + i] = 164;
            this.buffer[k + 240 + i] = 140;
            this.cursor_y = 7;
            this.cursor_x = 0;
            c.addEventListener('keypress', function (ev) {
                ev.preventDefault();
            });
            if (vctrl)
                vctrl.addEventListener('click', function (ev) {
                    self.vcontrol = !self.vcontrol;
                    style_if(this, 'active', self.vcontrol);
                    canv.focus();
                });
            c.addEventListener('keydown', function (ev) {
                //console.log(ev.key.toUpperCase().charCodeAt(0));
                self.clear_buffer();
                if (ev.ctrlKey || self.vcontrol) {
                    let vcc = vtctrlkeys[ev.code];
                    if (vcc !== undefined) {
                        self.receive(vcc);
                        self.input_control = true;
                    }
                    self.vcontrol = false;
                    if (vctrl)
                        vctrl.classList.remove('active');
                }
                else if (ev.key.length == 1) {
                    if (lok && lok.checked) {
                        self.receive(ev.key.toUpperCase().charCodeAt(0));
                    }
                    else {
                        self.receive(ev.key.charCodeAt(0));
                    }
                }
                else
                    switch (ev.key) {
                        case 'Backspace':
                            self.receive(8);
                            break;
                        case 'Tab':
                            if (ev.shiftKey) {
                                self.receive(27);
                                self.receive(79);
                            }
                            else
                                self.receive(9);
                            break;
                        case 'Enter':
                            self.receive(13);
                            break;
                        case 'Escape':
                            self.receive(27);
                            break;
                        case 'ArrowUp':
                            self.receive(26);
                            break;
                        case 'ArrowDown':
                            self.receive(10);
                            break;
                        case 'ArrowLeft':
                            self.receive(21);
                            break;
                        case 'ArrowRight':
                            self.receive(6);
                            break;
                        case 'Home':
                            self.receive(1);
                            break;
                    }
                ev.preventDefault();
            });
            c.addEventListener('keyup', function (ev) {
                ev.preventDefault();
            });
            if (fnkeys)
                for (let i = 0; i < fnkeys.length && i < 8; i++) {
                    const norm = fn_key_norm[i];
                    const shift = fn_key_shift[i];
                    fnkeys[i].addEventListener('click', function (ev) {
                        if (ev.shiftKey)
                            self.send_fn(shift);
                        else
                            self.send_fn(norm);
                        self.vcontrol = false;
                        if (vctrl)
                            vctrl.classList.remove('active');
                    });
                }
            this.update_screen();
        }
        run(increment) {
            if (this.import_buf.length > 0) {
                this.input_interval -= increment;
                if (this.input_interval < 1) {
                    this.check_read();
                }
            }
        }
        render_cell(cellx, celly, clear = true) {
            const vcx = cellx * vt_width;
            const vcy = celly * vt_height;
            const vca = celly * VTerm.columns + cellx;
            const vcc = this.buffer[vca];
            if (clear)
                this.ctx.clearRect(vcx, vcy, vt_width, vt_height);
            const vtfx = (vcc & 15) * 8;
            const vtfy = (vcc >> 4) * 10;
            //this.ctx.strokeText(this.chardec(vcc), vcx, vcy + VTerm.char_base);
            this.ctx.drawImage(vt_font_bmp, vtfx, vtfy, 8, 10, vcx, vcy, 8, 10);
            if (this.blink && cellx == this.cursor_x && celly == this.cursor_y) {
                this.ctx.fillRect(vcx, vcy + 8, vt_width, 2);
            }
        }
        update_blink() {
            this.blink = !this.blink;
            this.render_cell(this.cursor_x, this.cursor_y);
        }
        chardec(c) {
            if ((c < 32) || (c > 127))
                return 0;
            return c - 32;
        }
        update_screen() {
            this.ctx.clearRect(0, 0, this.canv.width, this.canv.height);
            for (let r = 0; r < VTerm.rows; r++) {
                for (let col = 0; col < VTerm.columns; col++) {
                    this.render_cell(col, r, false);
                }
            }
        }
        scroll() {
            for (let r = 1; r < VTerm.rows; r++) {
                const celly = r - 1;
                const vcb = r * VTerm.columns;
                for (let col = 0; col < VTerm.columns; col++) {
                    const vca = celly * VTerm.columns + col;
                    this.buffer[vca] = this.buffer[vcb + col];
                }
            }
            const end_row = VTerm.rows - 1;
            for (let vcx = 0; vcx < VTerm.columns; vcx++) {
                const vca = end_row * VTerm.columns + vcx;
                this.buffer[vca] = 32;
            }
            this.update_screen();
        }
        advance_line() {
            const lasty = this.cursor_y;
            this.cursor_y++;
            if (this.cursor_y >= VTerm.rows) {
                this.cursor_y = VTerm.rows - 1;
                this.scroll();
            }
            else {
                this.render_cell(this.cursor_x, lasty);
                this.render_cell(this.cursor_x, this.cursor_y);
            }
        }
        advance_cursor() {
            const lastx = this.cursor_x;
            const lasty = this.cursor_y;
            this.cursor_x++;
            if (this.cursor_x >= VTerm.columns) {
                this.cursor_x = 0;
                this.cursor_y++;
                if (this.cursor_y >= VTerm.rows) {
                    this.cursor_y = VTerm.rows - 1;
                    this.scroll();
                    return;
                }
            }
            this.render_cell(lastx, lasty);
            this.render_cell(this.cursor_x, this.cursor_y);
        }
        send_fn(a) {
            this.receive(2);
            this.receive(a.charCodeAt(0));
            this.receive(13);
            this.canv.focus();
        }
        write(c) {
            const lastcurx = this.cursor_x;
            const lastcury = this.cursor_y;
            const vca = lastcury * VTerm.columns + lastcurx;
            c = c & 255;
            if (this.esc_mode > 0 /* VTEscapeModes.NORMAL */) {
                const last_mode = this.esc_mode;
                this.esc_mode = 0 /* VTEscapeModes.NORMAL */;
                switch (last_mode) {
                    case 2 /* VTEscapeModes.SEL_ROW */:
                        this.esc_extra = c - 32;
                        this.esc_mode = 3 /* VTEscapeModes.SEL_COL */;
                        return;
                    case 3 /* VTEscapeModes.SEL_COL */:
                        c -= 32;
                        if (c < VTerm.columns && this.esc_extra < VTerm.rows) {
                            this.cursor_x = c;
                            this.cursor_y = this.esc_extra;
                            this.render_cell(lastcurx, lastcury);
                            this.render_cell(this.cursor_x, this.cursor_y);
                        }
                        return;
                    case 4 /* VTEscapeModes.VTAB */:
                        c = c & 0x1f;
                        if (c < VTerm.columns) {
                            this.cursor_x = c;
                            this.cursor_y = this.esc_extra;
                            this.render_cell(lastcurx, lastcury);
                            this.render_cell(this.cursor_x, this.cursor_y);
                        }
                        return;
                    case 5 /* VTEscapeModes.VATTR */:
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
                        // 64   constant normal
                        // 74   constant reverse
                        // 6c   print-only
                        // 7c   print-only reverse
                        console.log('vtt: unhandled attr');
                        return;
                    case 6 /* VTEscapeModes.HADDR */:
                        // convert to col address
                        c = c & 0x7f;
                        c = ((c >> 4) * 10) + (c & 0xf);
                        if (c >= VTerm.columns)
                            c = c - VTerm.columns;
                        this.cursor_x = c;
                        this.render_cell(lastcurx, lastcury);
                        this.render_cell(this.cursor_x, this.cursor_y);
                        return;
                }
                switch (c) {
                    case 5: // transmit status message
                        console.log('vtt: unhandled status');
                        break;
                    case 48: // set vis attr
                        this.esc_mode = 5 /* VTEscapeModes.VATTR */;
                        break;
                    case 49: // begin line drawing
                        console.log('vtt: unhandled line drawing');
                        break;
                    case 50: // end line drawing
                        break;
                    case 51: // begin transparent mode
                    case 52: // end transparent mode
                        console.log('vtt: unhandled transparent');
                        break;
                    case 71: // erase unprotected + home cursor
                    case 75: // erase unprotected from cursor to next field (or EOL if null form)
                        break;
                    case 79: // back tab: cursor to previous unprotected field
                        break;
                    case 82: // enter forms mode
                        console.log('vtt: unhandled Forms');
                        break;
                    case 88: // print variable/print-only data to aux port
                        break;
                    case 89: // set cursor addr
                        this.esc_mode = 2 /* VTEscapeModes.SEL_ROW */;
                        break;
                    case 90: // show next control code
                        this.esc_mode = -1 /* VTEscapeModes.SHOW_CTRL */;
                        break;
                    case 107: // erase unprotected from cursor to end of screen
                    case 115: // reset
                        console.log('vtt: unhandled ECE/RST');
                        break;
                    case 120: // print all data to aux port
                        break;
                    default: break;
                }
                return;
            }
            if (this.esc_mode < 0) {
                this.esc_mode = 0 /* VTEscapeModes.NORMAL */;
            }
            else if (c < 32) {
                switch (c) {
                    case 0: // NUL
                        break;
                    case 1: // SOH
                        this.cursor_x = 0;
                        this.cursor_y = VTerm.rows - 1;
                        break;
                    case 6: // ACK
                        this.advance_cursor();
                        return;
                    case 7: // BEL (TODO)
                        if (this.vbell)
                            this.vbell.classList.add('a');
                        if (this.vbel_id > 0) {
                            clearTimeout(this.vbel_id);
                        }
                        this.vbel_id = setTimeout(() => {
                            this.vbel_id = 0;
                            if (this.vbell)
                                this.vbell.classList.remove('a');
                        }, 1000);
                        this.buffer[vca] = 7;
                        break;
                    case 8: // BS
                    case 21: // NAK
                        if (this.cursor_x > 0)
                            this.cursor_x--;
                        break;
                    case 9: // HT
                        break;
                    case 10: // LF
                        this.advance_line();
                        return;
                    case 11: // VT
                        // TODO next char & 0x1f is row address
                        this.esc_mode = 4 /* VTEscapeModes.VTAB */;
                        return;
                    case 12: { // FF (clear)
                        this.cursor_x = 0;
                        this.cursor_y = 0;
                        let limit = VTerm.columns * VTerm.rows;
                        for (let q = 0; q < limit; q++) {
                            this.buffer[q] = 32;
                        }
                        this.update_screen();
                        return;
                    }
                    case 13: // CR
                        this.cursor_x = 0;
                        break;
                    case 16: // DLE (set horz address)
                        // next char & 0x7f is converted to col address
                        this.esc_mode = 6 /* VTEscapeModes.HADDR */;
                        break;
                    case 18: // DC4 (aux port on)
                        console.log('vtt: unhandled DC4 ON');
                        break;
                    case 20: // DC4 (aux port off)
                        break;
                    case 26: // SUB
                        this.cursor_y--;
                        if (this.cursor_y < 0) {
                            this.cursor_y = VTerm.rows - 1;
                        }
                        break;
                    case 27: // ESC
                        this.esc_mode = 1 /* VTEscapeModes.ESC */;
                        return;
                }
                this.render_cell(lastcurx, lastcury);
                if (this.cursor_x != lastcurx || this.cursor_y != lastcury)
                    this.render_cell(this.cursor_x, this.cursor_y);
                return;
            }
            this.buffer[vca] = c;
            this.render_cell(lastcurx, lastcury);
            this.advance_cursor();
        }
        clear_buffer() {
            this.input_buf.length = 0;
            this.import_buf.length = 0;
        }
        check_read() {
            if (this.mux == null)
                return;
            if (this.mux.can_receive() || this.input_control) {
                if (this.input_buf.length > 0) {
                    this.input_interval = VTerm.input_interval_rate;
                    let sv = this.input_buf.shift();
                    this.mux.receive(sv);
                }
                else {
                    this.input_control = false;
                    if (this.import_buf.length > 0 && this.input_interval < 1) {
                        this.input_interval = VTerm.input_interval_rate;
                        let sv = this.import_buf.shift();
                        this.mux.receive(sv);
                    }
                }
            }
        }
        receive(c) {
            if (this.input_buf.length < 8)
                this.input_buf.push(c);
            this.check_read();
        }
        text_import(txt) {
            let last = false;
            for (let c of txt) {
                let v = c.codePointAt(0);
                if (v == 10) {
                    if (last) {
                        this.import_buf.push(10); // backslash + newline (linefeed)
                    }
                    else {
                        this.import_buf.push(13); // typical Centurion newline
                    }
                    last = false;
                }
                else if (v == 92) { // backslash
                    last = true;
                }
                else {
                    if (last)
                        this.import_buf.push(92);
                    this.import_buf.push(v);
                    last = false;
                }
            }
            this.check_read();
        }
    }
    VTerm.columns = 80;
    VTerm.rows = 24;
    VTerm.char_base = 0;
    VTerm.input_interval_rate = 20000;
    const cx_crt0 = new VTerm(cv_term0, dc_crt0.children[0]);
    run_hw.push(cx_crt0);
    let cx_crt1 = new VTerm(cv_term1, frame_crt1.content.children[0]);
    run_hw.push(cx_crt1);
    let cx_crt2 = new VTerm(cv_term2, frame_crt2.content.children[0]);
    run_hw.push(cx_crt2);
    function console_text_import(txt) {
        cx_crt0.text_import(txt);
    }
    setInterval(function () {
        cx_crt0.update_blink();
        if (cx_crt1)
            cx_crt1.update_blink();
        if (cx_crt2)
            cx_crt2.update_blink();
    }, 125);
    const init_program = '79 86 23 C8 E5 EC EC EF F2 EC E4 A1 8D 8A 00 71 80 01';
    const program_rotl = '60 AA AA 60 AA AA 55 40 37 00 37 00 37 00 37 00 37 00 37 00 37 00 37 00 37 00 37 00 37 00 37 00 37 00 37 00 37 00 37 00 71 01 03';
    const program_rotr = '60 AA AA 60 AA AA 55 40 36 00 36 00 36 00 36 00 36 00 36 00 36 00 36 00 36 00 36 00 36 00 36 00 36 00 36 00 36 00 36 00 71 01 03';
    let HEX_CONV = conv_hex.checked;
    let name_conv = 1 /* NAMECON.MEI */;
    const NB = String.fromCodePoint(0xa0);
    function hexlist(v, l = 2) {
        const pre = HEX_CONV ? '0x' : '';
        if (v < 0)
            return '-' + pre + ((-v).toString(16).toUpperCase().padStart(l, '0'));
        return pre + v.toString(16).toUpperCase().padStart(l, '0');
    }
    function hexlistp(v, l = 2) {
        if (v == 0)
            return '';
        const pre = HEX_CONV ? '0x' : '';
        if (v < 0)
            return ' - ' + pre + ((-v).toString(16).toUpperCase().padStart(l, '0'));
        return ' + ' + pre + v.toString(16).toUpperCase().padStart(l, '0');
    }
    function hex(v, l = 2) {
        if (v < 0)
            return '-' + ((-v).toString(16).toUpperCase().padStart(l, '0'));
        return v.toString(16).toUpperCase().padStart(l, '0');
    }
    function dec(v, l = 2) {
        if (v < 0)
            '-' + (-v).toString(10).padStart(l, '0');
        return v.toString(10).padStart(l, '0');
    }
    function buftohex(buf, offset = 0, length) {
        let hs = '';
        const limit = buf.byteLength;
        if (length === undefined) {
            length = limit;
        }
        if (limit == 0)
            return hs;
        hs = buf[offset].toString(16).padStart(2, '0');
        if (limit == 1)
            return hs;
        for (let i = 1; i < length && i + offset < limit; i++) {
            hs += ' ' + buf[i + offset].toString(16).padStart(2, '0');
        }
        return hs;
    }
    function bin(v, l) {
        return v.toString(2).padStart(l, '0');
    }
    function sbyte(v) {
        v = v & 0xff;
        if (v > 127)
            v -= 256;
        return v;
    }
    function sword(v) {
        v = v & 0xffff;
        if (v > 32768)
            v -= 65536;
        return v;
    }
    function nyb(c) {
        return (c >> 4).toString(2).padStart(4, '0') + ' ' + (c & 15).toString(2).padStart(4, '0');
    }
    function bit(v, b) {
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
    const ALU_F = [
        { on: 0, sym: '+', ivr: false, ivs: false },
        { on: 0, sym: '+', ivr: true, ivs: false },
        { on: 0, sym: '+', ivr: false, ivs: true },
        { on: 1, sym: '|', ivr: false, ivs: false },
        { on: 2, sym: '&', ivr: false, ivs: false },
        { on: 2, sym: '&', ivr: true, ivs: false },
        { on: 3, sym: '^', ivr: false, ivs: false },
        { on: 3, sym: '^', ivr: true, ivs: false }
    ];
    class ALU8 {
        constructor() {
            this.in_data = 0;
            this.reg = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
            this.regq = 0;
            this.y = 0;
            this.out_f = 0;
            this.carry_in = 0;
            this.half_carry_out = 0;
            this.main_carry_out = 0;
            this.sign = 0;
            this.over = 0;
            this.zero = 0;
            this.ram0 = 0;
            this.ram7 = 0;
            this.q0 = 0;
            this.q7 = 0;
            this.is_shift = false;
            this.is_right = false;
        }
        // save results to register(s)
        step(dst, sel_b) {
            switch (dst) {
                case 0:
                    this.regq = this.y;
                    break; // Q=
                case 1: break; // nop
                case 2:
                    this.reg[sel_b] = this.y;
                    break; // B=
                case 3:
                    this.reg[sel_b] = this.y;
                    break; // B=
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
        resolve_alu(alsrc, alfn, aldst, sel_a, sel_b) {
            const dsti = aldst & 7;
            const fn = ALU_F[alfn & 7];
            // TODO fn.iv
            const vals_1 = this.in_data;
            const vals_2 = this.reg[sel_a];
            const vals_3 = this.reg[sel_b];
            const vals_4 = this.regq;
            let val_r = 0;
            let val_s = 0;
            switch (alsrc & 7) {
                case 0:
                    val_r = vals_2;
                    val_s = vals_4;
                    break;
                case 1:
                    val_r = vals_2;
                    val_s = vals_3;
                    break;
                case 2:
                    val_r = 0;
                    val_s = vals_4;
                    break;
                case 3:
                    val_r = 0;
                    val_s = vals_3;
                    break;
                case 4:
                    val_r = 0;
                    val_s = vals_2;
                    break;
                case 5:
                    val_r = vals_1;
                    val_s = vals_2;
                    break;
                case 6:
                    val_r = vals_1;
                    val_s = vals_4;
                    break;
                case 7:
                    val_r = vals_1;
                    val_s = 0;
                    break;
            }
            val_r = (fn.ivr ? ~val_r : val_r) & 255;
            val_s = (fn.ivs ? ~val_s : val_s) & 255;
            let out = 0;
            switch (fn.on) { // [+ & | ⊻]
                case 0: // subtraction is just addition with inverted inputs
                    out = val_r + val_s + this.carry_in;
                    this.main_carry_out = (out > 255) ? 1 : 0;
                    this.half_carry_out = (((val_r & 15) + (val_s & 15) + this.carry_in) > 15) ? 1 : 0;
                    this.over = this.main_carry_out ^ ((((val_r & 127) + (val_s & 127) + this.carry_in) > 127) ? 1 : 0);
                    break;
                case 1:
                    out = val_r | val_s;
                    this.half_carry_out = ((((val_r | val_s) & 15) == 15) ? 0 : 1) | this.carry_in;
                    this.over = this.main_carry_out = (((val_r | val_s) == 255) ? 0 : 1) | this.carry_in;
                    break;
                case 2:
                    out = val_r & val_s;
                    this.half_carry_out = ((((val_r & val_s) & 15) != 0) ? 1 : 0) | this.carry_in;
                    this.over = this.main_carry_out = (((val_r & val_s) != 0) ? 1 : 0) | this.carry_in;
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
            }
            else {
                this.out_f = out;
            }
            this.is_shift = dsti > 3;
            this.is_right = (dsti & 2) == 0;
            if (this.is_shift) {
                if (this.is_right) {
                    this.q0 = this.regq & 1;
                    this.ram0 = out & 1;
                }
                else {
                    this.q7 = (this.regq >> 7) & 1;
                    this.ram7 = (out >> 7) & 1;
                }
            }
        }
    }
    class ALU {
        constructor() {
            this.src = 0;
            this.aop = 0;
            this.dst = 0;
            this.sel_a = 0;
            this.sel_b = 0;
            this.in_data = 0;
            this.reg = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
            this.regq = 0;
            this.y = 0;
            this.out_f = 0;
            this.carry_in = 0;
            this.carry_out = 0;
            this.sign = 0;
            this.over = 0;
            this.zero = 0;
            this.ram0 = 0;
            this.ram3 = 0;
            this.q0 = 0;
            this.q3 = 0;
            this.is_shift = false;
            this.is_right = false;
        }
        // save results to register(s)
        step() {
            const dst = this.dst & 7;
            const ib = this.sel_b & 15;
            switch (dst) {
                case 0:
                    this.regq = this.y;
                    break; // Q=
                case 1: break; // nop
                case 2:
                    this.reg[ib] = this.y;
                    break; // B=
                case 3:
                    this.reg[ib] = this.y;
                    break; // B=
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
            const ia = this.sel_a & 15;
            const ib = this.sel_b & 15;
            // TODO fn.iv
            const vals_1 = this.in_data;
            const vals_2 = this.reg[ia];
            const vals_3 = this.reg[ib];
            const vals_4 = this.regq;
            let val_r = 0;
            let val_s = 0;
            switch (this.src & 7) {
                case 0:
                    val_r = vals_2;
                    val_s = vals_4;
                    break;
                case 1:
                    val_r = vals_2;
                    val_s = vals_3;
                    break;
                case 2:
                    val_r = 0;
                    val_s = vals_4;
                    break;
                case 3:
                    val_r = 0;
                    val_s = vals_3;
                    break;
                case 4:
                    val_r = 0;
                    val_s = vals_2;
                    break;
                case 5:
                    val_r = vals_1;
                    val_s = vals_2;
                    break;
                case 6:
                    val_r = vals_1;
                    val_s = vals_4;
                    break;
                case 7:
                    val_r = vals_1;
                    val_s = 0;
                    break;
            }
            val_r = (fn.ivr ? ~val_r : val_r) & 15;
            val_s = (fn.ivs ? ~val_s : val_s) & 15;
            let out = 0;
            switch (fn.on) { // [+ & | ⊻]
                case 0: // subtraction is just addition with inverted inputs
                    out = val_r + val_s + this.carry_in;
                    this.carry_out = (out > 15) ? 1 : 0;
                    this.over = this.carry_out ^ ((((val_r & 7) + (val_s & 7) + this.carry_in) > 7) ? 1 : 0);
                    break;
                case 1:
                    out = val_r | val_s;
                    this.over = this.carry_out = (((val_r | val_s) == 15) ? 0 : 1) | this.carry_in;
                    break;
                case 2:
                    out = val_r & val_s;
                    this.over = this.carry_out = (((val_r & val_s) != 0) ? 1 : 0) | this.carry_in;
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
            }
            else {
                this.out_f = out;
            }
            this.is_shift = dsti > 3;
            this.is_right = (dsti & 2) == 0;
            if (this.is_shift) {
                if (this.is_right) {
                    this.q0 = this.regq & 1;
                    this.ram0 = out & 1;
                }
                else {
                    this.q3 = (this.regq >> 3) & 1;
                    this.ram3 = (out >> 3) & 1;
                }
            }
        }
        // debug/trace string
        static trace_str(srci, fni, dsti, ia, ib, sq_str, sr_str, f_str, d_str, carry) {
            const vals_2 = `r${dec(ia, 2)}`;
            const vals_3 = `r${dec(ib, 2)}`;
            let val_r;
            let val_s;
            let val_rn;
            let val_sn;
            const show_f = f_str.length > 0;
            if (show_f) {
                f_str += '= ';
            }
            switch (srci & 7) {
                default:
                case 0:
                    val_rn = 3 + ia;
                    val_r = vals_2;
                    val_sn = 2;
                    val_s = 'Q';
                    break;
                case 1:
                    val_rn = 3 + ia;
                    val_r = vals_2;
                    val_sn = 3 + ib;
                    val_s = vals_3;
                    break;
                case 2:
                    val_rn = 0;
                    val_r = '0';
                    val_sn = 2;
                    val_s = 'Q';
                    break;
                case 3:
                    val_rn = 0;
                    val_r = '0';
                    val_sn = 3 + ib;
                    val_s = vals_3;
                    break;
                case 4:
                    val_rn = 0;
                    val_r = '0';
                    val_sn = 3 + ia;
                    val_s = vals_2;
                    break;
                case 5:
                    val_rn = 1;
                    val_r = d_str;
                    val_sn = 3 + ia;
                    val_s = vals_2;
                    break;
                case 6:
                    val_rn = 1;
                    val_r = d_str;
                    val_sn = 2;
                    val_s = 'Q';
                    break;
                case 7:
                    val_rn = 1;
                    val_r = d_str;
                    val_sn = 0;
                    val_s = '0';
                    break;
            }
            let dst;
            switch (dsti & 7) {
                default:
                case 0:
                    dst = `${f_str}Q= `;
                    break;
                case 1:
                    dst = f_str;
                    break;
                case 2:
                    dst = `${f_str}${show_f ? vals_2 : ''}, ${vals_3}=  `;
                    break;
                case 3:
                    dst = `${f_str}${vals_3}= `;
                    break;
                case 4:
                    dst = `${sq_str}>>Q, ${sr_str}>>${vals_3}= ${f_str}`;
                    break;
                case 5:
                    dst = `${sr_str}>>${vals_3}= ${f_str}`;
                    break;
                case 6:
                    dst = `Q<<${sq_str}, ${vals_3}<<${sr_str}= ${f_str}`;
                    break;
                case 7:
                    dst = `${vals_3}<<${sr_str}= ${f_str}`;
                    break;
            }
            const fn = ALU_F[fni];
            let fdesc;
            if (!show_f && dsti == 1) {
                fdesc = '';
            }
            else
                switch (fn.on) {
                    case 0:
                        if (carry == '0') {
                            if (fn.ivr) {
                                if (val_rn == 0)
                                    val_r = '1';
                                fdesc = `${val_s} - ${val_r}`;
                            }
                            else if (fn.ivs) {
                                if (val_sn == 0)
                                    val_s = '1';
                                fdesc = `${val_r} - ${val_s}`;
                            }
                            else {
                                if (val_rn == 0)
                                    fdesc = val_s;
                                else if (val_sn == 0)
                                    fdesc = val_r;
                                else
                                    fdesc = `${val_r} + ${val_s}`;
                            }
                        }
                        else if (carry == '1') {
                            if (fn.ivr) {
                                if (val_rn == 0)
                                    fdesc = val_s;
                                else
                                    fdesc = `${val_s} - ${val_r}`;
                            }
                            else if (fn.ivs) {
                                if (val_sn == 0)
                                    fdesc = val_r;
                                else
                                    fdesc = `${val_r} - ${val_s}`;
                            }
                            else {
                                if (val_rn == 0)
                                    fdesc = `${val_s} +1`;
                                else if (val_sn == 0)
                                    fdesc = `${val_r} +1`;
                                else
                                    fdesc = `${val_r} + ${val_s} +1`;
                            }
                        }
                        else {
                            if (fn.ivr) {
                                if (val_rn == 0)
                                    val_r = '1';
                                fdesc = `${val_s} - ${val_r} + ${carry}`;
                            }
                            else if (fn.ivs) {
                                if (val_sn == 0)
                                    val_s = '1';
                                fdesc = `${val_r} - ${val_s} + ${carry}`;
                            }
                            else {
                                fdesc = `${val_r} + ${val_s} + ${carry}`;
                            }
                        }
                        break;
                    default:
                    case 1: // or
                        if (val_rn == 0 && !fn.ivr)
                            fdesc = `${fn.ivs ? '~' : ''}${val_s}`;
                        else if (val_sn == 0 && !fn.ivs)
                            fdesc = `${fn.ivr ? '~' : ''}${val_r}`;
                        else
                            fdesc = `${fn.ivr ? '~' : ''}${val_r} ${fn.sym} ${fn.ivs ? '~' : ''}${val_s}`;
                        break;
                    case 2: // and
                        if ((val_rn == 0 && !fn.ivr) || (val_sn == 0 && !fn.ivs))
                            fdesc = '0';
                        else if (val_rn == 0 && fn.ivr)
                            fdesc = `${fn.ivs ? '~' : ''}${val_s}`;
                        else if (val_sn == 0 && fn.ivs)
                            fdesc = `${fn.ivr ? '~' : ''}${val_r}`;
                        else
                            fdesc = `${fn.ivr ? '~' : ''}${val_r} ${fn.sym} ${fn.ivs ? '~' : ''}${val_s}`;
                        break;
                    case 3: // xor
                        if (val_sn == val_rn && !fn.ivr)
                            fdesc = '0';
                        else if (val_sn == 0)
                            fdesc = `${fn.ivr ? '~' : ''}${val_r}`;
                        else if (val_rn == 0 && fn.ivr)
                            fdesc = `~${val_s}`;
                        else
                            fdesc = `${fn.ivr ? '~' : ''}${val_r} ${fn.sym} ${val_s}`;
                        break;
                }
            return `o${srci}${fni}${dsti} ${dst}${fdesc}`;
        }
    }
    const FN_SEQ_SN = ['P', 'R', 'S', 'D']; // 'uPC','AHR','STK','DIR'
    const FN_SEQ_FE = ['POP', '---', 'PSH', '---']; // FE:0 | (PUSH:1/POP:0) << 1
    class Sequencer {
        constructor() {
            this.p = 0;
            this.h = 0;
            this.sf = [0, 0, 0, 0];
            this.sp = 0;
            this.output = 0;
            this.next = 0; // incrementer output to pc
        }
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
        resolve(cin, sel_s, d, or, zero) {
            let out = 0;
            switch (sel_s & 3) {
                case 0:
                    out = this.p;
                    break;
                case 1:
                    out = this.h;
                    break;
                case 2:
                    out = this.sf[this.sp];
                    break;
                case 3:
                    out = d;
                    break;
            }
            out = zero ? 0 : (out | or) & 15;
            this.output = out;
            if (cin) {
                if (out >= 15) {
                    this.next = 0;
                    return true;
                }
                else {
                    this.next = out + 1;
                    return false;
                }
            }
            this.next = out;
            return false;
        }
        commit(fc) {
            if (fc == 0) {
                this.sp = (this.sp + 1) & 3;
            }
            else if (fc == 2) {
                this.sp = (this.sp - 1) & 3;
                this.sf[this.sp] = this.p;
            }
            this.p = this.next;
        }
    }
    const FN_8X02 = [
        'TSK', 'INC', 'BTL', 'POP', 'BSR', 'PLP', 'BRT', 'RST'
    ];
    const FN_8X02_C = [
        'SkipIf', 'Inc   ', 'RetnIf', 'Return', 'BrSRIf', 'PshInc', 'BrchIf', 'Reset '
    ];
    const FN_8X02_N = [
        'Inc', 'Inc', 'PopInc', 'Return', 'Inc', 'PushPInc', 'Inc', 'Reset '
    ];
    const FN_8X02_A = [
        'Skip', 'Inc', 'Return', 'Return', 'BranchSub', 'PushPInc', 'BranchTo', 'Reset '
    ];
    class Sequencer8X02 {
        constructor() {
            this.p = 0;
            this.sf = [0, 0, 0, 0];
            this.sp = 0;
        }
        reset() {
            this.p = 0;
        }
        commit(actrl, branch, test) {
            // load the multiplexor into the address register
            let next = 0;
            switch (actrl) {
                case 0:
                    next = this.p + (test ? 2 : 1);
                    break;
                case 1:
                    next = this.p + 1;
                    break;
                case 2: // Branch to loop
                    this.sp = (this.sp - 1) & 3;
                    if (test) {
                        next = this.sf[this.sp];
                    }
                    else {
                        next = this.p + 1;
                    }
                    break;
                case 3: // POP return from subroutine
                    this.sp = (this.sp - 1) & 3;
                    next = this.sf[this.sp];
                    break;
                case 4: // Branch to subroutine
                    if (test) {
                        this.sf[this.sp] = this.p + 1;
                        this.sp = (this.sp + 1) & 3;
                        next = branch;
                    }
                    else {
                        next = this.p + 1;
                    }
                    break;
                case 5: // Push for looping:
                    this.sf[this.sp] = this.p;
                    this.sp = (this.sp + 1) & 3;
                    next = this.p + 1;
                    break;
                case 6:
                    next = (test ? branch : this.p + 1);
                    break;
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
        function seqencer_display(v) {
            const ilu = ['Z', 'Z+1', 'J', 'J+1', 'K', 'K+1', 'Ra', 'Ra+1', 'Rb', 'Rb+1', 'Rc', 'Rc+1', 'Rd', 'Rd+1', 'D', 'D+1'];
            console.log('seq', 'pc', ilu[v.p], 'h', ilu[v.h], 'stk0', ilu[v.sf[v.sp]], 'stk1', ilu[v.sf[(v.sp + 1) & 3]], 'stk2', ilu[v.sf[(v.sp + 2) & 3]], 'stk3', ilu[v.sf[(v.sp + 3) & 3]], 'out', ilu[v.output]);
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
    class Backplane {
        constructor() {
            this.decode_hi = [];
            this.decode_io = [];
        }
        readmeta(address) {
            let aindex = address >> 8;
            let dev = this.decode_hi[aindex];
            if (dev) {
                return dev.dev.readmeta(address - dev.base);
            }
            return 32768 /* MEMSTAT.OPEN */;
        }
        writemeta(address, value) {
            let aindex = address >> 8;
            let dev = this.decode_hi[aindex];
            if (dev) {
                dev.dev.writemeta(address - dev.base, value);
                if ((address >= dis_ppc) && (address < dis_ppc_end)) {
                    dis_after = show_dis;
                }
                if ((address >= memv_begin) && (address < memv_end)) {
                    memv_after = show_mem;
                }
            }
        }
        configio(id, m) {
            this.decode_io[id] = m;
        }
        clearmemory(base, sz = 256) {
            let aval = base & 0x3ff00;
            let atarget = aval + sz;
            while (aval < atarget) {
                let aindex = aval >> 8;
                delete this.decode_hi[aindex];
                aval += 256;
            }
        }
        configmemory(base, m, sz = 256) {
            let aval = base & 0x3ff00;
            let atarget = aval + sz; // TODO
            let dev = {
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
        is_interrupt(cpl) {
            for (let i = 0; i < this.decode_io.length; i++) {
                let dev = this.decode_io[i];
                if (dev.is_interrupt() && (dev.getlevel() > cpl))
                    return true;
            }
            return false;
        }
        ack_interrupt(cpl) {
            for (let dev of this.decode_io) {
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
        readbyte(address) {
            let aindex = address >> 8;
            let dev = this.decode_hi[aindex];
            if (dev) {
                let v = dev.dev.readbyte(address - dev.base);
                return v;
            }
            return 0x00;
        }
        writebyte(address, value) {
            let aindex = address >> 8;
            let dev = this.decode_hi[aindex];
            if (dev) {
                dev.dev.writebyte(address - dev.base, value);
                if ((address >= dis_ppc) && (address < dis_ppc_end)) {
                    dis_after = show_dis;
                }
                if ((address >= memv_begin) && (address < memv_end)) {
                    memv_after = show_mem;
                }
            }
        }
    }
    const bpl = new Backplane();
    let sense_switch = 0;
    let dswitch = 0; // inverted on bus - R H I 0
    function mcsetup() {
        const s0 = new Sequencer();
        const s1 = new Sequencer();
        const s2 = new Sequencer();
        const aluc = new ALU8();
        let hsl_reg = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
        let hsl_regq = 0;
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
        let resetting = true;
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
        let dma_sources = [];
        let dma_current = undefined;
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
        const break_list = [
            null,
            function () { return true; }
        ];
        function LevelRegisters(level) {
            const base = level * 16;
            return Object.defineProperties({ level }, {
                a: { get() { return (regfile[base] << 8) | regfile[base + 1]; } },
                b: { get() { return (regfile[base + 2] << 8) | regfile[base + 3]; } },
                x: { get() { return (regfile[base + 4] << 8) | regfile[base + 5]; } },
                y: { get() { return (regfile[base + 6] << 8) | regfile[base + 7]; } },
                z: { get() { return (regfile[base + 8] << 8) | regfile[base + 9]; } },
                s: { get() { return (regfile[base + 10] << 8) | regfile[base + 11]; } },
                c: { get() { return (regfile[base + 12] << 8) | regfile[base + 13]; } },
                p: { get() { return (regfile[base + 14] << 8) | regfile[base + 15]; } },
                al: { get() { return regfile[base + 1]; } },
                bl: { get() { return regfile[base + 3]; } },
                xl: { get() { return regfile[base + 5]; } },
                yl: { get() { return regfile[base + 7]; } },
                zl: { get() { return regfile[base + 9]; } },
                sl: { get() { return regfile[base + 11]; } },
                cl: { get() { return regfile[base + 13]; } },
                pl: { get() { return regfile[base + 15]; } },
                ah: { get() { return regfile[base]; } },
                bh: { get() { return regfile[base + 2]; } },
                xh: { get() { return regfile[base + 4]; } },
                yh: { get() { return regfile[base + 6]; } },
                zh: { get() { return regfile[base + 8]; } },
                sh: { get() { return regfile[base + 10]; } },
                ch: { get() { return regfile[base + 12]; } },
                ph: { get() { return regfile[base + 14]; } },
            });
        }
        class MCCPU {
            constructor() {
                this.registers = [
                    LevelRegisters(0), LevelRegisters(1),
                    LevelRegisters(2), LevelRegisters(3),
                    LevelRegisters(4), LevelRegisters(5),
                    LevelRegisters(6), LevelRegisters(7),
                    LevelRegisters(8), LevelRegisters(9),
                    LevelRegisters(10), LevelRegisters(11),
                    LevelRegisters(12), LevelRegisters(13),
                    LevelRegisters(14), LevelRegisters(15),
                ];
                this.step = step;
                this.hsstep = hsstep;
                this.hspre = hspre;
                this.hsend = hsend;
                this.loadcache = loadcache;
                this.showstate = showstate;
                this.reset = reset;
                this.dma_register = dma_register;
                this.dma_request = dma_request;
                this.dma_end = false;
                this.parity = 0;
                this.memfault = 0;
            }
            get reg() { return this.registers[level]; }
            get level() { return level; }
            get map() { return pta; }
            get pc() { return last_pc; }
            get page_ram() { return pagetb; }
            add_virtual_break(address, f) {
                let i;
                if (typeof address != 'number')
                    throw new Error('Invalid address');
                if (address < 0 || address > 65535)
                    throw new Error('Invalid address');
                if (vmbreak[address] != 0)
                    throw new Error('Address already set');
                if (typeof f == 'number') {
                    i = f | 0;
                    if (i < 0 || i > 255)
                        throw new Error('Invalid break point');
                    f = break_list[i];
                    if (f == null)
                        throw new Error('Invalid break point');
                }
                else if (typeof f == 'function') {
                    i = break_list.indexOf(f);
                }
                else {
                    throw new Error('Invalid break function or function ID');
                }
                if (i == -1) {
                    i = break_list.indexOf(null, 1);
                    if (i == -1)
                        i = break_list.length;
                    if (i > 255)
                        throw new Error('Too many break points');
                    f(-1, address, 0);
                    break_list[i] = f;
                }
                vmbreak[address] = i;
                return i;
            }
            remove_break_at(address) {
                vmbreak[address] = 0;
            }
            remove_break(f) {
                let i;
                if (f == null)
                    return;
                if (typeof f == 'number') {
                    i = f | 0;
                    if (i < 2 || i > 255)
                        throw new Error('Invalid break point');
                    if (break_list[i] == null)
                        return;
                }
                else if (typeof f == 'function') {
                    i = break_list.indexOf(f);
                }
                else {
                    throw new Error('Invalid break function or function ID');
                }
                if (i > -1 && i != 1)
                    break_list[i] = null;
            }
            dma_int(en) {
                dma_12 = en ? 1 : 0;
            }
            get physaddr() { return physaddr; }
            get memaddr() { return memaddr; }
        }
        const mco = new MCCPU();
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
            dma_request();
        }
        ;
        function showstate(in_halt) {
            if (show_int) {
                let mcp = s2.output.toString(16) + s1.output.toString(16) + s0.output.toString(16);
                let mpc = s2.p.toString(16) + s1.p.toString(16) + s0.p.toString(16);
                let mhr = s2.h.toString(16) + s1.h.toString(16) + s0.h.toString(16);
                let mstk = '';
                let msp0 = s0.sp, msp1 = s1.sp, msp2 = s2.sp;
                let fl = alu_flag;
                let malu1 = hex(aluc.regq, 2) +
                    ` ${hex(fl, 2)} ${(fl & 0x20) != 0 ? 'L' : '-'}${(fl & 0x10) != 0 ? 'H' : '-'}${(fl & 8) != 0 ? 'C' : '-'}${(fl & 4) != 0 ? 'V' : '-'}${(fl & 2) != 0 ? 'S' : '-'}${(fl & 1) != 0 ? 'Z' : '-'}`;
                let malu2 = '';
                let malu3 = '';
                for (let i = 0; i < 4; i++) {
                    mstk += s2.sf[msp2].toString(16) + s1.sf[msp1].toString(16) + s0.sf[msp0].toString(16) + ' ';
                    msp0 = (msp0 - 1) & 3;
                    msp1 = (msp1 - 1) & 3;
                    msp2 = (msp2 - 1) & 3;
                }
                for (let i = 0; i < 8; i++) {
                    malu2 += hex(aluc.reg[i], 2) + ' ';
                    malu3 += hex(aluc.reg[i + 8], 2) + ' ';
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
                const bc = busctl;
                const sc = sysctl;
                mcr_bus.innerText = `${(bc & 1) > 0 ? 'I' : '-'} ${(bc & 2) > 0 ? '--' : 'AE'} ${(bc & 4) > 0 ? '--' : 'AC'} ${(bc & 8) > 0 ? 'U' : 'D'}` +
                    ` ${(bc & 16) > 0 ? 'DA' : '--'} ${(bc & 32) > 0 ? 'PT' : '--'} ${(bc & 64) > 0 ? 'MFE' : '---'}${(bc & 128) > 0 ? 'DMA' : '---'}`;
                mcr_sys.innerText = `${(sc & 1) > 0 ? 'DM4' : '---'} ${(sc & 2) > 0 ? 'DM3' : '---'} ${(sc & 4) > 0 ? 'TE' : '--'} ${(sc & 8) > 0 ? '-' : 'M'}` +
                    ` ${(sc & 16) > 0 ? 'R' : 'H'} ${(sc & 32) > 0 ? '--' : 'TR'} ${(sc & 64) > 0 ? 'A' : '-'} ${(sc & 128) > 0 ? 'IA' : '--'}`;
                const mpaddress = ((pgram & 127) << 11) | (memaddr & 0x7ff);
                mcr_addr.innerText = hex(workaddr, 4) + ' ' + hex(memaddr, 4) + ' ' + ((pgram & 128) != 0 ? '*' : '.') + hex(mpaddress, 5) + ' ' + hex(physaddr, 5);
            }
            if (show_reg) {
                for (let rindex = 0; rindex < 256; rindex += 32) {
                    let rfilel = '';
                    let rfiler = '';
                    for (let i = 0; i < 16; i += 2) {
                        let reg = (regfile[rindex + i] << 8) | regfile[rindex + i + 1];
                        let regr = (regfile[rindex + 16 + i] << 8) | regfile[rindex + 16 + i + 1];
                        rfilel += hex(reg, 4) + ' ';
                        rfiler += ' ' + hex(regr, 4);
                    }
                    mcr_file[rindex >> 5].innerText = rfilel + rfiler;
                }
            }
            fp_level.innerText = hex(level, 1);
            const is_running = (sysctl & 16) != 0;
            style_if(fp_runhalt[0], 'a', is_running); // run
            style_if(fp_runhalt[1], 'a', !is_running); // halt
            style_if(fp_ext[0], 'a', run_step);
            style_if(fp_ext[2], 'a', mco.memfault != 0);
            cx_map.clearRect(0, 0, cv_map.width, cv_map.height);
            cx_addr.clearRect(0, 0, cv_addr.width, cv_addr.height);
            cx_level.clearRect(0, 0, cv_level.width, cv_level.height);
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
                addr1a = (memaddr >> 1) & 1;
                addr2a = (memaddr >> 2) & 1;
                addr3a = (memaddr >> 3) & 1;
                addr4a = (memaddr >> 4) & 1;
                addr5a = (memaddr >> 5) & 1;
                addr6a = (memaddr >> 6) & 1;
                addr7a = (memaddr >> 7) & 1;
                addr8a = (memaddr >> 8) & 1;
                addr9a = (memaddr >> 9) & 1;
                addr10a = (memaddr >> 10) & 1;
                addr11a = (memaddr >> 11) & 1;
                addr12a = (memaddr >> 12) & 1;
                addr13a = (memaddr >> 13) & 1;
                addr14a = (memaddr >> 14) & 1;
                addr15a = (memaddr >> 15) & 1;
                level0a = level & 1;
                level1a = (level >> 1) & 1;
                level2a = (level >> 2) & 1;
                level3a = (level >> 3) & 1;
            }
            let hrr1 = hrr2 >> 1;
            let hrr05 = hrr1 >> 1;
            let hrr3 = hrr2 + hrr1;
            function ledcolor(v) {
                if (v > hrr2) {
                    if (v > hrr3) {
                        return '#ff3232';
                    }
                    else if (v > hrr2 + hrr05) {
                        return '#c01c1c';
                    }
                    else
                        return '#a81c1c';
                }
                else if (v > hrr1) {
                    if (v > hrr1 + hrr05)
                        return '#901c1c';
                    else
                        return '#701c1c';
                }
                else if (v > hrr05) {
                    return '#400c0c';
                }
                else
                    return '#200c0c';
            }
            if (abtac > 0) {
                cx_map.fillStyle = ledcolor(abtac);
                cx_map.fillRect(0, 0, 48, 30);
            }
            cx_map.fillStyle = '#aeaeae';
            cx_map.fillText('ABT', 8, baseline);
            function drawaddr(v, x, t) {
                if (v > 0) {
                    cx_addr.fillStyle = ledcolor(v);
                    cx_addr.fillRect(x, 0, 12, 30);
                }
                cx_addr.fillStyle = '#aeaeae';
                cx_addr.fillText(t, x + 2, baseline);
            }
            function drawfill(v, x, t) {
                if (v > 0) {
                    cx_map.fillStyle = ledcolor(v);
                    cx_map.fillRect(x, 0, 27, 30);
                }
                cx_map.fillStyle = '#aeaeae';
                cx_map.fillText(t, x + 7, baseline);
            }
            function drawlevel(v, x, t) {
                if (v > 0) {
                    cx_level.fillStyle = ledcolor(v);
                    cx_level.fillRect(x, 0, 27, 30);
                }
                cx_level.fillStyle = '#aeaeae';
                cx_level.fillText(t, x + 7, baseline);
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
            drawfill(pta3a, 49, '4');
            drawfill(pta2a, 77, '2');
            drawfill(pta1a, 105, '1');
            drawfill(ccr_fa, 133, 'F');
            drawfill(ccr_la, 161, 'L');
            drawfill(ccr_ma, 189, 'M');
            drawfill(ccr_va, 217, 'V');
            drawlevel(level3a, 0, '8');
            drawlevel(level2a, 27, '4');
            drawlevel(level1a, 54, '2');
            drawlevel(level0a, 81, '1');
            abtac = 0;
            ccr_va = 0;
            ccr_fa = 0;
            ccr_la = 0;
            ccr_ma = 0;
            pta1a = 0;
            pta2a = 0;
            pta3a = 0;
            addr15a = 0;
            addr14a = 0;
            addr13a = 0;
            addr12a = 0;
            addr11a = 0;
            addr10a = 0;
            addr9a = 0;
            addr8a = 0;
            addr7a = 0;
            addr6a = 0;
            addr5a = 0;
            addr4a = 0;
            addr3a = 0;
            addr2a = 0;
            addr1a = 0;
            addr0a = 0;
            level0a = 0;
            level1a = 0;
            level2a = 0;
            level3a = 0;
            const ptindex = pta << 5;
            if (show_page) {
                for (let k = 0; k < 4; k++) {
                    let pgt = '';
                    const psubindex = ptindex | (k << 3);
                    for (let i = 0; i < 8; i++) {
                        const page = pagetb[psubindex | i];
                        const pf = (page & 128) != 0;
                        pgt += (pf ? '*' : '.') + hex((page & 127) << 3, 3) + ' ';
                    }
                    mcpage[k].innerText = pgt;
                }
            }
            fp_addr.innerText = hex(memaddr, 4);
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
        const mpscache = [];
        function loadcache() {
            for (let ro = 0; ro < 0x800; ro++) {
                const v6 = /*A*/ uc.k[ro]; // MSB
                const v5 = /*B*/ uc.f[ro];
                const v4 = /*C*/ uc.h[ro];
                const v3 = /*D*/ uc.l[ro];
                const v2 = /*E*/ uc.m[ro];
                const v1 = /*F*/ uc.j[ro];
                const v0 = /*H*/ uc.e[ro]; // LSB
                const c0 = (v3 << 24) | (v2 << 16) | (v1 << 8) | v0;
                const c1 = (v6 << 16) | (v5 << 8) | v4;
                uc.c0[ro] = c0;
                uc.c1[ro] = c1;
                const dp_sel = v0 & 15;
                const x_e6 = (v0 >> 4) & 7;
                const x_k11 = (v0 >> 7) | ((v1 & 3) << 1);
                const x_h11 = (v1 >> 2) & 7;
                const x_e7 = (v1 >> 5) & 3;
                const k9_en = (v1 >> 7) & 1;
                const k9_sel = v2 & 7;
                const mpconst_m6 = v2 ^ 0xff; // goes through a 74ls240
                const j12_sel = v2 & 3;
                const j11_en = (v2 >> 2) & 1;
                const j11_sel = (v2 >> 3) & 3;
                const j13_sel = (v2 >> 4) & 3;
                const j10_en = (v2 >> 5) & 1;
                const j10_sel = ((v2 >> 6) & 3) | ((v3 & 1) << 2);
                const k13_sel = (v2 >> 6) & 3;
                const seq_d0 = v2 & 15;
                const seq_d1 = v2 >> 4;
                const seq_d2 = v3 & 7;
                const seq_fci = (v3 >> 3) & 3; // TODO verify FE/PUP
                const seq0_si = (v3 >> 5) & 3;
                const seq12_s0i = (v3 >> 7) & 1; // TODO verify
                const seq2_si_k6b = seq12_s0i | ((v4 & 1) << 1); // TODO verify
                const seq1_si_k6dc = seq12_s0i | (2 ^ (2 & (v6 >> 5) & ((v4 << 1) ^ 2)));
                const seq_branch = (v4 >> 1) & 1;
                const rir0 = (v6 >> 5) & 1;
                const x_f6h6 = (v6 >> 3) & 3;
                const x_c14_sel = (v6 >> 7) & 1 /* !=0 */;
                const aluc_s = (v4 >> 2) & 7;
                const aluc_f = (v4 >> 5) & 7;
                const aluc_d = v5 & 7;
                const busctld = (v5 >> 3) & 1;
                const busctla = (v5 >> 4) & 7;
                const busctlset = busctld << busctla;
                const busctlmask = (1 << busctla) ^ 255;
                const aluc_b = (v5 >> 3) & 15;
                const aluc_a = ((v6 << 1) | (v5 >> 7)) & 15;
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
                    seq0_si: 3 ^ seq0_si,
                    seq12_s0i,
                    seq2_si_k6b: 3 ^ seq2_si_k6b,
                    seq1_si_k6dc: 3 ^ seq1_si_k6dc,
                    seq_branch,
                    rir0,
                    x_f6h6,
                    x_c14_sel: x_c14_sel != 0,
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
        function dma_register(device) {
            dma_sources.push(device);
        }
        const dma_control = {
            read() {
                let v = bpl.readbyte(physaddr);
                const count_up = (busctl & 8) != 0;
                workaddr = (workaddr + (count_up ? 1 : -1)) & 0xffff;
                memaddr = (memaddr + (count_up ? 1 : -1)) & 0xffff;
                mempt_set();
                return v;
            },
            write(value) {
                bpl.writebyte(physaddr, value);
                const count_up = (busctl & 8) != 0;
                workaddr = (workaddr + (count_up ? 1 : -1)) & 0xffff;
                memaddr = (memaddr + (count_up ? 1 : -1)) & 0xffff;
                mempt_set();
            },
            end() {
                if (dma_current)
                    dma_current.dma_request = false;
                dma_current = undefined;
                for (let i = 0; i < dma_sources.length; i++) {
                    const device = dma_sources[i];
                    if (device.dma_request) {
                        dma_current = device;
                        break;
                    }
                }
            }
        };
        function dma_request() {
            if (dma_current) {
                return 1;
            }
            for (let i = 0; i < dma_sources.length; i++) {
                const device = dma_sources[i];
                if (device.dma_request) {
                    dma_current = device;
                    return 1;
                }
            }
            return 0;
        }
        function hspre() {
            for (let i = 0; i < 16; i++) {
                hsl_reg[i] = aluc.reg[i];
            }
            hsl_regq = aluc.regq;
        }
        function hsend() {
            for (let i = 0; i < 16; i++) {
                aluc.reg[i] = hsl_reg[i];
            }
            aluc.regq = hsl_regq;
        }
        // this function is a variant that favours speed
        function hsstep() {
            const mci = mpscache[mcpc];
            const intena = (busctl & 1) != 0;
            const sysint = reqlevel;
            const dmaint = intena && (level < 2) && (dma_12 != 0);
            const count_up = (busctl & 8) != 0;
            if (mcpc == 0x101) {
                last_pc = memaddr;
                last_map = pta;
            }
            if ((run_step && (mcpc == 0x101)) || mclisting[mcpc].bp) {
                if (handle_break())
                    return;
            }
            let is_jsr = 0;
            if (mci.k9_en) {
                switch (mci.k9_sel) {
                    case 0: /* TODO f12b */
                        is_jsr = 1;
                        break;
                    case 1: /* rir.0 nor 4 */
                        is_jsr = ((rir | (rir >> 4)) & 1) ^ 1;
                        break;
                    case 2: /* rir.0 */
                        is_jsr = rir & 1;
                        break;
                    case 3: /* mmio/reg */
                        is_jsr = is_regmmio;
                        break;
                    case 4: /* REG/pbit */
                        is_jsr = is_mem;
                        break;
                    case 5: /* DMA P2.13 */
                        is_jsr = dma_request();
                        break;
                    case 6: /* TODO B15A */
                        is_jsr = b15a ^ 1;
                        break;
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
            if (is_jsr != 0) {
                seq0_s = 3;
                seq1_s = 3;
                seq2_s = 3;
                seq_fc &= 2;
            }
            let datapath = 0;
            // Data Path Control
            switch (mci.dp_sel) {
                case 0:
                case 4: // R_SWP ⇒ DP
                    datapath = swap;
                    break;
                case 1:
                case 5: // R_REG(d13) ⇒ DP
                    datapath = rdr;
                    break;
                case 2:
                case 6: // R_ADM(rawH) ⇒ DP
                    datapath = ((memaddr >> 8) & 255) ^ 0xf0;
                    break;
                case 3:
                case 7: // R_ADL ⇒ DP
                    datapath = memaddr & 255;
                    break;
                case 8: // R_AddrPH ⇒ DP
                    datapath = pgaddr;
                    break;
                case 9: // CCR:sense ⇒ DP
                    // sense_switch inverted on bus
                    datapath = ((ccr_l << 4) | (ccr_f << 5) | (ccr_m << 6) | (ccr_v << 7) | sense_switch) ^ 0xf0 /* sense sw */;
                    break;
                case 10: // R_SysDLatch ⇒ DP
                    datapath = memdata_in;
                    break;
                case 11: // R_H14 ⇒ DP // TODO rest of H14? beware invertions
                    datapath = (level << 4) | 4 |
                        (resetting ? 2 : 0) | notpgbit |
                        (dmaint ? 8 : 0);
                    if (resetting)
                        resetting = false;
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
            let hsl_y = 0;
            let hsl_carry_in = 0;
            let hsl_main_carry_out = 0; // bit 1<<3
            switch (mci.x_f6h6) {
                case 0:
                    hsl_carry_in = 0;
                    break;
                case 1:
                    hsl_carry_in = 1;
                    break;
                case 2:
                    hsl_carry_in = (alu_flag >> 3) & 1;
                    break;
                case 3:
                    hsl_carry_in = 0;
                    break;
            }
            //hsl_resolve_alu(mci.aluc_s, mci.aluc_f, mci.aluc_d, mci.aluc_a, mci.aluc_b);
            // perform logic flow
            const fn = ALU_F[mci.aluc_f];
            let val_r = 0;
            let val_s = 0;
            switch (mci.aluc_s) {
                case 0:
                    val_r = hsl_reg[mci.aluc_a];
                    val_s = hsl_regq;
                    break;
                case 1:
                    val_r = hsl_reg[mci.aluc_a];
                    val_s = hsl_reg[mci.aluc_b];
                    break;
                case 2:
                    val_r = 0;
                    val_s = hsl_regq;
                    break;
                case 3:
                    val_r = 0;
                    val_s = hsl_reg[mci.aluc_b];
                    break;
                case 4:
                    val_r = 0;
                    val_s = hsl_reg[mci.aluc_a];
                    break;
                case 5:
                    val_r = datapath;
                    val_s = hsl_reg[mci.aluc_a];
                    break;
                case 6:
                    val_r = datapath;
                    val_s = hsl_regq;
                    break;
                case 7:
                    val_r = datapath;
                    val_s = 0;
                    break;
            }
            val_r = fn.ivr ? 255 ^ val_r : val_r;
            val_s = fn.ivs ? 255 ^ val_s : val_s;
            //let out = 0;
            switch (fn.on) { // [+ & | ⊻]
                case 0: // subtraction is just addition with inverted inputs
                    hsl_y = val_r + val_s + hsl_carry_in;
                    hsl_main_carry_out = (hsl_y > 255) ? 8 : 0;
                    break;
                case 1:
                    hsl_y = val_r | val_s;
                    break;
                case 2:
                    hsl_y = val_r & val_s;
                    break;
                case 3:
                    hsl_y = val_r ^ val_s;
                    break;
                default: hsl_y = 0;
            }
            hsl_y &= 255;
            let data_f;
            if (mci.x_h11 == 6) { // Select MAPROM to F
                data_f = uc.map[datapath];
            }
            else if (mci.aluc_d == 2) {
                data_f = hsl_reg[mci.aluc_a] & 255; // select A to the bus output
            }
            else {
                data_f = hsl_y;
            }
            let hsl_ram0 = 0;
            let hsl_ram7 = 0;
            let hsl_q0 = 0;
            let hsl_q7 = 0;
            if (mci.aluc_d > 3) {
                if ((mci.aluc_d & 2) == 0) {
                    hsl_q0 = hsl_regq & 1;
                    hsl_ram0 = hsl_y & 1;
                    // >> 3.h.0 >> 3.l.0 >>
                    switch (mci.x_f6h6) { // h6.Za
                        case 0:
                            hsl_ram7 = hsl_y & 128;
                            break;
                        case 1:
                            hsl_ram7 = ((alu_flag << 4) & 128);
                            break;
                        case 2:
                            hsl_ram7 = hsl_q0 << 7;
                            break;
                        case 3:
                            hsl_ram7 = hsl_main_carry_out << 4;
                            break;
                    }
                    hsl_q7 = hsl_ram0 << 7;
                }
                else {
                    hsl_q7 = hsl_regq & 128;
                    hsl_ram7 = hsl_y & 128;
                    // << 3.h.0 << 3.l.0 <<
                    switch (mci.x_f6h6) { // h6.Zb
                        case 0: break;
                        case 1:
                            hsl_q0 = ((alu_flag >> 3) & 1);
                            break;
                        case 2:
                            hsl_q0 = hsl_y >> 7;
                            break;
                        case 3:
                            hsl_q0 = 1;
                            break;
                    }
                    hsl_ram0 = hsl_q7 >> 7;
                }
            }
            // uses ALU flags, so must be after comb logic resolve
            if (mci.seq_branch == 0) {
                switch (mci.j13_sel) {
                    case 0: // |1 IF ALUF.S, |2 IF ALUF.Z
                        seq_or |= ((alu_flag & 2) != 0 ? 1 : 0);
                        seq_or |= ((alu_flag & 1) != 0 ? 2 : 0);
                        break;
                    case 1: // |1 IF ALUF.H, |2 IF ALUF.V
                        seq_or |= ((alu_flag & 16) != 0 ? 1 : 0);
                        seq_or |= ((alu_flag & 4) != 0 ? 2 : 0);
                        break;
                    case 2: // |1 IF ~pbit, |2 IF ~MMIO
                        seq_or |= notpgbit | (is_mmio << 1);
                        break;
                    case 3: break; // nop
                }
                switch (mci.k13_sel) { // mind the strange order of OR2/3 (|4 |8)
                    case 0: // |4 IF INT_EN, |8 IF CCR.Carry (Link)
                        if (intena)
                            seq_or |= 4;
                        if (ccr_l != 0)
                            seq_or |= 8;
                        break;
                    case 1: // |4 IF DMA_INT, |8 IF INT_REQ
                        if (!dmaint)
                            seq_or |= 4;
                        if (!(intena && bpl.is_interrupt(level)))
                            seq_or |= 8;
                        break;
                    case 2: // |4 IF MEM_INT, |8 IF DMA_REQ
                        //seq_or |= 4; // TODO typically low
                        if (!dma_request())
                            seq_or |= 8;
                        break;
                    case 3: break; // nop
                }
            }
            let rindex;
            if (mci.x_c14_sel) {
                rindex = (rir & 15) | (level << 4);
            }
            else {
                rindex = rir & 255;
            }
            // rindex bit 0, this is technically a NOR
            // but can be handled as needed because this is the only reference
            rindex = rindex | mci.rir0; // I elected to not invert it, since the debug dump would have anyways
            ////////////////////////////// rising clock edge /////////////////////////////
            const prevwork = workaddr;
            const prevflag = alu_flag;
            switch (mci.x_k11) {
                case 0: break; // nop
                case 1:
                    mco.dma_end = false;
                    break; // L13A_SET
                case 2: // ?K11_2
                    if ((mci.busctlset == 128) && ((sysctl & 128) == 0)) {
                        reqlevel = bpl.ack_interrupt(level);
                    }
                    if ((mci.busctlmask == 127) && ((sysctl & 128) == 128)) {
                        reqlevel = 0;
                    }
                    sysctl = (sysctl & mci.busctlmask) | mci.busctlset;
                    break;
                case 3: // BusCtl
                    busctl = (busctl & mci.busctlmask) | mci.busctlset;
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
                    }
                    else {
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
            if (cycles >= 2000 && CONFIG.cpu[2] == 1 && (sysctl & 0x20) != 0) {
                let n = Date.now();
                cycles = 0;
                if (n >= rtlast) {
                    rtphase++;
                    rtc = true;
                    if (rtphase == 15) {
                        rtphase = 0;
                        rtlast += 12;
                    }
                    else {
                        rtlast += 17;
                    }
                    if (n > rtlast + 1000) {
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
            switch (mci.x_e7) {
                case 0: break; // nop
                case 1: break; // TODO: BusReady
                case 2: // ALUFlag_LD
                    {
                        let hsl_over = 0; /* bit 1<<2 */
                        let hsl_half_carry_out = 0; // bit 1<<4
                        switch (fn.on) { // [+ & | ⊻]
                            case 0:
                                hsl_half_carry_out = (((val_r & 15) + (val_s & 15) + hsl_carry_in) > 15) ? 1 << 4 : 0;
                                if (((val_r & 127) + (val_s & 127) + hsl_carry_in) > 127) {
                                    hsl_over = (hsl_main_carry_out ^ 8) >> 1;
                                }
                                else {
                                    hsl_over = hsl_main_carry_out >> 1;
                                }
                                break;
                            case 1:
                                hsl_half_carry_out = (hsl_y & 15) == 15 ? hsl_carry_in << 4 : 16;
                                if (hsl_y == 255) {
                                    hsl_over = hsl_carry_in << 2;
                                    hsl_main_carry_out = hsl_carry_in << 3;
                                }
                                else {
                                    hsl_over = 4;
                                    hsl_main_carry_out = 8;
                                }
                                break;
                            case 2:
                                hsl_half_carry_out = (hsl_y & 15) != 0 ? 16 : (hsl_carry_in << 4);
                                if (hsl_y != 0) {
                                    hsl_over = 4;
                                    hsl_main_carry_out = 8;
                                }
                                else {
                                    hsl_over = hsl_carry_in << 2;
                                    hsl_main_carry_out = hsl_carry_in << 3;
                                }
                                break;
                        }
                        alu_flag = ((hsl_y == 0) ? 1 : 0) | (hsl_y > 127 ? 2 : 0) | hsl_over |
                            hsl_main_carry_out | hsl_half_carry_out | ((prevflag & 1) << 5);
                        break;
                    }
                case 3: // DataRD
                    if (sys_write_latch) {
                        memdata_in = memdata_out;
                    }
                    else if (sys_read_in) {
                        mco.memfault = 0;
                        memdata_in = bpl.readbyte(physaddr);
                        if ((busctl & 0x40) != 0) {
                            b15a = mco.memfault ^ 1;
                        }
                        else {
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
                if (!dma_current.dma_request) {
                    dma_control.end();
                }
                else {
                    dma_current.dma_step(dma_control);
                }
                if (workaddr == 0xffff)
                    mco.dma_end = true;
            }
            switch (mci.x_h11) {
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
                    }
                    else {
                        workaddr = (workaddr & 0x00ff) | (result << 8);
                    }
                    break;
                case 4: // WorkAddr_Count
                    workaddr = (workaddr + (count_up ? 1 : -1)) & 0xffff;
                    break;
                case 5: // MemAddr_Count
                    memaddr = (memaddr + (count_up ? 1 : -1)) & 0xffff;
                    mempt_set();
                    break;
                case 6: break; // F=MapROM - handled farther above
                case 7: // NibSwap
                    swap = ((datapath << 4) | (datapath >> 4)) & 255;
                    break;
            }
            switch (mci.x_e6) {
                // no case 0
                case 1:
                    result = data_f;
                    break; // F⇒Result
                case 2:
                    rir = data_f;
                    break; // F⇒RIdx
                case 3:
                    level = data_f >> 4;
                    break; // F⇒Level
                case 4:
                    pta = data_f & 7;
                    mempt_set();
                    break; // F⇒PTA
                case 5:
                    memaddr = prevwork;
                    mempt_set();
                    break; // ASwap
                case 6: // SEQ_RE
                    s0.h = data_f & 15;
                    s1.h = (data_f >> 4) & 15;
                    break;
                case 7: // conditions register
                    switch (mci.j12_sel) {
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
                        switch (mci.j11_sel | (prevflag & 0x4)) {
                            case 0:
                                ccr_f = (result >> 5) & 1;
                                break;
                            case 1:
                                ccr_f = 1;
                                break;
                            case 2: break;
                            case 3:
                                ccr_f = 0;
                                break;
                            case 4:
                                ccr_f = (result >> 5) & 1;
                                break;
                            case 5:
                                ccr_f = 1;
                                break;
                            case 6: break;
                            case 7:
                                ccr_f = 1;
                                break;
                        }
                    }
                    else {
                        ccr_f = 0;
                    }
                    if (mci.j10_en == 0) {
                        switch (mci.j10_sel) {
                            case 0: break;
                            case 1:
                                ccr_l = ccr_l ^ 1;
                                break;
                            case 2:
                                ccr_l = (prevflag >> 3) & 1;
                                break;
                            case 3:
                                ccr_l = 1;
                                break;
                            case 4:
                                ccr_l = (result >> 4) & 1;
                                break;
                            case 5:
                                ccr_l = hsl_ram7 >> 7;
                                break;
                            case 6:
                                ccr_l = hsl_ram0;
                                break;
                            case 7:
                                ccr_l = hsl_q0;
                                break;
                        }
                    }
                    else {
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
            addr1a += (memaddr >> 1) & 1;
            addr2a += (memaddr >> 2) & 1;
            addr3a += (memaddr >> 3) & 1;
            addr4a += (memaddr >> 4) & 1;
            addr5a += (memaddr >> 5) & 1;
            addr6a += (memaddr >> 6) & 1;
            addr7a += (memaddr >> 7) & 1;
            addr8a += (memaddr >> 8) & 1;
            addr9a += (memaddr >> 9) & 1;
            addr10a += (memaddr >> 10) & 1;
            addr11a += (memaddr >> 11) & 1;
            addr12a += (memaddr >> 12) & 1;
            addr13a += (memaddr >> 13) & 1;
            addr14a += (memaddr >> 14) & 1;
            addr15a += (memaddr >> 15) & 1;
            level0a += level & 1;
            level1a += (level >> 1) & 1;
            level2a += (level >> 2) & 1;
            level3a += (level >> 3) & 1;
            //hsl_step(mci.aluc_d, mci.aluc_b);
            // save results to register(s)
            switch (mci.aluc_d) {
                case 0:
                    hsl_regq = hsl_y;
                    break; // Q=
                case 1: break; // nop
                case 2:
                    hsl_reg[mci.aluc_b] = hsl_y;
                    break; // B=
                case 3:
                    hsl_reg[mci.aluc_b] = hsl_y;
                    break; // B=
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
        function step(debug_output = false) {
            const mci = mpscache[mcpc];
            const intena = (busctl & 1) != 0;
            const intreq = intena && bpl.is_interrupt(level); // inverted on bus
            const sysint = reqlevel;
            const dmaint = intena && (level < 2) && (dma_12 != 0);
            const count_up = (busctl & 8) != 0;
            let is_jsr = 0;
            if (mci.k9_en) {
                switch (mci.k9_sel) {
                    case 0: /* TODO f12b */
                        is_jsr = 1;
                        break;
                    case 1: /* rir.0 nor 4 */
                        is_jsr = ((rir | (rir >> 4)) & 1) ^ 1;
                        break;
                    case 2: /* rir.0 */
                        is_jsr = rir & 1;
                        break;
                    case 3: /* TODO: double check this (mmio/reg addressed) */
                        is_jsr = is_regmmio;
                        break;
                    case 4: /* REG/pbit */
                        is_jsr = is_mem;
                        break;
                    case 5: /* DMA P2.13 */
                        is_jsr = dma_request();
                        break;
                    case 6: /* TODO B15A */
                        is_jsr = b15a ^ 1;
                        break;
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
            if (is_jsr != 0) {
                seq0_s = 3;
                seq1_s = 3;
                seq2_s = 3;
                seq_fc &= 2;
            }
            let datapath = 0;
            // Data Path Control
            switch (mci.dp_sel) {
                case 0:
                case 4: // R_SWP ⇒ DP
                    datapath = swap;
                    break;
                case 1:
                case 5: // R_REG(d13) ⇒ DP
                    datapath = rdr;
                    break;
                case 2:
                case 6: // R_ADM(rawH) ⇒ DP
                    datapath = ((memaddr >> 8) & 255) ^ 0xf0;
                    break;
                case 3:
                case 7: // R_ADL ⇒ DP
                    datapath = memaddr & 255;
                    break;
                case 8: // R_AddrPH ⇒ DP
                    datapath = pgaddr;
                    break;
                case 9: // CCR:sense ⇒ DP
                    // inverted on bus
                    datapath = ((ccr_l << 4) | (ccr_f << 5) | (ccr_m << 6) | (ccr_v << 7) | sense_switch) ^ 0xf0 /* sense sw */;
                    break;
                case 10: // R_SysDLatch ⇒ DP
                    datapath = memdata_in;
                    break;
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
            switch (mci.x_f6h6) {
                case 0:
                    aluc.carry_in = 0;
                    break;
                case 1:
                    aluc.carry_in = 1;
                    break;
                case 2:
                    aluc.carry_in = (alu_flag >> 3) & 1;
                    break;
                case 3:
                    aluc.carry_in = 0;
                    break;
            }
            aluc.resolve_alu(mci.aluc_s, mci.aluc_f, mci.aluc_d, mci.aluc_a, mci.aluc_b);
            let h6a = 0, h6b = 0;
            switch (mci.x_f6h6) {
                case 0:
                    h6a = aluc.sign;
                    h6b = 0;
                    break;
                case 1:
                    h6a = h6b = ((alu_flag >> 3) & 1);
                    break;
                case 2:
                    h6a = aluc.q0;
                    h6b = aluc.sign;
                    break;
                case 3:
                    h6a = aluc.main_carry_out;
                    h6b = 1;
                    break;
            }
            if (aluc.is_right) {
                // >> 3.h.0 >> 3.l.0 >>
                aluc.q7 = aluc.ram0;
                aluc.ram7 = h6a; // h6.Za
            }
            else {
                // << 3.h.0 << 3.l.0 <<
                aluc.q0 = h6b; // h6.Zb
                aluc.ram0 = aluc.q7;
            }
            let data_f = aluc.out_f;
            if (mci.x_h11 == 6) { // Select MAPROM to F
                data_f = uc.map[datapath];
            }
            // uses ALU flags, so must be after comb logic resolve
            if (mci.seq_branch == 0) {
                switch (mci.j13_sel) {
                    case 0: // |1 IF ALUF.S, |2 IF ALUF.Z
                        seq_or |= ((alu_flag & 2) != 0 ? 1 : 0);
                        seq_or |= ((alu_flag & 1) != 0 ? 2 : 0);
                        break;
                    case 1: // |1 IF ALUF.H, |2 IF ALUF.V
                        seq_or |= ((alu_flag & 16) != 0 ? 1 : 0);
                        seq_or |= ((alu_flag & 4) != 0 ? 2 : 0);
                        break;
                    case 2: // |1 IF ~pbit, |2 IF ~MMIO
                        seq_or |= notpgbit | (is_mmio << 1);
                        break;
                    case 3: break; // nop
                }
                switch (mci.k13_sel) { // mind the strange order of OR2/3 (|4 |8)
                    case 0: // |4 IF INT_EN, |8 IF CCR.Carry (Link)
                        if (intena)
                            seq_or |= 4; // TODO: trace
                        if (ccr_l != 0)
                            seq_or |= 8;
                        break;
                    case 1: // |4 IF DMA_INT, |8 IF INT_REQ
                        if (!dmaint)
                            seq_or |= 4; // TODO verify these work
                        if (!intreq)
                            seq_or |= 8; // TODO?
                        break;
                    case 2: // |4 IF MEM_INT, |8 IF DMA_REQ
                        //seq_or |= 4; // typically low
                        if (!dma_request())
                            seq_or |= 8; // typically high if no DMA connection
                        break;
                    case 3: break; // nop
                }
            }
            let rindex;
            if (mci.x_c14_sel) {
                rindex = (rir & 15) | (level << 4);
            }
            else {
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
                    dis_after = show_dis;
                    last_pc = memaddr;
                    last_map = pta;
                    let bfn = break_list[vmbreak[memaddr]];
                    if (bfn != null && bfn(0, memaddr, physaddr) && handle_break())
                        debug_output = true;
                }
                if ((run_step && (mcpc == 0x101)) || mclisting[mcpc].bp) {
                    if (handle_break())
                        debug_output = true;
                }
            }
            if (debug_output) {
                if (!show_uop)
                    return;
                let debug = mc_listing(mcpc, datapath, data_f, aluc.y);
                mcs_op.innerText = debug.seq;
                mcs_op_alu.innerText = debug.alu;
                mcs_op_bus.innerText = debug.rdr + ' ' + debug.bus;
                return;
            }
            if (mci.dp_sel == 11)
                resetting = false;
            switch (mci.x_k11) {
                case 0: break; // nop
                case 1:
                    mco.dma_end = false;
                    break; // L13A_SET
                case 2: // ?K11_2
                    if ((mci.busctlset == 1) && ((sysctl & 1) == 0)) {
                        console.log('DMA1:ON');
                    }
                    if ((mci.busctlset == 2) && ((sysctl & 2) == 0)) {
                        console.log('DMA2:ON');
                    }
                    if ((mci.busctlset == 128) && ((sysctl & 128) == 0)) {
                        reqlevel = bpl.ack_interrupt(level);
                        //console.log('IACK:', level,'->',reqlevel);
                    }
                    if ((mci.busctlmask == 127) && ((sysctl & 128) == 128)) {
                        reqlevel = 0;
                    }
                    sysctl = (sysctl & mci.busctlmask) | mci.busctlset;
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
                    }
                    else {
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
            switch (mci.x_e7) {
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
                    }
                    else if (sys_read_in) {
                        mco.memfault = 0;
                        memdata_in = bpl.readbyte(physaddr);
                        if ((busctl & 0x40) != 0) {
                            b15a = mco.memfault ^ 1;
                        }
                        else {
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
                if (!dma_current.dma_request) {
                    dma_control.end();
                }
                else {
                    dma_current.dma_step(dma_control);
                }
                if (workaddr == 0xffff)
                    mco.dma_end = true;
            }
            switch (mci.x_h11) {
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
                    break;
                }
                case 3: // WorkAddr_LDH
                    if (mci.x_e6 == 5) {
                        workaddr = (workaddr & 0x00ff) | (memaddr & 0xff00);
                    }
                    else {
                        workaddr = (workaddr & 0x00ff) | (result << 8);
                    }
                    break;
                case 4: // WorkAddr_Count
                    workaddr = (workaddr + (count_up ? 1 : -1)) & 0xffff;
                    break;
                case 5: // MemAddr_Count
                    memaddr = (memaddr + (count_up ? 1 : -1)) & 0xffff;
                    mempt_set();
                    break;
                case 6: break; // F=MapROM - handled farther above
                case 7: // NibSwap
                    swap = ((datapath << 4) | (datapath >> 4)) & 255;
                    break;
            }
            switch (mci.x_e6) {
                case 0: break; // nop case 0
                case 1:
                    result = data_f;
                    break; // F⇒Result
                case 2:
                    rir = data_f;
                    break; // F⇒RIdx
                case 3:
                    level = data_f >> 4;
                    break; // F⇒Level
                case 4:
                    pta = data_f & 7;
                    mempt_set();
                    break; // F⇒PTA
                case 5:
                    memaddr = prevwork;
                    mempt_set();
                    break; // ASwap
                case 6: // SEQ_RE
                    s0.h = data_f & 15;
                    s1.h = (data_f >> 4) & 15;
                    break;
                case 7: // conditions register
                    // alu_flag:
                    //  LHCVSZ
                    //  543210
                    // L<<3 F<<2 M<<1 V<<0
                    switch (mci.j12_sel) {
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
                        switch (mci.j11_sel | (prevflag & 0x4)) {
                            case 0:
                                ccr_f = (result >> 5) & 1;
                                break;
                            case 1:
                                ccr_f = 1;
                                break;
                            case 2: break;
                            case 3:
                                ccr_f = 0;
                                break;
                            case 4:
                                ccr_f = (result >> 5) & 1;
                                break;
                            case 5:
                                ccr_f = 1;
                                break;
                            case 6: break;
                            case 7:
                                ccr_f = 1;
                                break;
                        }
                    }
                    else {
                        ccr_f = 0;
                    }
                    if (mci.j10_en == 0) {
                        switch (mci.j10_sel) {
                            case 0: break;
                            case 1:
                                ccr_l = ccr_l ^ 1;
                                break;
                            case 2:
                                ccr_l = (prevflag >> 3) & 1;
                                break;
                            case 3:
                                ccr_l = 1;
                                break;
                            case 4:
                                ccr_l = (result >> 4) & 1;
                                break;
                            case 5:
                                ccr_l = aluc.ram7;
                                break;
                            case 6:
                                ccr_l = aluc.ram0;
                                break;
                            case 7:
                                ccr_l = aluc.q0;
                                break;
                        }
                    }
                    else {
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
            addr1a += (memaddr >> 1) & 1;
            addr2a += (memaddr >> 2) & 1;
            addr3a += (memaddr >> 3) & 1;
            addr4a += (memaddr >> 4) & 1;
            addr5a += (memaddr >> 5) & 1;
            addr6a += (memaddr >> 6) & 1;
            addr7a += (memaddr >> 7) & 1;
            addr8a += (memaddr >> 8) & 1;
            addr9a += (memaddr >> 9) & 1;
            addr10a += (memaddr >> 10) & 1;
            addr11a += (memaddr >> 11) & 1;
            addr12a += (memaddr >> 12) & 1;
            addr13a += (memaddr >> 13) & 1;
            addr14a += (memaddr >> 14) & 1;
            addr15a += (memaddr >> 15) & 1;
            level0a += level & 1;
            level1a += (level >> 1) & 1;
            level2a += (level >> 2) & 1;
            level3a += (level >> 3) & 1;
            aluc.step(mci.aluc_d, mci.aluc_b);
            mcpc = ((s2.output << 8) | (s1.output << 4) | (s0.output)) & 0x7ff;
            hs_wait = 0;
            run_hshw_steps();
            run_once = false;
        }
        return mco;
    }
    const mcsim = mcsetup();
    //@ts-ignore
    this.window.cpu = mcsim;
    const FN_K9 = [
        '0BusAct',
        '1RI.~0|4',
        '2RI.0',
        '3A=IOReg',
        '4A=RegPGR',
        '5DMA_REQ',
        '6MemFault',
        '7IntCheck' // this one needs a better name (checks multiple interrupt lines)
    ];
    const FN_F6 = ['0', '1', 'FL.C', '0'];
    const FN_H6A = ['alu.s', 'AFL.C', 'q0', 'alu.c'];
    const FN_H6B = ['0', 'AFL.C', 'alu.s', '1'];
    const FN_J12B = ['.', 'Z', 'R.V', 'LZ'];
    const FN_J12A = ['.', 'S', 'R.M', 'S'];
    const FN_J11 = ['R.F', '1', '.', 'alu.o', 'R.F', '1', '.', 'alu.o'];
    const FN_J10 = ['.', '~', 'C', '0', 'R.L', 'alu.7', 'alu.0/Q7', 'alu.Q0'];
    const FV_E6 = [
        '', 'Result', 'RI', 'Level',
        'PTA', '', 'SeqRH', ''
    ];
    const FN_H11 = [
        '', 'RD_START', 'WT_START', 'WorkAddr_H=Result',
        'WorkAddr_Count', 'MemAddr_Count', 'MapROM', 'NibSwap'
    ];
    const FN_E7 = ['', 'BusReady', '', 'BusEnd/DataRD'];
    const FN_D45 = [
        'SwapR', 'RDR', 'MemAddr_H', 'MemAddr_L', 'SwapR', 'RDR', 'MemAddr_H', 'MemAddr_L',
        'PA', 'CCRSense', 'SysDatIn', 'LevelH14', 'IrqLDipT', '' /*Const*/, '', ''
    ];
    const FN_M13 = ['P2.3', 'P2.4', 'RTC', 'MapDis', 'FP.Run', 'RTC.R', 'FP.ABT', 'INT_ACK'];
    const FN_F11 = ['IntEN', 'AddrToSys', 'DMACountDIS', 'AddrU/D', 'AddrCtlSel', 'ParityTest', 'ParityEN', 'DMA_EN'];
    function mc_listing(address, datapath, data_f, alu_y, flow) {
        const c0 = uc.c0[address];
        const c1 = uc.c1[address];
        const dp_sel = c0 & 15;
        const x_e6 = (c0 >> 4) & 7;
        const x_k11 = (c0 >> 7) & 7;
        const x_h11 = (c0 >> 10) & 7;
        const x_e7 = (c0 >> 13) & 3;
        const k9_en = ((c0 >> 15) & 1) == 0;
        const v2 = (c0 >> 16) & 255;
        const k9_sel = v2 & 7;
        const mpconst_m6 = v2 ^ 0xff; // goes through a 74ls240
        const j12_sel = v2 & 3;
        const j11_en = (c0 >> 18) & 1;
        const j11_sel = (c0 >> 19) & 3;
        const j13_sel = (c0 >> 20) & 3;
        const j10_en = (c0 >> 21) & 1;
        const j10_sel = (c0 >> 22) & 7;
        const k13_sel = (c0 >> 22) & 3;
        const seqjmp = (c0 >> 16) & 0x7ff; // for debug output
        const seq_fci = (c0 >> 27) & 3; // FE/PUP
        const seq0_si = (c0 >> 29) & 3;
        const seq12_s0i = (c0 >> 31) & 1;
        const seq2_si_k6b = seq12_s0i | ((c1 & 1) << 1);
        const seq1_si_k6dc = seq12_s0i | (2 ^ (2 & (c1 >> 21) & ((c1 << 1) ^ 2)));
        const seq_branch = (c1 >> 1) & 1;
        const rir0 = (c1 >> 21) & 1;
        const x_f6h6 = (c1 >> 19) & 3;
        const x_c14_sel = ((c1 >> 23) & 1) != 0;
        const aluc_s = (c1 >> 2) & 7;
        const aluc_f = (c1 >> 5) & 7;
        const aluc_d = (c1 >> 8) & 7;
        const busctld = (c1 >> 11) & 1;
        const busctla = (c1 >> 12) & 7;
        const aluc_b = (c1 >> 11) & 15;
        const aluc_a = (c1 >> 15) & 15;
        const k9_fn = (!k9_en ? '' : FN_K9[k9_sel]);
        if (k9_en && flow) {
            flow.branches.push({ address: seqjmp, is_push: true, source: [k9_fn] });
        }
        const seq0_s = 3 ^ seq0_si;
        const seq1_s = 3 ^ seq1_si_k6dc;
        const seq2_s = 3 ^ seq2_si_k6b;
        const seq_fc = seq_fci;
        let pc = (address + 1) & 0x7ff;
        let next = pc;
        let d_mask = 0;
        let r_mask = 0;
        let s_mask = 0;
        switch (seq0_s) {
            case 1:
                r_mask |= 0xf;
                break;
            case 2:
                s_mask |= 0xf;
                break;
            case 3:
                d_mask |= 0xf;
                break;
        }
        switch (seq1_s) {
            case 1:
                r_mask |= 0xf0;
                break;
            case 2:
                s_mask |= 0xf0;
                break;
            case 3:
                d_mask |= 0xf0;
                break;
        }
        switch (seq2_s) {
            case 2:
                s_mask |= 0xf00;
                break;
            case 3:
                d_mask |= 0xf00;
                break;
        }
        next = (pc & ((d_mask | r_mask | s_mask) ^ 0xfff)) | (seqjmp & d_mask);
        if (flow) {
            flow.next = next;
            flow.stack_mask = s_mask;
            flow.reg_mask = r_mask;
            if (seq_fc == 0) {
                flow.stack_op = true;
                flow.stack_push = false;
            } // POP
            if (seq_fc == 2) {
                flow.stack_op = true;
                flow.stack_push = true;
            } // PUSH PC
        }
        let d_branch = '';
        if (seq_branch == 0) {
            let d_branch0 = '';
            let d_branch1 = '';
            let d_branch2 = '';
            let d_branch3 = '';
            switch (j13_sel) {
                case 0:
                    if ((next | 1) != next)
                        d_branch0 = 'ALUF.S';
                    if ((next | 2) != next)
                        d_branch1 = 'ALUF.Z';
                    break;
                case 1:
                    if ((next | 1) != next)
                        d_branch0 = 'ALUF.H';
                    if ((next | 2) != next)
                        d_branch1 = 'ALUF.V';
                    break;
                case 2:
                    if ((next | 1) != next)
                        d_branch0 = '~pbit ';
                    if ((next | 2) != next)
                        d_branch1 = '~MMIO ';
                    break;
                case 3: break; // nop
            }
            switch (k13_sel) {
                case 0:
                    if ((next | 4) != next)
                        d_branch2 = 'INT_ENA';
                    if ((next | 8) != next)
                        d_branch3 = 'CCR.L  ';
                    break;
                case 1:
                    if ((next | 4) != next)
                        d_branch2 = 'DMA_INT';
                    if ((next | 8) != next)
                        d_branch3 = 'INT_REQ';
                    break;
                case 2:
                    if ((next | 4) != next)
                        d_branch2 = 'MEM_INT';
                    if ((next | 8) != next)
                        d_branch3 = 'DMA_REQ';
                    break;
                case 3: break; // nop
            }
            if (flow) {
                let mask = 0;
                if (d_branch0.length != 0)
                    mask |= 1;
                if (d_branch1.length != 0)
                    mask |= 2;
                if (d_branch2.length != 0)
                    mask |= 4;
                if (d_branch3.length != 0)
                    mask |= 8;
                for (let i = 1; i < 16; i++) {
                    if ((i & mask) != i)
                        continue;
                    if ((next | i) != next) {
                        let br = [];
                        if ((next | (i & 1)) != next)
                            br.push(d_branch0);
                        if ((next | (i & 2)) != next)
                            br.push(d_branch1);
                        if ((next | (i & 4)) != next)
                            br.push(d_branch2);
                        if ((next | (i & 8)) != next)
                            br.push(d_branch3);
                        flow.branches.push({ address: next | i, source: br });
                    }
                }
            }
            if (d_branch0.length != 0)
                d_branch += '|1:' + d_branch0;
            if (d_branch1.length != 0)
                d_branch += '|2:' + d_branch1;
            if (d_branch2.length != 0)
                d_branch += '|4:' + d_branch2;
            if (d_branch3.length != 0)
                d_branch += '|8:' + d_branch3;
        }
        let mcd_d45 = FN_D45[dp_sel];
        if (dp_sel == 13) {
            mcd_d45 += `#${hex(mpconst_m6)}`;
        }
        else if (datapath != undefined) {
            mcd_d45 += `(${hex(datapath)})`;
        }
        let disp_f = FV_E6[x_e6];
        let mck11 = '';
        switch (x_k11) {
            case 1:
                mck11 = 'DMAEndReset';
                break;
            case 2:
                mck11 = `SysCtl.${FN_M13[busctla]}=${busctld}`;
                break;
            case 3:
                mck11 = `BusCtl.${FN_F11[busctla]}=${busctld}`;
                break;
            case 4:
                mck11 = `REG[${x_c14_sel ? 'Lv' : ''}RI${rir0 != 0 ? '1' : ' '}]=Result`;
                break;
            case 5:
                mck11 = 'Page=Result';
                break;
            case 6:
                mck11 = 'WorkAddr_L=Result';
                break;
            case 7:
                if (disp_f.length == 0)
                    disp_f = 'SysDatOut';
                else
                    disp_f = 'SysDatOut= ' + disp_f;
                break;
        }
        let mch11 = FN_H11[x_h11];
        if (x_h11 == 6) { // TODO F=MapROM[DP] ignore ALU F
            mch11 = `${disp_f}=${mch11}[${mcd_d45}]`;
            disp_f = '';
        }
        let mce6 = '';
        // e6[0] nop, e6[1..4] load from F, e6[6] maybe load from F
        if (x_e6 == 5) { // MemAddr=WorkAddr, WorkAddr loads use MemAddr instead
            if (x_h11 == 3 && x_k11 == 6) { // IF Swap Enabled: WorkAddr=MemAddr
                mce6 = 'MemAddr<=>WorkAddr';
                mch11 = '';
                mck11 = '';
            }
            else { // an 8 bit only swap!?
                if (x_k11 == 6) {
                    mce6 = 'MemAddr_H=WorkAddr_H';
                    mck11 = 'WorkAddr_L<=>MemAddr_L';
                }
                else if (x_h11 == 3) {
                    mce6 = 'MemAddr_L=WorkAddr_L';
                    mch11 = 'WorkAddr_H<=>MemAddr_H';
                }
                else {
                    mce6 = 'MemAddr=WorkAddr';
                }
            }
        }
        // if right shift (aluc_d & 2) == 0: FN_H6A[x_f6h6] >> RAM7, RAM0>>Q7
        // if left shift: (aluc_d & 2) != 0: FN_H6B[x_f6h6] >> Q0, Q7>>RAM0
        let mcsh_r;
        let mcsh_q;
        if ((aluc_d & 2) == 0) {
            mcsh_r = FN_H6A[x_f6h6];
            mcsh_q = 'R.0';
        }
        else {
            mcsh_q = FN_H6B[x_f6h6];
            mcsh_r = 'Q.7';
        }
        let d_ccr = '';
        if (x_e7 == 2) {
            d_ccr = '  => ALUFlag_LD';
            if (disp_f.length == 0)
                disp_f = '_';
        }
        const lh = ALU.trace_str(aluc_s, aluc_f, aluc_d, aluc_a, aluc_b, mcsh_q, mcsh_r, disp_f, mcd_d45, FN_F6[x_f6h6]);
        // CCR load
        if (x_e6 == 7) {
            d_ccr += ` V=${FN_J12B[j12_sel]} M=${FN_J12A[j12_sel]} F=${j11_en ? '0' : FN_J11[j11_sel]} L=${j10_en ? '0' : FN_J10[j10_sel]}`;
        }
        const mce7 = FN_E7[x_e7];
        let mcbus = mck11;
        if (mch11.length > 0) {
            if (mcbus.length > 0)
                mcbus += ', ' + mch11;
            else
                mcbus = mch11;
        }
        if (mce6.length > 0) {
            if (mcbus.length > 0)
                mcbus += ', ' + mce6;
            else
                mcbus = mce6;
        }
        if (mce7.length > 0) {
            if (mcbus.length > 0)
                mcbus += ', ' + mce7;
            else
                mcbus = mce7;
        }
        return {
            seq: `${((datapath != undefined) ? hex(address, 3) : '')}:${hex(c1, 6)}${hex(c0, 8)} ${FN_SEQ_SN[seq2_s]} ${FN_SEQ_SN[seq1_s]} ${FN_SEQ_SN[seq0_s]} ${FN_SEQ_FE[seq_fc]} [${hex(seqjmp, 3)}>${hex(next, 3)}] ${k9_fn} ${d_branch}`,
            alu: (alu_y != undefined) ? `${lh} (${hex(data_f, 2)}:${hex(alu_y, 2)})${d_ccr}` : `${lh}${d_ccr}`,
            rdr: `RDR[${x_c14_sel ? 'Lv' : '  '}RI${rir0 != 0 ? '1' : ' '}]`,
            bus: mcbus
        };
    }
    const listmax = 100;
    const listing = [];
    (function () {
        for (let i = 0; i < listmax; i++) {
            const listnode = document.createElement('div');
            const item = {
                a_ref: 0,
                pre: document.createElement('div'),
                addr: document.createElement('div'),
                line: document.createElement('div'),
                hex: document.createElement('div'),
                ascii: document.createElement('div'),
                inst: document.createElement('div'),
                param: document.createElement('div'),
                comm: document.createElement('div')
            };
            listnode.appendChild(item.pre);
            listnode.appendChild(item.line);
            item.line.classList.add('line');
            item.addr.addEventListener('click', function () {
                console.log('bpt', hex(item.a_ref, 5));
                let v = bpl.readmeta(item.a_ref);
                v ^= 4096 /* MEMSTAT.ACC_BRK */;
                bpl.writemeta(item.a_ref, v);
                show_disasm();
            });
            item.line.appendChild(item.addr);
            item.line.appendChild(item.hex);
            item.line.appendChild(item.inst);
            item.line.appendChild(item.param);
            item.line.appendChild(item.comm);
            listing.push(item);
            d_listing.appendChild(listnode);
            d_listingc.appendChild(item.ascii);
        }
        for (let i = 0; i < 2048; i++) {
            const listnode = document.createElement('div');
            listnode.classList.add('regs');
            const leftnode = document.createElement('div');
            const rightnode = document.createElement('div');
            const addrnode = document.createElement('div');
            const bpnode = document.createElement('div');
            addrnode.innerHTML = `&#x03bc;Op ${hex(i, 3)}`;
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
            const listobj = {
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
            bpcnode.addEventListener('click', function (ev) {
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
            listobj.mc2.innerText = `${lo.rdr}, ${lo.bus}${lo.bus.length > 0 ? ', ' : ''}${lo.alu}`;
            mclisting.push(listobj);
            d_micro.appendChild(listnode);
        }
        let proc_flag = true;
        mclisting[0].flow.reached = true;
        mclisting[0].flow.from_main = ['Reset'];
        mclisting[0x100].flow.from_main = ['PreFetch'];
        mclisting[0x101].flow.from_main = ['Fetch'];
        let decent = 4096;
        function markflow(target, source, marker) {
            target.reached = true;
            if (marker != undefined) {
                marker = marker;
            }
            else if (source.from_main.length > 0) {
                marker = source.from_main[0];
            }
            if (marker != undefined && !target.from_main.includes(marker)) {
                target.from_main.push(marker);
            }
            if (!target.processed)
                proc_flag = true;
            if (!target.from.find((v) => v.from == source.id)) {
                let f = undefined;
                if (source.frame != undefined) {
                    f = source.frame.find((v) => v.ret == target.id);
                }
                if (f)
                    target.from.push({ from: source.id, origin: f.orig });
                else
                    target.from.push({ from: source.id });
            }
        }
        function flow_frame(target, from, is_stk, pushframe) {
            if (pushframe != undefined && target.flow.frame_ref !== undefined) { // pre-processed chain
                const poplisting = mclisting[target.flow.frame_ref];
                const popflow = poplisting.flow;
                const popframe = popflow.frame; // the frame containing a POP
                if (popframe) {
                    const is_refpop = popflow.stack_op && !popflow.stack_push;
                    if (is_refpop) {
                        // copy pasta? or common function?
                        let r = pushframe.ret;
                        popframe.push(pushframe);
                        r = (popflow.next & (popflow.stack_mask ^ 0xfff)) | (r & popflow.stack_mask);
                        // the return point flows from the end of the call
                        const retflow = mclisting[r].flow;
                        markflow(retflow, popflow);
                        //const frame = from.frame;
                        //if(frame) { // if the entry point is also a PUSH/CALL, move it's frames to the return point
                        //	delete from.frame;
                        //	retflow.frame = frame;
                        //	frame.forEach((v)=>{mclisting[v.entry].flow.frame_ref = retflow.id;});
                        //}
                    }
                    else {
                        popframe.push(pushframe);
                    }
                }
            }
            else if (pushframe != undefined) { // push a new frame
                target.left.classList.add('stk');
                //console.log('NEW FRAME', hex(from.id,3), hex(target.flow.id,3), hex(pushframe.orig,3));
                if (target.flow.frame == undefined) {
                    target.flow.frame = [pushframe];
                }
                else {
                    target.flow.frame.push(pushframe);
                    console.log('FRAME OVERLAP', hex(from.id, 3), hex(target.flow.id, 3), hex(pushframe.orig, 3));
                }
            }
            else if (from.frame != undefined && (!is_stk || pushframe)) { // move existing frame along a chain
                if (target.flow.processed) {
                    const frame = from.frame;
                    delete from.frame;
                    if (target.flow.frame == undefined) {
                        console.log('MOVE FRAME (PROC!)', hex(from.id, 3), hex(target.flow.id, 3));
                        target.flow.frame = frame;
                    }
                    else {
                        console.log('MERGE FRAME (PROC!)', hex(from.id, 3), hex(target.flow.id, 3));
                    }
                    frame.forEach((v) => { mclisting[v.entry].flow.frame_ref = target.flow.id; });
                }
                else if (target.flow.frame == undefined) {
                    //console.log('MOVE FRAME', hex(from.id,3), hex(target.flow.id,3));
                    const frame = from.frame;
                    delete from.frame;
                    target.flow.frame = frame;
                    frame.forEach((v) => { mclisting[v.entry].flow.frame_ref = target.flow.id; });
                }
                else {
                    const tframe = target.flow.frame;
                    // from.frame.forEach((v)=>{
                    // 	if(!tframe.ret.includes(v)) tframe.ret.push(v);
                    // });
                    // frame.entry.forEach((v)=>{
                    // 	mclisting[v].flow.frame_ref = target.flow.id;
                    // 	if(!tframe.entry.includes(v)) tframe.entry.push(v);
                    // });
                    console.warn('mc frame merge at', hex(target.flow.id, 3));
                }
            }
        }
        /////
        while (proc_flag) {
            proc_flag = false;
            for (let i = 0; i < 2048; i++) {
                const listobj = mclisting[i];
                const flow = listobj.flow;
                if (flow.reached && !flow.processed) {
                    flow.processed = true;
                    listobj.left.classList.add('mcrec');
                    const frame = flow.frame;
                    const is_push = flow.stack_op && flow.stack_push;
                    const is_pop = flow.stack_op && !flow.stack_push;
                    if (flow.next != i && flow.stack_mask == 0 && flow.reg_mask == 0) {
                        const tn = mclisting[flow.next];
                        const tf = tn.flow;
                        if (is_push) {
                            flow_frame(tn, flow, true, { ret: (i + 1) & 0x7ff, orig: i, entry: tf.id });
                        }
                        else {
                            flow_frame(tn, flow, flow.stack_op);
                        }
                        markflow(tf, flow);
                    }
                    else if (is_pop && flow.stack_mask != 0) {
                        // return to stack
                        if (frame != undefined) {
                            console.log('RETURN', hex(i, 3));
                            for (let k = 0; k < frame.length; k++) {
                                let r = frame[k].ret;
                                const retorigin = mclisting[frame[k].orig].flow;
                                r = (flow.next & (flow.stack_mask ^ 0xfff)) | (r & flow.stack_mask);
                                const retflow = mclisting[r].flow;
                                // if the entry point is also a PUSH/CALL, move it's frames to the return point
                                //frame.forEach((v)=>{mclisting[v.entry].flow.frame_ref = retflow.id;});
                                const origframe = retorigin.frame;
                                // if the return origin was carrying a frame
                                if (origframe) {
                                    delete retorigin.frame;
                                    retflow.frame = origframe;
                                    if (retflow.processed)
                                        console.warn('RETURN ORIGIN ALREADY PROCESSED');
                                    origframe.forEach((v) => { mclisting[v.entry].flow.frame_ref = retflow.id; });
                                }
                                markflow(retflow, flow);
                            }
                        }
                        else {
                            console.log('UNTRACED RETURN', hex(i, 3));
                        }
                    }
                    else if (flow.reg_mask != 0) {
                        const r_base = flow.next & (flow.reg_mask ^ 0xfff);
                        console.log('AHR JMP', hex(i, 3), hex(r_base, 3), hex(flow.reg_mask, 3));
                        // TODO
                    }
                    let br = flow.branches;
                    let clearflow = false;
                    for (let b = 0; b < br.length; b++) {
                        const n = br[b];
                        const brlisting = mclisting[n.address];
                        const brflow = brlisting.flow;
                        if (n.is_push) {
                            flow_frame(brlisting, flow, true, { ret: (i + 1) & 0x7ff, orig: i, entry: brflow.id });
                        }
                        else {
                            flow_frame(brlisting, flow, false);
                            clearflow = true;
                            flow.frame = frame;
                        }
                        if (n.source != undefined) {
                            markflow(brflow, flow, n.source[0]);
                        }
                        else {
                            markflow(brflow, flow);
                        }
                    }
                    if (clearflow) {
                        delete flow.frame;
                    }
                }
            }
        }
        for (let i = 0; i < 2048; i++) {
            const listobj = mclisting[i];
            const flow = listobj.flow;
            if (!flow.reached)
                continue;
            let br = '';
            for (let i = 0; i < flow.branches.length; i++) {
                let branch = flow.branches[i];
                if (branch.source)
                    br += `[${hex(branch.address, 3)} ${branch.source.join(' & ')}]`;
                else
                    br += `[${hex(branch.address, 3)}]`;
            }
            let f = [];
            for (let i = 0; i < flow.from_main.length; i++) {
                let v = flow.from_main[i];
                f.push(v);
            }
            for (let i = 0; i < flow.from.length; i++) {
                let v = flow.from[i];
                if (v.origin != undefined) {
                    f.push(`${hex(v.origin, 3)}>${hex(v.from, 3)}`);
                }
                else
                    f.push(hex(v.from, 3));
            }
            let fr = '';
            if (flow.frame_ref !== undefined) {
                fr += ` retn:${hex(flow.frame_ref, 3)}`;
            }
            if (flow.frame) {
                fr += flow.frame.map((v) => `<ret:${hex(v.ret, 3)} ent:${hex(v.entry, 3)} o:${hex(v.orig, 3)}>`).join(';');
            }
            listobj.mc3.innerText = `next:${hex(flow.next, 3)}/${hex(flow.stack_mask, 3)} from:${f.join(',')}${fr} ${br}`;
        }
    })();
    let last_memv_line = -1;
    function update_memview(is_scroll = false) {
        const mem_con = frame_memory.content;
        const col_a = mem_con.children[1];
        const col_d = mem_con.children[2];
        const col_t = mem_con.children[3];
        if (memory_elem.length == 0) {
            mem_con.addEventListener('scroll', function () {
                update_memview(true);
            });
            for (let i = 0; i < 32; i++) {
                const node_a = document.createElement('div');
                const node_d = document.createElement('div');
                const node_t = document.createElement('div');
                const line = { a: node_a, d: node_d, t: node_t };
                col_a.appendChild(node_a);
                col_d.appendChild(node_d);
                col_t.appendChild(node_t);
                memory_elem.push(line);
            }
        }
        const line_height = 22;
        const line_limit = 16384 - 32;
        let lines = (mem_con.scrollTop / line_height) | 0;
        if (lines > line_limit)
            lines = line_limit;
        if (is_scroll && last_memv_line == lines)
            return;
        last_memv_line = lines;
        memv_begin = lines * 16;
        memv_end = (lines + 32) * 16;
        let ofs = (lines * line_height);
        let top = `${ofs}px`;
        col_a.style.top = top;
        col_d.style.top = top;
        col_t.style.top = top;
        for (let i = 0; i < 32; i++) {
            const e = memory_elem[i];
            let n = (lines + i) * 16;
            e.a.innerText = hex(n, 5);
            let c = bpl.readmeta(n) & 255;
            let hs = hex(c);
            let ts;
            if (c > 159 && c < 255) {
                ts = String.fromCharCode(c & 127);
            }
            else {
                ts = '.';
            }
            for (let b = 1; b < 16; b++) {
                c = bpl.readmeta(n + b) & 255;
                hs += ' ' + hex(c);
                if (c > 159 && c < 255) {
                    ts += String.fromCharCode(c & 127);
                }
                else {
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
    // -2208988800000 // +2
    // -2208816000000 // +4
    const disk_origin_date = -2209161600000;
    const disk_file_types = [
        { t: 'D', x: 'RAW' },
        { t: 'B', x: 'BIN' },
        { t: 'A', x: 'TXT' },
        { t: 'C', x: 'BIN' },
        { t: 'E', x: 'BIN' },
        { t: 'L', x: 'VOL' },
        { t: 'I', x: 'RAW' },
        { t: 'S', x: 'RAWS' },
        { t: 'Q', x: 'RAWQ' },
        { t: 'X', x: 'FILE9' },
        { t: 'X', x: 'FILE10' },
        { t: 'X', x: 'FILE11' },
        { t: 'X', x: 'FILE12' },
        { t: 'X', x: 'FILE13' },
        { t: 'X', x: 'FILE14' },
        { t: ' ', x: 'FILE15' },
    ];
    class DiskViewer {
        constructor() {
            this.listing = [];
            this.listing_index = 0;
            this.datae = [];
            this.datae_index = 0;
            const listscrollbox = frame_disks.base.children[1];
            const datascrollbox = frame_disks.base.children[2];
            this.listing_lproxy = listscrollbox.children[0];
            this.listingc = listscrollbox.children[1];
            this.datae_lproxy = datascrollbox.children[0];
            this.datae_con_a = datascrollbox.children[1];
            this.datae_con_d = datascrollbox.children[2];
            this.datae_con_t = datascrollbox.children[3];
        }
        get_list_elem() {
            let li = this.listing[this.listing_index];
            if (li == null) {
                li = {
                    n: document.createElement('div')
                };
                this.listingc.appendChild(li.n);
                this.listing[this.listing_index] = li;
            }
            this.listing_index++;
            return li;
        }
        get_datae_elem() {
            let li = this.datae[this.datae_index];
            if (li == null) {
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
        update() {
            this.listing_index = 0;
            this.datae_index = 0;
            const self = this;
            function list_disk_name(n) {
                let li = self.get_list_elem();
                li.n.innerText = n;
            }
            function list_vol_name(n) {
                let li = self.get_list_elem();
                li.n.innerText = n;
            }
            function list_file_name(n) {
                let li = self.get_list_elem();
                li.n.innerText = n;
            }
            function fixed_str(data, ofs, count) {
                let s = '';
                for (let i = 0; i < count; i++) {
                    let c = data[ofs + i] & 127;
                    if (c == 0)
                        return s;
                    if (c < 32) {
                        switch (c) {
                            case 10:
                                s += '\\n';
                                break;
                            case 13:
                                s += '\\r';
                                break;
                            default:
                                s += '^' + hex(data[ofs + i]);
                        }
                    }
                    else
                        s += String.fromCharCode(c);
                }
                return s;
            }
            function u24(data, ofs) {
                return (data[ofs] << 16) | (data[ofs + 1] << 8) | data[ofs + 2];
            }
            function disk_date(dts) {
                let d = '';
                if (dts != 0) {
                    let fe_dts = disk_origin_date + (86400000 * dts);
                    d = (new Date(fe_dts)).toISOString().substring(0, 10);
                }
                return d;
            }
            function decode_image(im) {
                const stride = im.stride;
                const view = new DataView(im.backing_data);
                const max_sector_ofs = im.backing_data.byteLength;
                const max_sector = (max_sector_ofs / stride) | 0;
                let sector = im.stride * 16;
                let vol = fixed_str(im.data, sector, 10);
                const vol_reorg_date = view.getUint16(sector + 10, false);
                const vol_reorg_errs = view.getUint8(sector + 12);
                const vol_dir_sect = u24(im.data, sector + 13);
                if (vol_dir_sect == 0) {
                    vol = '<<< NUL >>>';
                }
                else if (vol_dir_sect >= max_sector) {
                    if (im.data[sector] == 0x84) {
                        if (im.data[sector + 1] == 0x0c)
                            vol = '<<< INIT >>>';
                        else
                            vol = `<<< ${hex(im.data[sector + 1])} >>>`;
                    }
                }
                let volx;
                if (vol_reorg_date == 0) {
                    volx = '<no reorg>';
                }
                else {
                    volx = `${disk_date(vol_reorg_date)} ${vol_reorg_errs}`;
                }
                list_vol_name(vol + ` ${volx} [${hex(vol_dir_sect, 6)}]`);
                let entry = 16;
                secloop: do {
                    do {
                        const esect = entry + sector;
                        if (im.data[esect] == 0x84 && im.data[esect + 1] == 0x8d) {
                            list_file_name(`<<EOL>>`);
                            break secloop;
                        }
                        const name = fixed_str(im.data, esect, 10);
                        if (name.length == 0) {
                            entry += 16;
                            continue;
                        }
                        const fe_map_idx = im.data[esect + 10] * 3;
                        const fe_map_sec = view.getUint16(esect + 11, false);
                        const fe_type = disk_file_types[im.data[esect + 13] & 0xf].t;
                        const fe_attr = im.data[esect + 13];
                        const fe_date = view.getUint16(esect + 14, false);
                        let fe_day = '';
                        if (fe_date != 0) {
                            let fe_dts = disk_origin_date + (86400000 * fe_date);
                            fe_day = (new Date(fe_dts)).toISOString().substring(0, 10);
                        }
                        const fm_sect = vol_dir_sect + fe_map_sec;
                        const fm_base = fm_sect * stride + fe_map_idx;
                        if (fm_sect >= max_sector || fe_map_idx >= 400) {
                            list_file_name(`${name} ${fe_type} <BAD:${hex(fe_map_sec, 4)}:${hex(fe_map_idx)}> ${fe_day}`);
                            entry += 16;
                            continue;
                        }
                        const fm_length = view.getUint16(fm_base, false) + 1;
                        const fm_begin_ptr = view.getUint16(fm_base + 2, false);
                        const fm_shift = im.data[fm_base + 4];
                        const fm_cls = im.data[fm_base + 5];
                        const fm_6 = u24(im.data, fm_base + 6);
                        if (fm_shift > 15) {
                            list_file_name(`${name} ${fe_type}:${hex(fe_attr)} <BAD:${hex(fe_map_sec, 4)}:${hex(fe_map_idx)}> <${hex(fm_length, 4)}:${hex(fm_begin_ptr, 4)}:${hex(fm_shift)}:${hex(fm_cls)}:${hex(fm_6, 6)}>`);
                        }
                        else {
                            let fm_len_t = fm_length >> 4;
                            let fm_len_s = fm_length & 15;
                            let fm_len_tx = `${fm_len_t}T`.padStart(4);
                            let fm_len_sx = `${fm_len_s}S`.padStart(3);
                            let fm_fsi_t;
                            if (fm_shift > 3) {
                                fm_fsi_t = `${1 << (fm_shift - 4)}T`.padStart(4);
                            }
                            else {
                                fm_fsi_t = `${1 << fm_shift}S`.padStart(4);
                            }
                            let fm_bbp_t = '';
                            if (fm_begin_ptr != 0x8000)
                                fm_bbp_t = ' ' + hex(fm_begin_ptr);
                            list_file_name(`${name} ${fe_type} ${fm_len_tx}${fm_len_sx}${fm_fsi_t} ${hex(fm_cls)}${fm_bbp_t} <${hex(fe_map_sec, 4)}:${hex(fe_map_idx)}> ${fe_day}`);
                        }
                        entry += 16;
                    } while (entry < 400);
                    entry = 0;
                    sector += stride;
                } while (sector < max_sector_ofs);
            }
            for (let name in disk_images) {
                list_disk_name(name);
                decode_image(disk_images[name]);
            }
        }
    }
    const disk_view = new DiskViewer();
    class DiagIO {
        constructor() {
            // TOS:1a, Aux:1d, Hawk:17-19, MUXINT:16, DMA:11/13
            this.dip = 0x0d;
            this.hexout = 0;
            this.points = 0;
            this.blank = false;
        }
        readmeta(address) { return 512 /* MEMSTAT.IO */; }
        writemeta(address, value) { }
        readbyte(f) {
            let v;
            switch (f) {
                case 6:
                    this.blank = false;
                    break;
                case 7:
                    this.blank = true;
                    break;
                case 8:
                    this.points |= 1;
                    break;
                case 9:
                    this.points &= 0xe;
                    break;
                case 10:
                    this.points |= 2;
                    break;
                case 11:
                    this.points &= 0xd;
                    break;
                case 12:
                    this.points |= 4;
                    break;
                case 13:
                    this.points &= 0xb;
                    break;
                case 14:
                    this.points |= 8;
                    break;
                case 15:
                    this.points &= 0x7;
                    break;
                case 16:
                    v = this.dip & 255;
                    return v;
                default:
                    console.log('DIAG R/W', hex(f));
                    return 0;
            }
            cx_diag.clearRect(0, 0, 40, 30);
            if (!this.blank)
                cx_diag.fillText('00', 10, 20);
            if ((this.points & 1) != 0)
                cx_diag.fillText('.', 5, 8);
            if ((this.points & 2) != 0)
                cx_diag.fillText('.', 5, 25);
            if ((this.points & 4) != 0)
                cx_diag.fillText('.', 25, 8);
            if ((this.points & 8) != 0)
                cx_diag.fillText('.', 25, 25);
            return 0;
        }
        writebyte(f, v) {
            if (f == 16)
                this.hexout = v;
            this.readbyte(f);
        }
    }
    const cx_diag0 = new DiagIO();
    let cx_dip = cx_diag0.dip;
    class DSK2Unit {
        constructor() {
            this.sel_address = 0;
            this.image = null;
        }
        set_disk(image) {
            this.image = image;
            console.log(`set disk to ${image === null || image === void 0 ? void 0 : image.filename}`);
        }
    }
    class DSK2 {
        constructor() {
            this.sel_unit = 0;
            this.units = [new DSK2Unit(), new DSK2Unit()];
            this.busy = false;
            this.busy_time = 0;
            this.wpmask = 0;
            this.seeking = false;
            this.seek_done = false;
            this.sect_remain = 0;
            this.stat_start_sector = 0;
            this.stat_transfer_count = 0;
            this.stat_log_transfers = false;
            this.command = -1;
            this.format_permit = false;
            this.interrupt_en = false;
            this.interrupt_pend = false;
            this.dma_request = false;
            this.dma_op = 0;
            this.verify_fail = false;
        }
        readmeta(address) { return 512 /* MEMSTAT.IO */; }
        writemeta(address, value) { }
        is_interrupt() {
            return false;
        }
        getlevel() {
            return 2; // not used, but seems like a good number :)
        }
        acknowledge() {
            let v = this.interrupt_pend;
            this.interrupt_pend = false;
            return v;
        }
        reset() {
            this.command = -1;
            this.format_permit = false;
            this.seeking = false;
            this.seek_done = false;
            this.busy = false;
            this.busy_time = 0;
            this.wpmask = 0;
            this.sel_unit = 0;
            this.interrupt_en = false;
            mcsim.dma_int(false);
        }
        tickbusy() {
            this.busy_time--;
            if (this.busy_time == 0) {
                this.busy = false;
                switch (this.command) {
                    case 0:
                    case 1:
                    case 4:
                    case 5:
                        if (this.stat_log_transfers)
                            console.log(`DSK C:${this.command} S:${hex(this.stat_start_sector, 4)} DMA:`, this.stat_transfer_count);
                        this.stat_transfer_count = 0;
                        if (this.interrupt_en)
                            mcsim.dma_int(true);
                        break;
                    case 6:
                        //if (this.interrupt_en) mcsim.dma_int(true);
                        break;
                    case 2:
                        this.seeking = false;
                        this.seek_done = true;
                        if (this.interrupt_en)
                            mcsim.dma_int(true);
                        break;
                    case 3:
                        this.seeking = false;
                        this.seek_done = true;
                        if (this.interrupt_en)
                            mcsim.dma_int(true);
                        break;
                    default:
                        if (this.command != -1) {
                            console.log('unknown command');
                        }
                }
                this.command = -1;
            }
        }
        run(increment) {
            if (this.busy_time > 0) {
                this.tickbusy();
            }
        }
        readbyte(address) {
            var _a;
            let v = 0;
            let unit = this.units[this.sel_unit];
            switch (address) {
                case 0:
                    v = this.sel_unit;
                    break;
                case 1: // cylh
                    if (unit) {
                        v = unit.sel_address >> 8;
                    }
                    break;
                case 2: // cyll:h:sec
                    if (unit) {
                        v = unit.sel_address & 0xff;
                    }
                    break;
                case 3: // wpmask?
                    v = this.wpmask;
                    break;
                case 4: // stat hi / 0 tmo adrerr fmterr | 0 seekerr fault busy
                    if (unit) {
                        v = ((this.busy || this.seeking) ? 1 : 0);
                    }
                    break;
                case 5: // stat lo / wtpr wten oncyl ready | seekcom3..0
                    if (unit) {
                        v = ((((_a = unit.image) === null || _a === void 0 ? void 0 : _a.protect) !== false) ? 0x80 : 0) /* wp */ |
                            ((this.wpmask & (1 << this.sel_unit)) ? 0x40 : 0) |
                            (this.seeking ? 0 : 0x20) /* oncyl */ |
                            (unit.image != null ? 0x10 : 0) /* ready */ |
                            (this.seek_done ? 0x01 : 0);
                    }
                    else {
                        v = 0;
                    }
                    break;
                case 8: // busy?
                    if (this.sel_unit == 1 || this.sel_unit == 0) {
                        v = ((this.busy || this.seeking) ? 1 : 0);
                    }
                    break;
                default:
                    console.log('DSK2:R:', hex(address, 1), hex(v));
            }
            return v;
        }
        dma_step(ctrl) {
            const unit = this.units[this.sel_unit];
            const unitdata = unit.image;
            if (unit == null || unitdata == null)
                return;
            if (mcsim.dma_end) {
                ctrl.end();
                this.busy_time = 10;
            }
            else {
                if (this.sect_remain <= 0) {
                    this.sect_remain = 400;
                    unit.sel_address = (unit.sel_address + 1) & 0xffff;
                }
                const fileaddr = unit.sel_address * unitdata.stride;
                if (this.dma_op == 0) {
                    // verify
                    let b = ctrl.read();
                    if (unitdata.data[fileaddr + 400 - this.sect_remain] != b) { }
                    this.verify_fail = true;
                }
                else if (this.dma_op == 1) {
                    // read
                    let b = unitdata.data[fileaddr + 400 - this.sect_remain];
                    ctrl.write(b);
                }
                else {
                    // write
                    let b = ctrl.read();
                    unitdata.data[fileaddr + 400 - this.sect_remain] = b;
                }
                this.sect_remain--;
                this.stat_transfer_count += 1;
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
        writebyte(address, value) {
            var _a;
            const unit = this.units[this.sel_unit];
            switch (address) {
                case 0:
                    this.sel_unit = value & 0x7;
                    break;
                case 1: // cylh
                    if (unit) {
                        unit.sel_address = (unit.sel_address & 0xff) | (value << 8);
                    }
                    break;
                case 2: // cyll:h:sec
                    if (unit) {
                        unit.sel_address = (unit.sel_address & 0xff00) | (value & 0xff);
                    }
                    break;
                case 3: // wpmask
                    this.wpmask = value & 0xff;
                    break;
                case 8: // cmd
                    if (unit == null)
                        break;
                    this.seek_done = false;
                    this.busy = true;
                    this.command = value;
                    if (value != 5) {
                        this.format_permit = false;
                    }
                    switch (value) {
                        case 0: // 0=read
                            //console.log('DSK2:read:', hex(u.sel_address, 4));
                            this.busy_time = 0;
                            this.sect_remain = 400;
                            this.stat_start_sector = unit.sel_address;
                            this.do_dma_read();
                            break;
                        case 1: // 1=write
                            this.busy_time = 1;
                            this.sect_remain = 400;
                            this.stat_start_sector = unit.sel_address;
                            if (((this.wpmask & (1 << this.sel_unit)) != 0) && (((_a = unit.image) === null || _a === void 0 ? void 0 : _a.protect) === false)) {
                                this.busy_time = 0;
                                //console.log('DSK2:do_write:', hex(u.sel_address, 4));
                                this.do_dma_write();
                            }
                            else {
                                console.log('DSK2:wp_write:', hex(unit.sel_address, 4));
                            }
                            break;
                        case 2: // 2=seek
                            //console.log('DSK2:seek:', hex(this.sel_address, 4));
                            this.busy_time = 40;
                            this.seeking = true;
                            break;
                        case 3: // 3=rtzcal
                            //console.log('DSK2:rtz');
                            this.busy_time = 200;
                            this.seeking = true;
                            break;
                        case 4: // verify (typically issued after cmd 1)
                            this.busy_time = 0;
                            this.sect_remain = 400;
                            this.stat_start_sector = unit.sel_address;
                            //console.log('DSK2:do_verify:', hex(u.sel_address, 4));
                            this.do_dma_verify();
                            break;
                        case 5: // format write
                            if (this.format_permit) {
                                this.busy_time = 0;
                                this.sect_remain = 400;
                                this.stat_start_sector = unit.sel_address;
                                this.do_dma_write();
                            }
                            else {
                                this.busy_time = 10;
                            }
                            break;
                        case 6: // format write permit
                            this.busy = false;
                            this.format_permit = true;
                            break;
                        default:
                            console.log('DSK2:cmd:', hex(value), hex(unit.sel_address, 4));
                            this.busy_time = 10;
                            break;
                    }
                    break;
                case 12:
                    if (this.interrupt_en) {
                        mcsim.dma_int(true);
                        //console.log('DSK2:W:IFORCE');
                    }
                    break;
                case 13:
                    this.interrupt_en = false;
                    mcsim.dma_int(false);
                    break;
                case 14:
                    this.interrupt_en = true;
                    break;
                case 15:
                    mcsim.dma_int(false);
                    break;
                default:
                    console.log('DSK2:W:', hex(address, 1), hex(value));
            }
            return;
        }
    }
    class MockPrinter {
        readmeta(address) { return 512 /* MEMSTAT.IO */; }
        writemeta(address, value) { }
        readbyte(address) {
            let value = 0;
            if (address == 1) {
                value = 31; // don't know the actual status, but this works :D
            }
            return value;
        }
        writebyte(address, value) {
            if (address == 0) {
                if (value > 127) {
                    let v = value & 127;
                    let c;
                    if (v == 12) {
                        c = "\u21ca\n";
                    }
                    else {
                        c = String.fromCodePoint(value & 127);
                    }
                    txt_anno.value += c;
                }
            }
        }
    }
    const UNIT_SELECT = [-1, 0, 1, -1, 2, -1, -1, -1, 3, -1, -1, -1, -1, -1, -1, -1];
    class FinchFloppyControl {
        constructor() {
            this.sys_data = 0;
            this.flag_cardtocpu = false; // bit 0
            this.flag_cputocard = false; // bit 1
            this.flag_2 = false; // bit 2
            this.busy = false; // bit 3
            this.interrupt_priority = 0;
            this.address = 0;
            this.cardram = new Uint8Array(0x1000);
            this.dma_read = false;
            this.dma_request = false;
            this.dma_active = false;
            this.dma_cycle = false;
            this.dcr1 = 0;
            this.dcr2 = 0;
            this.ssbc = 0;
            this.fdsr2s = 0;
            this.fdsr2r = 0;
            this.drive_sel_unit = -1;
            this.tsm = 255;
            this.tsm_timeout = 0;
            this.data_edge = 128;
            // unit vars
            this.sector_byte = 0;
            this.start_of_disk = false;
            this.start_of_sector = 0;
            this.unit_track = 7;
            this.rotation = 0;
            this.track_base = 0;
            this.last_rotation_index = 0;
            this.crc_valid = false;
            // Finch: 3600 RPM nominal (60 rev/s)
            // per rev: 1 index, 13440(0x3480) bytes, 107520 bits
            // 806400 bytes per second
            // servo/data clock: 6451200 Hz
            // max tracks: 0 to 0x25c / 0 to 604 / or 605 total
            this.unit_track_data = new Uint8Array(13440 * 605 * 4);
            // sector index pulse
            // 16 byte times
            // sector address block:
            // Pre:(0xA5) TrackH TrackL Platter# Sector# BlockCRC
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
            this.seq = new Sequencer8X02();
            this.aluc = new ALU8();
            this.flag_reg = 0;
            this.flag_dne = 0;
            this.log_enable = false;
            ffc_log.addEventListener('click', (ev) => {
                this.log_enable = !this.log_enable;
                style_if(ffc_log, 'active', this.log_enable);
            });
            style_if(ffc_log, 'active', this.log_enable);
        }
        is_interrupt() { return false; }
        getlevel() { return 0; }
        acknowledge() { return false; }
        readmeta(address) { return 512 /* MEMSTAT.IO */; }
        writemeta(address, value) { }
        // Clocks:
        // Count:  0   1   2   3   4   5   6   7   8   9  10  11  12
        // Shift . 1 . 1 . 1 . 1 . 1 . 1 . 1 . 1 . 1 . 1 . 1 . 1 . 1
        // Byte  . 1 1 1 1 1 1 1 1 . . . . . . . . 1 1 1 1 1 1 1 1 .
        // Index . . . . . 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 . . . . .
        run(increment) {
            if (this.log_enable)
                this.step(true, true);
            if (++this.rotation >= 107520) {
                this.rotation = 0;
                this.start_of_disk = true;
            }
            else if (this.rotation == 10)
                this.start_of_disk = false;
            let where = this.rotation >> 3;
            let phase = this.rotation & 7;
            if (phase == 0) {
                if (this.start_of_disk || this.sector_byte == 0xfff) {
                    this.sector_byte = this.ssbc;
                }
                else {
                    this.sector_byte++;
                }
            }
            else if (phase == 4) {
                if (this.start_of_disk || this.sector_byte == 0xfff)
                    this.start_of_sector = 2;
                else if (this.start_of_sector != 0)
                    this.start_of_sector--;
            }
            const ltsm = (this.tsm & 127);
            // writing to unit 1
            let frw;
            if (this.drive_sel_unit == 1) {
                const mpc = this.seq.p;
                const m0 = ffcmc.r1[mpc];
                const m6 = ffcmc.r7[mpc];
                const rds_sel = (m0 & 8) != 0;
                const crc_out = (m6 & 16) != 0;
                frw = (this.dcr1 & 0x40) | (this.dcr2 & 0x10);
                if (phase == 0 && rds_sel && frw == 0x40) {
                    let next = where + 1;
                    if (next >= 13440)
                        next = 0;
                    if ((this.unit_track_data[next + this.track_base] & 128) != 0) {
                        this.data_edge = 0;
                    }
                }
                if (phase == 7 && frw == 0x10) {
                    //txt_anno.value += `|${crc_out ?'RR':(this.fdsr2 == 0?'..':hex(this.fdsr2))}:${hex(this.sector_byte,3)}${hex(where,4)}${phase}`;
                    //if((where & 3) == 3) {txt_anno.value +='\n';}
                    this.unit_track_data[where + this.track_base] = this.fdsr2s;
                    this.fdsr2s = 0;
                }
            }
            // if(ltsm == 0x85 && this.data_edge == 0) {
            // txt_anno.value += `TSM Mark ${hex(where,4)}.${phase}\n`;
            // }
            this.tsm = ffcmc.tsm[ltsm | this.data_edge];
            this.data_edge |= 128;
            const tsmset = (ltsm ^ 127) & this.tsm;
            if ((ltsm != 0x05) && (this.tsm | this.data_edge) == 0x85) {
                txt_anno.value += `TSM Wait ${hex(where, 4)}.${phase}\n`;
            }
            if (this.drive_sel_unit == 1 && frw == 0x40 && (tsmset & 32) != 0) {
                this.fdsr2r = this.unit_track_data[where + this.track_base];
            }
            this.tsm_timeout++;
            if (this.tsm_timeout >= 255) {
                this.tsm_timeout = 0;
                this.tsm = 0x7f;
                txt_anno.value += `TSM Timeout ${this.track_base} ${hex(where, 4)}.${phase}\n`;
            }
            if ((ltsm & 3) == 0 && (this.tsm & 3) != 0) {
                this.step(false);
                this.tsm_timeout = 0;
            }
        }
        step(for_display, log = false) {
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
            const f1_sel = (m0 >> 4) & 7;
            const crc_ena = (m0 & 128) != 0;
            const k2_sel = m1 & 15;
            const k1_sel = (m1 >> 4) & 15;
            const flag_inv = m2 & 1;
            const e1_sel = (m2 >> 1) & 7;
            const test_inv = (m2 & 16) != 0;
            const d1_sel = (m2 >> 5) & 7;
            const alu_a = m4 & 15;
            const alu_b = m4 >> 4;
            const alu_s = m5 & 7;
            const addr_inc = (m5 & 8) != 0;
            const alu_f = (m5 >> 4) & 7;
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
            const e2_sel = (m7 >> 4) & 7;
            const seq_branch_hi = ((m7 << 2) & 0x200) | ((m7 << 5) & 0x100);
            const flag_reg = this.flag_reg;
            let data_in = 0;
            let where = this.rotation >> 3;
            let phase = this.rotation & 7;
            switch (k2_sel) {
                case 0: // TODO ReadFS1:
                    //FaultRst | ReadEna | CRCErr | LossOfSync | UnitSelect[3:0]
                    //if(!for_display)txt_anno.value += `ReadFS1\n`;
                    data_in = (this.crc_valid ? 0 : 0x20) | /*0x10 |*/ (this.dcr1 & 0xcf);
                    break;
                case 1:
                    data_in = 0xfc | (this.dcr2 & 3);
                    break; // ReadFS3
                case 2: // TODO ReadFS2
                    // Finch supplies Index on the main cable when selected
                    // FS2: Index | AtZero | WrFault | WrProt | EOS | Capacity[1:0] | Ready
                    if (this.drive_sel_unit == 1) {
                        data_in = (this.start_of_disk ? 0x80 : 0) |
                            0x10 | // wp
                            (this.unit_track == 0 ? 0x40 : 0) |
                            (this.start_of_sector != 0 ? 8 : 0) |
                            6 | // all the capacity!
                            1; // ready
                        // if(where < 0x18 || this.start_of_disk || this.start_of_sector!=0) {
                        // if(!for_display) txt_anno.value += `FS2:${this.start_of_disk?'Idx':''}${this.start_of_sector!=0?'Sec':''} ${hex(where,4)}.${phase}\n`;
                        // }
                    }
                    else {
                        data_in = 0;
                    }
                    break;
                case 3: // TODO ReadMCSR
                    if (!for_display)
                        txt_anno.value += `ReadMCSR\n`;
                    data_in = 0xff;
                    break;
                case 4:
                    if (!for_display)
                        txt_anno.value += `ReadFDSR1\n`;
                    data_in = 0xff;
                    break; // TODO ReadFSDR1
                case 5:
                    txt_anno.value += `Readnop5\n`;
                    break; // nop
                case 6: // TODO ReadFSDR2
                    if (crc_ena)
                        this.crc_valid = false;
                    if (this.drive_sel_unit == 1) {
                        if (!for_display) {
                            //run_control(false);
                            //txt_anno.value += `\\${hex(where, 4)}.${phase} ${hex(this.fdsr2)}\n`;
                        }
                        if (crc_ena) {
                            this.crc_valid = true;
                        }
                    }
                    data_in = this.fdsr2r;
                    break;
                case 7:
                    txt_anno.value += `Readnop7\n`;
                    break; // nop
                case 8:
                    data_in = 255 ^ this.address & 255;
                    break; // ReadIndexL
                case 9:
                    data_in = 255 ^ this.cardram[this.address];
                    break; // ReadRAM
                case 10: // ReadSysReg
                    data_in = 255 ^ this.sys_data;
                    this.flag_cputocard = false;
                    break;
                case 11: // ReadStatus
                    data_in = 255 ^ ((this.flag_cardtocpu ? 1 : 0) |
                        (this.flag_cputocard ? 2 : 0) |
                        (mcsim.dma_end ? 4 : 0));
                    break;
                case 12:
                    data_in = 255 ^ ((this.address >> 8) & 15);
                    break; // ReadIndexH
                case 13:
                    txt_anno.value += 'Readnop13\n';
                    break; // nop
                case 14:
                    txt_anno.value += 'Readnop14\n';
                    break; // nop
                case 15:
                    data_in = mval;
                    break; // ReadConst
            }
            this.aluc.in_data = data_in;
            switch (e2_sel) {
                case 0:
                    this.aluc.carry_in = 0;
                    break;
                case 1:
                    this.aluc.carry_in = 1;
                    break;
                case 2:
                    this.aluc.carry_in = 0;
                    break; // defer: Shift RamOut
                case 3:
                    this.aluc.carry_in = 0;
                    break; // defer: Shift QOut
                case 4:
                    this.aluc.carry_in = 1 ^ flag_reg;
                    break; // !flag
                case 5:
                    this.aluc.carry_in = flag_reg;
                    break; // flag
                case 6:
                    this.aluc.carry_in = 0;
                    break; // defer: carry
                case 7:
                    this.aluc.carry_in = 0;
                    break; // defer: sign
            }
            this.aluc.resolve_alu(alu_s, alu_f, alu_d, alu_a, alu_b);
            let shift_out_ram = 0;
            let shift_out_q = 0;
            if (this.aluc.is_right) { // Q7 >> ALU >> Q0, RAM7 >> ALU >> RAM0
                shift_out_q = this.aluc.q0;
                shift_out_ram = this.aluc.ram0;
            }
            else { // Q7 << ALU << Q0, RAM7 << ALU << RAM0
                shift_out_q = this.aluc.q7;
                shift_out_ram = this.aluc.ram7;
            }
            let deferred = false;
            // re-resolve on deferred change
            switch (e2_sel) {
                case 0: break; //0
                case 1: break; //1
                case 2:
                    deferred = true;
                    this.aluc.carry_in = shift_out_ram;
                    break; // Shift RamOut
                case 3:
                    deferred = true;
                    this.aluc.carry_in = shift_out_q;
                    break; // Shift QOut
                case 4: break; // !flag
                case 5: break; // flag
                case 6:
                    deferred = true;
                    this.aluc.carry_in = this.aluc.main_carry_out;
                    break; // carry
                case 7:
                    deferred = true;
                    this.aluc.carry_in = this.aluc.sign;
                    break; // sign
            }
            if (deferred) {
                this.aluc.resolve_alu(alu_s, alu_f, alu_d, alu_a, alu_b);
                if (this.aluc.is_right) { // Q7 >> ALU >> Q0, RAM7 >> ALU >> RAM0
                    shift_out_q = this.aluc.q0;
                    shift_out_ram = this.aluc.ram0;
                }
                else { // Q7 << ALU << Q0, RAM7 << ALU << RAM0
                    shift_out_q = this.aluc.q7;
                    shift_out_ram = this.aluc.ram7;
                }
            }
            let data_out = this.aluc.out_f;
            if (data_bridge) {
                data_out = data_in ^ 255;
            }
            if (for_display) {
                this.debug_output(data_in, data_out, log);
                return;
            }
            /////////////// Rising edge ///////////////
            if (dma_inc)
                this.dma_cycle = true;
            if (crc_reset)
                this.flag_dne = 0;
            switch (e1_sel) {
                case 0:
                    this.flag_reg = flag_inv ? 1 : 0;
                    break;
                case 1:
                    this.flag_reg = flag_inv ? flag_reg : 1 ^ flag_reg;
                    break;
                case 2:
                    this.flag_reg = flag_inv ? shift_out_ram : 1 ^ shift_out_ram;
                    break;
                case 3:
                    this.flag_reg = flag_inv ? shift_out_q : 1 ^ shift_out_q;
                    break;
                case 4:
                    this.flag_reg = flag_inv ? this.aluc.main_carry_out : 1 ^ this.aluc.main_carry_out;
                    break;
                case 5:
                    this.flag_reg = flag_inv ? this.aluc.over : 1 ^ this.aluc.over;
                    break;
                case 6:
                    this.flag_reg = flag_inv ? this.aluc.sign : 1 ^ this.aluc.sign;
                    break;
                case 7:
                    this.flag_reg = flag_inv ? this.aluc.half_carry_out : 1 ^ this.aluc.half_carry_out;
                    break;
            }
            let shift_in_q = 0;
            let shift_in_ram = 0;
            switch (f2_sel) {
                case 0:
                    shift_in_q = 0;
                    break;
                case 1:
                    shift_in_q = 1;
                    break;
                case 2:
                    shift_in_q = shift_out_ram;
                    break;
                case 3:
                    shift_in_q = shift_out_q;
                    break;
                case 4:
                    shift_in_q = 1 ^ flag_reg;
                    break;
                case 5:
                    shift_in_q = flag_reg;
                    break;
                case 6:
                    shift_in_q = this.aluc.main_carry_out;
                    break;
                case 7:
                    shift_in_q = this.aluc.sign;
                    break;
            }
            switch (f1_sel) {
                case 0:
                    shift_in_ram = 0;
                    break;
                case 1:
                    shift_in_ram = 1;
                    break;
                case 2:
                    shift_in_ram = shift_out_ram;
                    break;
                case 3:
                    shift_in_ram = shift_out_q;
                    break;
                case 4:
                    shift_in_ram = 1 ^ flag_reg;
                    break;
                case 5:
                    shift_in_ram = flag_reg;
                    break;
                case 6:
                    shift_in_ram = this.aluc.main_carry_out;
                    break;
                case 7:
                    shift_in_ram = this.aluc.sign;
                    break;
            }
            if (this.aluc.is_right) { // Q7 >> ALU >> Q0, RAM7 >> ALU >> RAM0
                this.aluc.q7 = shift_in_q;
                this.aluc.ram7 = shift_in_ram;
            }
            else { // Q7 << ALU << Q0, RAM7 << ALU << RAM0
                this.aluc.q0 = shift_in_q;
                this.aluc.ram0 = shift_in_ram;
            }
            let seq_test = 0;
            switch (d1_sel) { // this outputs the complement
                case 0:
                    seq_test = 1;
                    break; // always
                case 1:
                    seq_test = flag_reg;
                    break;
                case 2:
                    seq_test = this.aluc.zero;
                    break; // zero
                case 3:
                    seq_test = this.aluc.main_carry_out;
                    break; // carry
                case 4:
                    seq_test = this.aluc.over;
                    break; // overflow
                case 5:
                    seq_test = this.aluc.sign;
                    break; // sign
                case 6:
                    seq_test = this.flag_dne;
                    break; // Finch data verify
                case 7:
                    seq_test = 0;
                    txt_anno.value += 'MFMError\n';
                    break; // TODO rename these: disk_cond7
            }
            seq_test = test_inv ? seq_test : 1 ^ seq_test;
            const prev_address = this.address;
            if (addr_inc) {
                if (k1_sel == 8) { // LoadIndexL
                    if ((prev_address & 255) == 255) {
                        this.address = (this.address + 0x100) & 0xfff;
                    }
                }
                else if (k1_sel == 11) { // LoadIndexH
                    this.address = ((prev_address + 1) & 0xff) | (this.address & 0xf00);
                }
                else {
                    this.address = (prev_address + 1) & 0xfff;
                }
            }
            let bitset;
            switch (k1_sel) {
                case 0: // WriteDCR1
                    // FaultRst | RdEna | MFMCheck | FDSInDis | UnitSelect[3:0]
                    //txt_anno.value += `WriteDCR1 ${hex(data_out)}\n`;
                    bitset = (this.dcr1 ^ 255) & data_out;
                    this.dcr1 = data_out;
                    this.drive_sel_unit = UNIT_SELECT[data_out & 15];
                    if ((bitset & 0x40) != 0) {
                        let head = ((this.dcr2 >> 5) & 2) | ((this.dcr2 >> 3) & 1);
                        this.track_base = this.unit_track * 13440 + head * 8131200;
                        //txt_anno.value += `ReadEn ${hex(where,4)}.${phase}\n`;
                    }
                    break;
                case 1: // TODO WriteDCR2:
                    // FDDWrGate | HSel1 | LowCur | WrEna | HSel0 | HeadLd/RTZ | Dir | Step
                    bitset = (this.dcr2 ^ 255) & data_out;
                    let head = ((this.dcr2 >> 5) & 2) | ((this.dcr2 >> 3) & 1);
                    if ((bitset & 1) != 0) {
                        if ((data_out & 2) != 0) {
                            this.unit_track += 1;
                            if (this.unit_track > 604)
                                this.unit_track = 604;
                        }
                        else {
                            this.unit_track -= 1;
                            if (this.unit_track < 0)
                                this.unit_track = 0;
                        }
                        this.track_base = this.unit_track * 13440 + head * 8131200;
                        //txt_anno.value += `Step ${this.unit_track}\n`;
                    }
                    if ((bitset & 4) != 0) {
                        this.unit_track = 0;
                        this.track_base = this.unit_track * 13440 + head * 8131200;
                        //txt_anno.value += `RTZ\n`;
                    }
                    if ((bitset & 0x10) != 0) {
                        this.track_base = this.unit_track * 13440 + head * 8131200;
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
                    if (data_in != this.fdsr2r)
                        this.flag_dne = 1;
                    break;
                case 4: // WriteFDSR
                    this.fdsr2s = data_out;
                    break;
                case 5: // TODO WriteFloppyPulse - raw pulse output to the floppy
                    txt_anno.value += `WritePulse ${hex(where, 4)}.${phase}\n`;
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
                case 13:
                    this.interrupt_priority = data_out & 15;
                    break; // WriteIPL
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
        dma_step(ctrl) {
            if (this.dma_cycle) {
                this.dma_cycle = false;
                if (this.dma_read) {
                    this.sys_data = ctrl.read();
                    this.flag_cputocard = true;
                }
                else {
                    ctrl.write(this.sys_data);
                    this.flag_cardtocpu = false;
                }
            }
            if (!this.dma_active) {
                ctrl.end();
                return;
            }
        }
        debug_output(data_in, data_out, log = false) {
            if (!show_ffc)
                return;
            const mpc = this.seq.p;
            const m0 = ffcmc.r1[mpc];
            const m1 = ffcmc.r2[mpc];
            const m2 = ffcmc.r3[mpc];
            const mval = ffcmc.r4[mpc];
            const m4 = ffcmc.r5[mpc];
            const m5 = ffcmc.r6[mpc];
            const m6 = ffcmc.r7[mpc];
            const m7 = ffcmc.r8[mpc];
            const mcw0 = m0 | (m1 << 8) | (m2 << 16);
            const mcw1 = m4 | (m5 << 8);
            const mcw2 = m6 | (m7 << 8);
            const f2_sel = m0 & 7;
            const rds_sel = (m0 & 8) != 0;
            const f1_sel = (m0 >> 4) & 7;
            const crc_ena = (m0 & 128) != 0;
            const k2_sel = m1 & 15;
            const k1_sel = (m1 >> 4) & 15;
            const flag_inv = m2 & 1;
            const e1_sel = (m2 >> 1) & 7;
            const test_inv = (m2 & 16) != 0;
            const d1_sel = (m2 >> 5) & 7;
            const alu_a = m4 & 15;
            const alu_b = m4 >> 4;
            const alu_s = m5 & 7;
            const addr_inc = (m5 & 8) != 0;
            const alu_f = (m5 >> 4) & 7;
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
            const e2_sel = (m7 >> 4) & 7;
            const seq_branch_hi = ((m7 << 2) & 0x200) | ((m7 << 5) & 0x100);
            const FFC_DATA_IN = [
                'FS1', 'FS3', 'FS2', 'MCSR',
                'FDSR1', 'nop5', 'FDSR2', 'nop7',
                'AddrL', 'FFCRAM', 'SysReg', 'Status',
                'AddrH', 'nop13', 'nop14', ''
            ];
            const FFC_CARRY = ['0', '1', 'SROut', 'SQOut', '~F', 'F', 'ALU.C', 'ALU.S'];
            const FFC_FLAGI = ['1     ', 'Flag  ', 'SRO   ', 'SQO   ', 'ALU.C ', 'ALU.V ', 'ALU.S ', 'ALU.H '];
            const FFC_FLAGN = ['0     ', '~Flag ', '~SRO  ', '~SQO  ', '~ALU.C', '~ALU.V', '~ALU.S', '~ALU.H'];
            const FFC_SHIFT_IN = ['0', '1', 'SROut', 'SQOut', '~Flag', 'Flag', 'ALU.C', 'ALU.S'];
            const FFC_K1 = [
                'DCR1', 'DCR2', 'SSBCL', 'MCSR',
                'FDSRs', '', 'SSBCH', 'TSM',
                'AddrL', 'FFCRAM', 'SysReg', 'AddrH',
                'CtrlReg', 'IPL', '', ''
            ];
            const FFC_K1_SPL = [
                '', '', '', 'VerifyDat', '', 'FDDPulse', '', 'TSMReset',
                '', '', '', '', '', '', 'nop14', ''
            ];
            const FFC_TESTI = ['Alway', 'Flag ', 'Zero ', 'Carry', 'Ovr  ', 'Neg  ', 'fiDNE', 'MFMEr'];
            const FFC_TESTN = ['Never', '~Flag', 'NotZ ', 'NoCar', 'NoOvr', 'Pos  ', 'fiDOk', 'MFMOk'];
            let nextop;
            if (d1_sel == 0) {
                nextop = `AC:${(test_inv ? FN_8X02_A[seq_ac] : FN_8X02_N[seq_ac]).padEnd(12)} Branch=${hex(seq_branch_hi | data_out, 3)}`;
            }
            else {
                nextop = `AC:${FN_8X02_C[seq_ac]} ${test_inv ? FFC_TESTI[d1_sel] : FFC_TESTN[d1_sel]} Branch=${hex(seq_branch_hi | data_out, 3)}`;
            }
            const disp_data_in = k2_sel < 13 ? `${FFC_DATA_IN[k2_sel]}(${hex(data_in)})` : (k2_sel == 15 ? `#${hex(data_in)}` : '');
            const disp_data_out = k1_sel < 14 ? `${FFC_K1[k1_sel]}(${hex(data_out)})` : '';
            const seq = `${hex(this.seq.p, 3)}:${hex(mcw2, 4)}${hex(mcw1, 4)}:${hex(mval)}:${hex(mcw0, 6)} ${nextop}`;
            const alu = (ALU.trace_str(alu_s, alu_f, alu_d, alu_a, alu_b, FFC_SHIFT_IN[f2_sel], FFC_SHIFT_IN[f1_sel], data_bridge || disp_data_out.length == 0 ? '_' : disp_data_out, disp_data_in, FFC_CARRY[e2_sel]) + ` (${hex(this.aluc.y)})` +
                (data_bridge && disp_data_out.length > 0 ? `${disp_data_out} = ~${disp_data_in} ` : '') // ~36ch max
            ).padEnd(30) +
                ` Flag=${flag_inv ? FFC_FLAGI[e1_sel] : FFC_FLAGN[e1_sel]}`;
            const bus = `${FFC_K1_SPL[k1_sel].padEnd(9)} [${addr_inc ? 'A+' : '  '}${dma_inc ? 'D+' : '  '}${tp_d ? 'TP' : '  '} ${rds_sel ? 'fdd' : 'cry'} ${tsm_csel ? 'fic' : 'vco'} CRC${crc_out ? 'Out' : '_  '}${crc_reset ? 'Rst' : '_  '}${crc_ena ? 'EN' : 'DS'}]`;
            ffc_op_seq.innerText = seq;
            ffc_op_alu.innerText = alu;
            ffc_op_bus.innerText = bus;
            if (log) {
                txt_anno.value += `${seq} ${alu}\n${bus}\n`;
            }
            ffc_addr.innerText = hex(this.address, 3);
            //CTRL: 0000 | busy | status2 | DMARead | DMARun
            ffc_ctrl.innerText = `${this.busy ? 'Busy' : 'Idle'} ${this.flag_2 ? 'F2' : '--'} ${this.dma_request ? 'DMA' : '---'}:${this.dma_read ? 'R' : 'W'}`;
            ffc_ipl.innerText = hex(this.interrupt_priority, 1);
            ffc_sys.innerText = (this.flag_cputocard ? '>' : (this.flag_cardtocpu ? '<' : '=')) + hex(this.sys_data);
            /* dma_end | cpu->card | card->cpu */
            ffc_status.innerText = `${mcsim.dma_end ? 'END' : '---'} ${this.flag_cputocard ? 'FIN' : '---'} ${this.flag_cardtocpu ? 'FOUT' : '----'}`;
            ffc_track.innerText = hex(this.unit_track, 3);
            ffc_disk.innerText = `${hex(this.ssbc, 3)} ${hex(this.tsm)} ${hex(this.dcr2)} ${this.crc_valid ? 'OK' : 'DE'} ${this.start_of_disk ? 'I' : '-'}${this.start_of_sector != 0 ? 'S' : '-'}${hex(this.sector_byte, 3)}/${hex(this.rotation >> 3, 4)}`;
            const malu1 = hex(this.aluc.regq, 2) +
                ` ${(this.aluc.half_carry_out) != 0 ? 'H' : '-'}${(this.aluc.main_carry_out) != 0 ? 'C' : '-'}${(this.aluc.over) != 0 ? 'V' : '-'}${(this.aluc.sign) != 0 ? 'S' : '-'}${(this.aluc.zero) != 0 ? 'Z' : '-'} F=${this.flag_reg}`;
            let malu2 = '';
            let malu3 = '';
            for (let i = 0; i < 8; i++) {
                malu2 += hex(this.aluc.reg[i], 2) + ' ';
                malu3 += hex(this.aluc.reg[i + 8], 2) + ' ';
            }
            ffc_alu.innerText = malu1;
            ffc_alu2.innerText = malu2;
            ffc_alu3.innerText = malu3;
        }
        reset() {
            this.address = 0;
            this.interrupt_priority = 0;
            this.busy = false;
            this.flag_cardtocpu = false;
            this.flag_cputocard = false;
            this.dma_read = false;
            this.dma_active = false;
            this.seq.reset();
        }
        readbyte(address) {
            if (address == 0) { // data
                this.flag_cardtocpu = false;
                return this.sys_data;
            }
            else { // status
                return (this.busy ? 8 : 0) | (this.flag_2 ? 4 : 0) |
                    (this.flag_cputocard ? 2 : 0) | (this.flag_cardtocpu ? 1 : 0);
            }
        }
        writebyte(address, value) {
            if (address == 0) { // data
                this.sys_data = value;
                this.flag_cputocard = true;
            }
            else { // reset
                this.reset();
            }
        }
    }
    class TestCMD {
        constructor() {
            this.data_in = 0;
            this.data_out = 0;
            this.data_fout = false;
            this.data_fin = false;
            this.state = 0;
            this.address = 0;
            this.dma_len = 0;
            this.dma_request = false;
            this.dma_mode = 0;
            this.busy = false;
            this.cardram = new Uint8Array(0x1000);
            this.read_request = null;
            this.cancel_request = null;
            this.dma_complete = null;
            this.delay_request = null;
            this.delay_count = 0;
        }
        readmeta(address) { return 512 /* MEMSTAT.IO */; }
        writemeta(address, value) { }
        run(increment) {
            if (this.delay_count < 200) {
                this.delay_count += increment;
            }
            else {
                this.delay_count = 0;
                if (this.delay_request != null) {
                    this.delay_request();
                }
            }
            this.process();
        }
        async request8() {
            let v = await new Promise((resolve, reject) => {
                this.cancel_request = reject;
                this.read_request = resolve;
            });
            //console.log('CMD-RQ:', hex(v));
            this.cancel_request = null;
            return v;
        }
        async request16() {
            return ((await this.request8()) << 8) | (await this.request8());
        }
        // not to be confused with delay_request, this function just waits
        async request_delay() {
            return new Promise((resolve) => {
                this.delay_request = () => {
                    this.delay_request = null;
                    resolve();
                };
            });
        }
        dma_step(ctrl) {
            if (mcsim.dma_end || this.dma_len <= 0) {
                ctrl.end();
                if (this.dma_complete)
                    this.dma_complete();
                return;
            }
            if (this.dma_mode == 0) {
                this.cardram[this.address & 0xfff] = ctrl.read();
            }
            else {
                ctrl.write(this.cardram[this.address & 0xfff]);
            }
            this.address = (this.address + 1) & 0xfff;
            this.dma_len--;
        }
        async dma_in() {
            const last_cancel = this.cancel_request;
            return new Promise((resolve, reject) => {
                this.cancel_request = () => {
                    this.data_out = 35 /* CMDERR.DMA_LAG */;
                    this.data_fout = true;
                    this.dma_complete = null;
                    this.cancel_request = last_cancel;
                    this.dma_request = false;
                    reject();
                };
                this.dma_complete = () => {
                    this.dma_complete = null;
                    this.cancel_request = last_cancel;
                    resolve();
                };
                this.dma_request = true;
                this.dma_mode = 0;
                mcsim.dma_request();
            });
        }
        async dma_out() {
            return new Promise((resolve, reject) => {
                this.cancel_request = () => {
                    this.data_out = 35 /* CMDERR.DMA_LAG */;
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
        async io_command(index) {
            switch (index) {
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
                    if (this.address > 0xfff)
                        return 38 /* CMDERR.BUFFER_ADDRESS_ERROR */;
                    if (this.dma_len > 0xfff)
                        return 41 /* CMDERR.DATA_LENGTH_ERROR */;
                    await this.dma_in();
                    return 0;
                case 0x47: // card to CPU
                    this.address = await this.request16();
                    this.dma_len = await this.request16();
                    if (this.address > 0xfff)
                        return 38 /* CMDERR.BUFFER_ADDRESS_ERROR */;
                    if (this.dma_len > 0xfff)
                        return 41 /* CMDERR.DATA_LENGTH_ERROR */;
                    await this.dma_out();
                    return 0;
                default:
                //console.log('CMD-C', hex(index));
            }
            return 18 /* CMDERR.INVALID_COMMAND */;
        }
        process() {
            if (this.data_fin) {
                const fin = this.data_in;
                this.data_fin = false;
                if (this.read_request != null) {
                    let req = this.read_request;
                    this.read_request = null;
                    req.call(this, fin);
                }
                else if (!this.busy) {
                    this.busy = true;
                    this.io_command(fin).then((res) => {
                        this.data_out = res;
                        this.data_fout = true;
                    }).catch(() => {
                        console.log('CMD: io-cancel');
                    }).finally(() => {
                        //console.log('CMD-done');
                        this.busy = false;
                    });
                }
                else {
                    this.data_fin = true;
                }
            }
        }
        readbyte(address) {
            let value = 0;
            if (address == 1) {
                if (this.data_fout)
                    value |= 1;
                if (this.data_fin)
                    value |= 2;
                if (this.busy) {
                    //console.log('CMD-rdbusy');
                    value |= 8;
                }
            }
            else {
                this.data_fout = false;
                value = this.data_out;
            }
            return value;
        }
        writebyte(address, value) {
            if (address == 0) {
                this.data_in = value;
                //console.log('CMD:W:', hex(value), this.data_fin, this.read_request != null);
                this.data_fin = true;
                this.process();
            }
            else if (this.cancel_request != null) {
                this.cancel_request();
                this.cancel_request = null;
            }
        }
    }
    class MockTape9Tk {
        constructor() {
            this.data0 = 0;
            this.data_ctl = 0;
        }
        readmeta(address) { return 512 /* MEMSTAT.IO */; }
        writemeta(address, value) { }
        reset() {
            this.data_ctl = 0;
            this.data0 = 0;
        }
        readbyte(address) {
            switch (address) {
                case 0: return this.data0;
                case 1: return 0x2d;
                case 2: return 0xb3;
                default: console.log('Tape ?R<', address, 0);
            }
            return 0;
        }
        writebyte(address, value) {
            switch (address) {
                case 0:
                    this.data0 = value;
                    console.log('Tape D', hex(value));
                    return;
                case 1:
                    this.data_ctl = value;
                    return;
                case 2: console.log(`Tape ${hex(this.data0)} ctl:${hex(this.data_ctl)}.${hex(value)}`);
                case 3:
                    console.log('Tape ST', hex(value));
                    return;
                default: console.log('Tape ?W>', address, hex(value));
            }
        }
    }
    class MMIOTrace {
        constructor() {
            this.v = new Uint8Array(20);
        }
        readmeta(address) { return 512 /* MEMSTAT.IO */; }
        writemeta(address, value) { }
        readbyte(address) {
            let value = this.v[address];
            console.log('IOTrace-R', address, value);
            return value;
        }
        writebyte(address, value) {
            let c = ' ';
            if (value > 127) {
                c = String.fromCodePoint(value & 127);
            }
            console.log('IOTrace-W', address, value, c);
        }
    }
    class MMIOMulti {
        constructor() {
            this.devices = [];
        }
        readmeta(address) {
            for (let i = 0;; i++) {
                const devlist = this.devices[i];
                if (devlist == null)
                    return 0;
                if ((address >= devlist.address) && (address < devlist.end)) {
                    return devlist.dev.readmeta(address - devlist.address);
                }
            }
        }
        writemeta(address, value) {
            for (let i = 0;; i++) {
                const devlist = this.devices[i];
                if (devlist == null)
                    return;
                if ((address >= devlist.address) && (address < devlist.end)) {
                    devlist.dev.writemeta(address - devlist.address, value);
                    return;
                }
            }
        }
        adddev(subaddr, size, dev) {
            this.devices.push({ address: subaddr, end: subaddr + size, dev });
        }
        readbyte(address) {
            for (let i = 0;; i++) {
                const devlist = this.devices[i];
                if (devlist == null)
                    return 0;
                if ((address >= devlist.address) && (address < devlist.end)) {
                    return devlist.dev.readbyte(address - devlist.address);
                }
            }
        }
        writebyte(address, value) {
            for (let i = 0;; i++) {
                const devlist = this.devices[i];
                if (devlist == null)
                    return;
                if ((address >= devlist.address) && (address < devlist.end)) {
                    devlist.dev.writebyte(address - devlist.address, value);
                    return;
                }
            }
        }
    }
    class MUXPort {
        constructor(card) {
            this.write_busy = false;
            this.write_full = false;
            this.read_busy = false;
            this.read_full = false;
            this.read_buffer = 0;
            this._cts = true;
            this.buf_write = 0;
            this.line = null;
            this.card = card;
        }
        get cts() { return this._cts; }
        set cts(value) {
            this._cts = value;
            if (this.line != null)
                this.line.check_read();
        }
        reset() {
            this.write_busy = false;
            this.read_busy = false;
            this._cts = true;
            if (this.line) {
                this.line.clear_buffer();
            }
        }
        read_status() {
            return (this.write_busy ? 0 : 2) | (this.read_busy ? 1 : 0) | 0x20;
        }
        read_data() {
            let vcc = this.read_buffer;
            this.read_buffer = 0;
            this.read_busy = false;
            if (this.line != null)
                this.line.check_read();
            return vcc;
        }
        write_control(value) {
        }
        write_data(value) {
            var _a;
            this.write_busy = true;
            this.buf_write = value;
            this.write_busy = false;
            (_a = this.line) === null || _a === void 0 ? void 0 : _a.write(this.buf_write & 0x7f);
        }
        can_receive() {
            return this._cts && !this.read_busy;
        }
        receive(data) {
            this.read_buffer = data;
            this.read_busy = true;
            this.card.interrupt_pend = true;
            this.card.mux_cause = true;
        }
    }
    class MMIOMux {
        constructor() {
            this.muxports = [
                new MUXPort(this), new MUXPort(this),
                new MUXPort(this), new MUXPort(this)
            ];
            this.interrupt_level = 0;
            this.interrupt_en = false;
            this.interrupt_pend = false;
            this.mux_cause = false;
            this.tx_int = 0;
        }
        readmeta(address) { return 512 /* MEMSTAT.IO */; }
        writemeta(address, value) { }
        is_interrupt() {
            return this.interrupt_en && this.interrupt_pend;
        }
        getlevel() {
            return this.interrupt_level;
        }
        acknowledge() {
            //console.log('MUX:IACK');
            if (this.interrupt_pend) {
                this.interrupt_pend = false;
                return true;
            }
            return false;
        }
        reset() {
            this.interrupt_en = false;
            this.interrupt_level = 0;
            this.interrupt_pend = false;
            this.mux_cause = false;
            this.muxports[0].reset();
            this.muxports[1].reset();
            this.muxports[2].reset();
            this.muxports[3].reset();
        }
        readbyte(address) {
            let v = 0;
            if (address < 8) {
                let selmux = this.muxports[address >> 1];
                if (selmux) {
                    if ((address & 1) != 0)
                        v = selmux.read_data();
                    else
                        v = selmux.read_status();
                    if (this.tx_int > 0) {
                        this.interrupt_pend = true;
                        this.mux_cause = true;
                    }
                }
            }
            else if (address == 15) {
                if (this.mux_cause) {
                    this.mux_cause = false;
                    if (this.muxports[0].read_busy) {
                        v = 0; // (card_id << 4)
                    }
                    else if (this.muxports[1].read_busy) {
                        v = 2; // (card_id << 4)
                    }
                    else if (this.muxports[2].read_busy) {
                        v = 4; // (card_id << 4)
                    }
                    else if (this.muxports[3].read_busy) {
                        v = 6; // (card_id << 4)
                    }
                    else if (this.tx_int > 0) {
                        v = 0; // (card_id << 4)
                        for (let i = 0; i < 4; i++) {
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
            }
            else if (address < 16) {
                console.log('MUX:R:' + hex(address, 1), hex(v));
            }
            return v;
        }
        writebyte(address, value) {
            if (address < 8) {
                let port = address >> 1;
                let selmux = this.muxports[port];
                if (selmux) {
                    if ((address & 1) != 0) {
                        selmux.write_data(value);
                        this.tx_int |= 1 << port;
                        this.interrupt_pend = true;
                        this.mux_cause = true;
                    }
                    else {
                        selmux.write_control(value);
                    }
                }
            }
            else if (address == 8) { // CTS control
                let onoff = value & 1;
                let port = (value >> 1) & 3;
                let selmux = this.muxports[port];
                if (selmux) {
                    selmux.cts = (onoff == 0);
                }
            }
            else if (address == 10) {
                this.interrupt_level = value & 0xf;
            }
            else if (address == 12) {
                this.tx_int |= (value & 0xf);
                this.interrupt_pend = true;
                this.mux_cause = true;
                //console.log('MUX:IFORCE');
            }
            else if (address == 13) {
                this.interrupt_en = false;
            }
            else if (address == 14) {
                this.interrupt_en = true;
            }
            else if (address == 15) {
                this.reset();
            }
            else if (address < 16) {
                console.log('MUX:W:' + hex(address), hex(value));
            }
            return;
        }
    }
    class NullROM {
        readmeta(address) { return 512 /* MEMSTAT.IO */; }
        writemeta(address, value) { }
        writebyte(address, value) { }
        readbyte(address) {
            return 0;
        }
    }
    function loadbin(mem, v, addrfn) {
        const l = v.length;
        if (addrfn == null) {
            for (let a = 0; a < l; a++) {
                mem.writemeta(a, v[a]);
            }
        }
        else {
            let xm = addrfn.invert ? (l - 1) : 0;
            const remap = addrfn.remap;
            if (remap) {
                const aremapfn = function (addr_in) {
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
            }
            else {
                for (let a = 0; a < l; a++) {
                    let txa = a ^ xm;
                    mem.writemeta(a, v[txa]);
                }
            }
        }
        return mem;
    }
    // load a space/lf delimited list of hex values
    function loadhex(mem, h, ofs = 0) {
        let msh = h.split(/[ \n]/);
        let vpc = ofs;
        msh.forEach(value => {
            if (value !== '') {
                let v = parseInt(value, 16);
                mem.writemeta(vpc, v & 0xff);
                vpc++;
            }
        });
    }
    class SysMem {
        constructor() {
            this.memory = new Uint8Array(0x20000);
            this.pram = new Uint8Array(0x20000);
        }
        readmeta(address) {
            return this.memory[address] | (this.pram[address] << 8);
        }
        writemeta(address, value) {
            this.memory[address] = value & 255;
            const vhi = (value >> 8) & 254;
            value = value & 255;
            let pval = value ^ (value >> 4);
            pval = pval ^ (pval >> 2);
            pval = (pval ^ (pval >> 1)) & 1;
            this.pram[address] = vhi | pval;
        }
        readbyte(address) {
            const value = this.memory[address];
            let pval = value ^ (value >> 4);
            pval = pval ^ (pval >> 2);
            pval = (pval ^ (pval >> 1)) & 1;
            const mval = this.pram[address];
            mcsim.memfault = pval ^ (mval & 1);
            if ((mval & 112) != 0)
                handle_break();
            return value & 255;
        }
        writebyte(address, value) {
            value = value & 255;
            let pval = value ^ (value >> 4);
            pval = pval ^ (pval >> 2);
            pval = (pval ^ (pval >> 1) ^ mcsim.parity) & 1;
            this.pram[address] = (this.pram[address] & 254) | pval;
            this.memory[address] = value;
        }
    }
    class ROM512 {
        constructor() {
            this.contents = new Uint16Array(512);
        }
        readmeta(address) {
            return this.contents[address];
        }
        writemeta(address, value) {
            this.contents[address] = value;
        }
        readbyte(address) {
            let mval = this.contents[address];
            if ((mval & 28672) != 0)
                handle_break();
            return mval & 255;
        }
        writebyte(address, value) { }
    }
    class ROM2k {
        constructor() {
            this.contents = new Uint16Array(2048);
        }
        readmeta(address) {
            return this.contents[address];
        }
        writemeta(address, value) {
            this.contents[address] = value;
        }
        readbyte(address) {
            let mval = this.contents[address];
            if ((mval & 28672) != 0)
                handle_break();
            return mval & 255;
        }
        writebyte(address, value) { }
    }
    class RAM2k {
        constructor() {
            this.contents = new Uint8Array(2048);
        }
        readmeta(address) {
            return this.contents[address];
        }
        writemeta(address, value) {
            this.contents[address] = value & 255;
        }
        readbyte(address) {
            return this.contents[address];
        }
        writebyte(address, value) {
            this.contents[address] = value & 255;
        }
    }
    const regname = [
        'AH', 'AL', 'BH', 'BL', 'XH', 'XL', 'YH', 'YL',
        'ZH', 'ZL', 'SH', 'SL', 'CH', 'CL', 'PH', 'PL',
        'A', 'A!', 'B', 'B!', 'X', 'X!', 'Y', 'Y!',
        'Z', 'Z!', 'S', 'S!', 'C', 'C!', 'P', 'P!',
    ];
    const mmwlist = new Map([]);
    const mmiolist = new Map([
        [0x00fe, 'cpu_reg_ph15'],
        [0xf106, 'diag_unblank'],
        [0xf107, 'diag_blankhex'],
        [0xf108, 'dp1_set'],
        [0xf109, 'dp1_clear'],
        [0xf10a, 'dp2_set'],
        [0xf10b, 'dp2_clear'],
        [0xf10c, 'dp3_set'],
        [0xf10d, 'dp3_clear'],
        [0xf10e, 'dp4_set'],
        [0xf10f, 'dp4_clear'],
        [0xf110, 'diag_dip_hex'],
        [0xf201, 'mux0_rx_tx'],
        [0xf200, 'mux0_stat_ctl'],
        // TODO these correct?
        [0xf203, 'mux1_rx_tx'],
        [0xf202, 'mux1_stat_ctl'],
        [0xf205, 'mux2_rx_tx'],
        [0xf204, 'mux2_stat_ctl'],
        [0xf207, 'mux3_rx_tx'],
        [0xf206, 'mux3_stat_ctl'],
        [0xf208, 'mux_mmio_08'],
        [0xf209, 'mux_mmio_09'],
        [0xf20a, 'mux_mmio_0a'],
        [0xf20b, 'mux_mmio_0b'],
        [0xf20c, 'mux_mmio_0c'],
        [0xf20d, 'mux_mmio_0d'],
        [0xf20e, 'mux_mmio_0e'],
        [0xf20f, 'mux_mmio_0f'],
    ]);
    if (true) {
        for (let i = 0; i < 256; i++) {
            if ((i & 1) == 0) {
                mmwlist.set(i, `cpu_reg_${regname[16 + (i & 15)].toLowerCase()}${i >> 4}`);
            }
            mmiolist.set(i, `cpu_reg_${regname[(i & 15)].toLowerCase()}${i >> 4}`);
        }
    }
    const oplist = [
        // 0x0H
        { n: 'HALT', md: 0 /* OPM.IMPL */ },
        { n: 'NOP', md: 0 /* OPM.IMPL */ },
        { n: 'SF', md: 0 /* OPM.IMPL */ },
        { n: 'RF', md: 0 /* OPM.IMPL */ },
        { n: 'EI', md: 0 /* OPM.IMPL */ },
        { n: 'DI', md: 0 /* OPM.IMPL */ },
        { n: 'SL', md: 0 /* OPM.IMPL */ },
        { n: 'RL', md: 0 /* OPM.IMPL */ },
        { n: 'CL', nm: 'COML', md: 0 /* OPM.IMPL */ },
        { n: 'RSR', nm: 'RET', md: 0 /* OPM.IMPL */ },
        { n: 'RI', nm: 'RETI', md: 0 /* OPM.IMPL */ },
        { n: '!ill0B', md: 0 /* OPM.IMPL */ },
        { n: 'SYN', md: 0 /* OPM.IMPL */ },
        { n: 'PCX', nm: 'MOV', ms: 12 /* OPM.IMPL_R */, md: 12 /* OPM.IMPL_R */, w: 1 /* TXS.W */, sr: 14 /* REG.PC */, dr: 4 /* REG.X */ },
        { n: 'DLY', nm: 'DELAY', md: 0 /* OPM.IMPL */ },
        { n: 'RSV', nm: 'SVRET', md: 0 /* OPM.IMPL */ },
        // 0x1H
        { n: 'BL', md: 4 /* OPM.PCO */, w: 2 /* TXS.F */ },
        { n: 'BNL', md: 4 /* OPM.PCO */, w: 2 /* TXS.F */ },
        { n: 'BF', md: 4 /* OPM.PCO */, w: 2 /* TXS.F */ },
        { n: 'BNF', md: 4 /* OPM.PCO */, w: 2 /* TXS.F */ },
        { n: 'BZ', md: 4 /* OPM.PCO */, w: 2 /* TXS.F */ },
        { n: 'BNZ', md: 4 /* OPM.PCO */, w: 2 /* TXS.F */ },
        { n: 'BM', md: 4 /* OPM.PCO */, w: 2 /* TXS.F */ },
        { n: 'BP', md: 4 /* OPM.PCO */, w: 2 /* TXS.F */ },
        { n: 'BGE', md: 4 /* OPM.PCO */, w: 2 /* TXS.F */ },
        { n: 'BLE', md: 4 /* OPM.PCO */, w: 2 /* TXS.F */ },
        { n: 'BS1', md: 4 /* OPM.PCO */, w: 2 /* TXS.F */ },
        { n: 'BS2', md: 4 /* OPM.PCO */, w: 2 /* TXS.F */ },
        { n: 'BS3', md: 4 /* OPM.PCO */, w: 2 /* TXS.F */ },
        { n: 'BS4', md: 4 /* OPM.PCO */, w: 2 /* TXS.F */ },
        { n: 'BI', md: 4 /* OPM.PCO */, w: 2 /* TXS.F */ },
        { n: 'BCK', md: 4 /* OPM.PCO */, w: 2 /* TXS.F */ },
        // 0x2H
        { n: 'INRB', nm: 'INC', md: 11 /* OPM.RC */, w: 0 /* TXS.B */, i: 1 },
        { n: 'DCRB', nm: 'DEC', md: 11 /* OPM.RC */, w: 0 /* TXS.B */, i: 1 },
        { n: 'CLRB', md: 11 /* OPM.RC */, w: 0 /* TXS.B */ },
        { n: 'IVR', nm: 'NOT', md: 11 /* OPM.RC */, w: 0 /* TXS.B */ },
        { n: 'SRRB', nm: 'SRA', md: 11 /* OPM.RC */, w: 0 /* TXS.B */, i: 1 },
        { n: 'SLRB', nm: 'SLL', md: 11 /* OPM.RC */, w: 0 /* TXS.B */, i: 1 },
        { n: 'RRRB', nm: 'RORC', md: 11 /* OPM.RC */, w: 0 /* TXS.B */, i: 1 },
        { n: 'RLRB', nm: 'ROLC', md: 11 /* OPM.RC */, w: 0 /* TXS.B */, i: 1 },
        { n: 'INAB', nm: 'INC', md: 12 /* OPM.IMPL_R */, w: 0 /* TXS.B */, dr: 1 /* REG.AL */ },
        { n: 'DCAB', nm: 'DEC', md: 12 /* OPM.IMPL_R */, w: 0 /* TXS.B */, dr: 1 /* REG.AL */ },
        { n: 'CLAB', nm: 'CLR', md: 12 /* OPM.IMPL_R */, w: 0 /* TXS.B */, dr: 1 /* REG.AL */ },
        { n: 'IVAB', nm: 'NOT', md: 12 /* OPM.IMPL_R */, w: 0 /* TXS.B */, dr: 1 /* REG.AL */ },
        { n: 'SRAB', nm: 'SRA', md: 12 /* OPM.IMPL_R */, w: 0 /* TXS.B */, dr: 1 /* REG.AL */ },
        { n: 'SLAB', nm: 'SLL', md: 12 /* OPM.IMPL_R */, w: 0 /* TXS.B */, dr: 1 /* REG.AL */ },
        { n: 'page', md: 0 /* OPM.IMPL */, x: 2 /* OPL_EXT.PAGE */, xd: [
                ['c', 'c', 'i', 'i', 'i', 'i'],
                ["WPF", "RPF", "WPF1", "RPF1", "WPFH", "RPFH"],
                ["LDM", "STM", "LSM", "SSM", "FLM", "FFM"]
            ] },
        { n: 'dma.', md: 0 /* OPM.IMPL */, x: 3 /* OPL_EXT.DMA */, xd: [
                [],
                ['LDDMAA', 'STDMAA', 'LDDMAC', 'STDMAC', 'SETDMAM', 'SETDMAMR', 'EDMA', 'DDMA', 'LDISR', 'STISR'],
                ['LD.A', 'ST.A', 'LD.C', 'ST.C', 'LD.M', 'LD.M', 'EN', 'DIS', 'LD.S', 'ST.S']
            ] },
        // 0x3H
        { n: 'INR', nm: 'INC', md: 11 /* OPM.RC */, w: 1 /* TXS.W */, i: 1 },
        { n: 'DCR', nm: 'DEC', md: 11 /* OPM.RC */, w: 1 /* TXS.W */, i: 1 },
        { n: 'CLR', md: 11 /* OPM.RC */, w: 1 /* TXS.W */ },
        { n: 'IVR', nm: 'NOT', md: 11 /* OPM.RC */, w: 1 /* TXS.W */ },
        { n: 'SRR', nm: 'SRA', md: 11 /* OPM.RC */, w: 1 /* TXS.W */, i: 1 },
        { n: 'SLR', nm: 'SLL', md: 11 /* OPM.RC */, w: 1 /* TXS.W */, i: 1 },
        { n: 'RRR', nm: 'RORC', md: 11 /* OPM.RC */, w: 1 /* TXS.W */, i: 1 },
        { n: 'RLR', nm: 'ROLC', md: 11 /* OPM.RC */, w: 1 /* TXS.W */, i: 1 },
        { n: 'INA', nm: 'INC', md: 12 /* OPM.IMPL_R */, w: 1 /* TXS.W */, dr: 0 /* REG.A */ },
        { n: 'DCA', nm: 'DEC', md: 12 /* OPM.IMPL_R */, w: 1 /* TXS.W */, dr: 0 /* REG.A */ },
        { n: 'CLA', nm: 'CLR', md: 12 /* OPM.IMPL_R */, w: 1 /* TXS.W */, dr: 0 /* REG.A */ },
        { n: 'IVA', nm: 'NOT', md: 12 /* OPM.IMPL_R */, w: 1 /* TXS.W */, dr: 0 /* REG.A */ },
        { n: 'SRA', nm: 'SRA', md: 12 /* OPM.IMPL_R */, w: 1 /* TXS.W */, dr: 0 /* REG.A */ },
        { n: 'SLA', nm: 'SLL', md: 12 /* OPM.IMPL_R */, w: 1 /* TXS.W */, dr: 0 /* REG.A */ },
        { n: 'INX', nm: 'INC', md: 12 /* OPM.IMPL_R */, w: 1 /* TXS.W */, dr: 4 /* REG.X */ },
        { n: 'DCX', nm: 'DEC', md: 12 /* OPM.IMPL_R */, w: 1 /* TXS.W */, dr: 4 /* REG.X */ },
        // 0x4H
        { n: 'ADDB', md: 7 /* OPM.RR */, w: 0 /* TXS.B */ },
        { n: 'SUBB', md: 7 /* OPM.RR */, w: 0 /* TXS.B */ },
        { n: 'ANDB', md: 7 /* OPM.RR */, w: 0 /* TXS.B */ },
        { n: 'ORIB', nm: 'OR', md: 7 /* OPM.RR */, w: 0 /* TXS.B */ },
        { n: 'OREB', nm: 'XOR', md: 7 /* OPM.RR */, w: 0 /* TXS.B */ },
        { n: 'XFRB', nm: 'MOV', md: 7 /* OPM.RR */, w: 0 /* TXS.B */ },
        { n: 'BIG', md: 0 /* OPM.IMPL */, x: 4 /* OPL_EXT.BIG */, xd: [
                ['ADD', 'SUB', 'CMP', 'MOV', 'NEG', 'SMUL', 'DIV', 'DIVMOD', 'TOBIN', 'FMBIN'],
                ['A', 'S', 'C', 'ZAD', 'ZSU', 'M', 'D', 'DRM', 'CTB', 'CFB'],
            ] },
        { n: 'MEM', md: 0 /* OPM.IMPL */, x: 5 /* OPL_EXT.MEM */, xd: [
                [0, 1, 3, 2, 2, 2, 2, 2, 2, 6],
                ['CVXR', 'CPVR', 'MVVR', 'SCNR', 'MVFR', 'ANCR', 'ORCR', 'XRCR', 'CPFR', 'FILR'],
                ['XREC', 'CMPC', 'MOVEC', 'SCANC', 'MOVEF', 'ANDC', 'ORC', 'XORC', 'CMPF', 'FILL'], //2
            ] },
        { n: 'AABB', nm: 'ADD', ms: 12 /* OPM.IMPL_R */, md: 12 /* OPM.IMPL_R */, w: 0 /* TXS.B */, sr: 1 /* REG.AL */, dr: 3 /* REG.BL */ },
        { n: 'SABB', nm: 'SUB', ms: 12 /* OPM.IMPL_R */, md: 12 /* OPM.IMPL_R */, w: 0 /* TXS.B */, sr: 1 /* REG.AL */, dr: 3 /* REG.BL */ },
        { n: 'NABB', nm: 'AND', ms: 12 /* OPM.IMPL_R */, md: 12 /* OPM.IMPL_R */, w: 0 /* TXS.B */, sr: 1 /* REG.AL */, dr: 3 /* REG.BL */ },
        { n: 'XAXB', nm: 'MOV', ms: 12 /* OPM.IMPL_R */, md: 12 /* OPM.IMPL_R */, w: 0 /* TXS.B */, sr: 1 /* REG.AL */, dr: 5 /* REG.XL */ },
        { n: 'XAYB', nm: 'MOV', ms: 12 /* OPM.IMPL_R */, md: 12 /* OPM.IMPL_R */, w: 0 /* TXS.B */, sr: 1 /* REG.AL */, dr: 7 /* REG.YL */ },
        { n: 'XABB', nm: 'MOV', ms: 12 /* OPM.IMPL_R */, md: 12 /* OPM.IMPL_R */, w: 0 /* TXS.B */, sr: 1 /* REG.AL */, dr: 3 /* REG.BL */ },
        { n: 'XAZB', nm: 'MOV', ms: 12 /* OPM.IMPL_R */, md: 12 /* OPM.IMPL_R */, w: 0 /* TXS.B */, sr: 1 /* REG.AL */, dr: 9 /* REG.ZL */ },
        { n: 'XASB', nm: 'MOV', ms: 12 /* OPM.IMPL_R */, md: 12 /* OPM.IMPL_R */, w: 0 /* TXS.B */, sr: 1 /* REG.AL */, dr: 11 /* REG.SL */ },
        // 0x5H
        { n: 'ADD', md: 7 /* OPM.RR */, w: 1 /* TXS.W */ },
        { n: 'SUB', md: 7 /* OPM.RR */, w: 1 /* TXS.W */ },
        { n: 'AND', md: 7 /* OPM.RR */, w: 1 /* TXS.W */ },
        { n: 'ORI', nm: 'OR', md: 7 /* OPM.RR */, w: 1 /* TXS.W */ },
        { n: 'ORE', nm: 'XOR', md: 7 /* OPM.RR */, w: 1 /* TXS.W */ },
        { n: 'XFR', nm: 'MOV', md: 10 /* OPM.RRS */, w: 1 /* TXS.W */ },
        { n: 'EAO', md: 0 /* OPM.IMPL */ },
        { n: 'DAO', md: 0 /* OPM.IMPL */ },
        { n: 'AAB', nm: 'ADD', ms: 12 /* OPM.IMPL_R */, md: 12 /* OPM.IMPL_R */, w: 1 /* TXS.W */, sr: 0 /* REG.A */, dr: 2 /* REG.B */ },
        { n: 'SAB', nm: 'SUB', ms: 12 /* OPM.IMPL_R */, md: 12 /* OPM.IMPL_R */, w: 1 /* TXS.W */, sr: 0 /* REG.A */, dr: 2 /* REG.B */ },
        { n: 'NAB', nm: 'AND', ms: 12 /* OPM.IMPL_R */, md: 12 /* OPM.IMPL_R */, w: 1 /* TXS.W */, sr: 0 /* REG.A */, dr: 2 /* REG.B */ },
        { n: 'XAX', nm: 'MOV', ms: 12 /* OPM.IMPL_R */, md: 12 /* OPM.IMPL_R */, w: 1 /* TXS.W */, sr: 0 /* REG.A */, dr: 4 /* REG.X */ },
        { n: 'XAY', nm: 'MOV', ms: 12 /* OPM.IMPL_R */, md: 12 /* OPM.IMPL_R */, w: 1 /* TXS.W */, sr: 0 /* REG.A */, dr: 6 /* REG.Y */ },
        { n: 'XAB', nm: 'MOV', ms: 12 /* OPM.IMPL_R */, md: 12 /* OPM.IMPL_R */, w: 1 /* TXS.W */, sr: 0 /* REG.A */, dr: 2 /* REG.B */ },
        { n: 'XAZ', nm: 'MOV', ms: 12 /* OPM.IMPL_R */, md: 12 /* OPM.IMPL_R */, w: 1 /* TXS.W */, sr: 0 /* REG.A */, dr: 8 /* REG.Z */ },
        { n: 'XAS', nm: 'MOV', ms: 12 /* OPM.IMPL_R */, md: 12 /* OPM.IMPL_R */, w: 1 /* TXS.W */, sr: 0 /* REG.A */, dr: 10 /* REG.S */ },
        // 0x6H
        { n: 'LDX', nm: 'LD', ms: 1 /* OPM.IMM */, w: 1 /* TXS.W */, md: 12 /* OPM.IMPL_R */, dr: 4 /* REG.X */ },
        { n: 'LDX', nm: 'LD', ms: 2 /* OPM.DIR */, w: 1 /* TXS.W */, md: 12 /* OPM.IMPL_R */, dr: 4 /* REG.X */ },
        { n: 'LDX', nm: 'LD', ms: 3 /* OPM.IND */, w: 1 /* TXS.W */, md: 12 /* OPM.IMPL_R */, dr: 4 /* REG.X */ },
        { n: 'LDX', nm: 'LD', ms: 4 /* OPM.PCO */, w: 1 /* TXS.W */, md: 12 /* OPM.IMPL_R */, dr: 4 /* REG.X */ },
        { n: 'LDX', nm: 'LD', ms: 5 /* OPM.IPO */, w: 1 /* TXS.W */, md: 12 /* OPM.IMPL_R */, dr: 4 /* REG.X */ },
        { n: 'LDX', nm: 'LD', ms: 6 /* OPM.MOD */, w: 1 /* TXS.W */, md: 12 /* OPM.IMPL_R */, dr: 4 /* REG.X */ },
        { n: 'SVC', nm: 'SVCALL', ms: 1 /* OPM.IMM */, w: 0 /* TXS.B */, md: 0 /* OPM.IMPL */ },
        { n: 'MEM', md: 0 /* OPM.IMPL */, x: 5 /* OPL_EXT.MEM */, sr: 0 /* REG.A */, xd: [
                [0, 1, 3, 2, 2, 2, 2, 2, 2, 6],
                ['CVXR', 'CPVR', 'MVVR', 'SCNR', 'MVFR', 'ANCR', 'ORCR', 'XRCR', 'CPFR', 'FILR'],
                ['XREC', 'CMPC', 'MOVEC', 'SCANC', 'MOVEF', 'ANDC', 'ORC', 'XORC', 'CMPF', 'FILL'], //2
            ] },
        { n: 'STX', nm: 'ST', md: 1 /* OPM.IMM */, ms: 12 /* OPM.IMPL_R */, w: 1 /* TXS.W */, sr: 4 /* REG.X */ },
        { n: 'STX', nm: 'ST', md: 2 /* OPM.DIR */, ms: 12 /* OPM.IMPL_R */, w: 1 /* TXS.W */, sr: 4 /* REG.X */ },
        { n: 'STX', nm: 'ST', md: 3 /* OPM.IND */, ms: 12 /* OPM.IMPL_R */, w: 1 /* TXS.W */, sr: 4 /* REG.X */ },
        { n: 'STX', nm: 'ST', md: 4 /* OPM.PCO */, ms: 12 /* OPM.IMPL_R */, w: 1 /* TXS.W */, sr: 4 /* REG.X */ },
        { n: 'STX', nm: 'ST', md: 5 /* OPM.IPO */, ms: 12 /* OPM.IMPL_R */, w: 1 /* TXS.W */, sr: 4 /* REG.X */ },
        { n: 'STX', nm: 'ST', md: 6 /* OPM.MOD */, ms: 12 /* OPM.IMPL_R */, w: 1 /* TXS.W */, sr: 4 /* REG.X */ },
        { n: 'LST', nm: 'LDST', md: 2 /* OPM.DIR */, w: 0 /* TXS.B */ },
        { n: 'SST', nm: 'STST', md: 0 /* OPM.IMPL */, ms: 2 /* OPM.DIR */, w: 0 /* TXS.B */ },
        // 0x7H
        { n: '!ill', md: 1 /* OPM.IMM */, w: 2 /* TXS.F */ },
        { n: 'JMP', md: 2 /* OPM.DIR */, w: 2 /* TXS.F */ },
        { n: 'JMP', md: 3 /* OPM.IND */, w: 2 /* TXS.F */ },
        { n: 'JMP', md: 4 /* OPM.PCO */, w: 2 /* TXS.F */ },
        { n: 'JMP', md: 5 /* OPM.IPO */, w: 2 /* TXS.F */ },
        { n: 'JMP', md: 6 /* OPM.MOD */, w: 2 /* TXS.F */ },
        { n: 'EPE', nm: 'EN.PEF', md: 0 /* OPM.IMPL */ },
        { n: 'MUL', md: 8 /* OPM.RRX */, w: 1 /* TXS.W */ },
        { n: 'DIV', md: 8 /* OPM.RRX */, w: 1 /* TXS.W */ },
        { n: 'JSR', nm: 'CALL', md: 2 /* OPM.DIR */, w: 2 /* TXS.F */ },
        { n: 'JSR', nm: 'CALL', md: 3 /* OPM.IND */, w: 2 /* TXS.F */ },
        { n: 'JSR', nm: 'CALL', md: 4 /* OPM.PCO */, w: 2 /* TXS.F */ },
        { n: 'JSR', nm: 'CALL', md: 5 /* OPM.IPO */, w: 2 /* TXS.F */ },
        { n: 'JSR', nm: 'CALL', md: 6 /* OPM.MOD */, w: 2 /* TXS.F */ },
        { n: 'STK', md: 0 /* OPM.IMPL */, x: 0 /* OPL_EXT.MPUSH */ },
        { n: 'POP', md: 0 /* OPM.IMPL */, x: 1 /* OPL_EXT.MPOP */ },
        // 0x8H
        { n: 'LDAB', nm: 'LD', ms: 1 /* OPM.IMM */, md: 12 /* OPM.IMPL_R */, w: 0 /* TXS.B */, dr: 1 /* REG.AL */ },
        { n: 'LDAB', nm: 'LD', ms: 2 /* OPM.DIR */, md: 12 /* OPM.IMPL_R */, w: 0 /* TXS.B */, dr: 1 /* REG.AL */ },
        { n: 'LDAB', nm: 'LD', ms: 3 /* OPM.IND */, md: 12 /* OPM.IMPL_R */, w: 0 /* TXS.B */, dr: 1 /* REG.AL */ },
        { n: 'LDAB', nm: 'LD', ms: 4 /* OPM.PCO */, md: 12 /* OPM.IMPL_R */, w: 0 /* TXS.B */, dr: 1 /* REG.AL */ },
        { n: 'LDAB', nm: 'LD', ms: 5 /* OPM.IPO */, md: 12 /* OPM.IMPL_R */, w: 0 /* TXS.B */, dr: 1 /* REG.AL */ },
        { n: 'LDAB', nm: 'LD', ms: 6 /* OPM.MOD */, md: 12 /* OPM.IMPL_R */, w: 0 /* TXS.B */, dr: 1 /* REG.AL */ },
        { n: 'DPE', nm: 'DIS.PEF', md: 0 /* OPM.IMPL */ },
        { n: '!ill87', md: 0 /* OPM.IMPL */ },
        { n: 'LAAB', nm: 'LD', ms: 13 /* OPM.IMPL_R_DIR */, md: 12 /* OPM.IMPL_R */, w: 0 /* TXS.B */, sr: 0 /* REG.A */, dr: 1 /* REG.AL */ },
        { n: 'LABB', nm: 'LD', ms: 13 /* OPM.IMPL_R_DIR */, md: 12 /* OPM.IMPL_R */, w: 0 /* TXS.B */, sr: 2 /* REG.B */, dr: 1 /* REG.AL */ },
        { n: 'LAXB', nm: 'LD', ms: 13 /* OPM.IMPL_R_DIR */, md: 12 /* OPM.IMPL_R */, w: 0 /* TXS.B */, sr: 4 /* REG.X */, dr: 1 /* REG.AL */ },
        { n: 'LAYB', nm: 'LD', ms: 13 /* OPM.IMPL_R_DIR */, md: 12 /* OPM.IMPL_R */, w: 0 /* TXS.B */, sr: 6 /* REG.Y */, dr: 1 /* REG.AL */ },
        { n: 'LAZB', nm: 'LD', ms: 13 /* OPM.IMPL_R_DIR */, md: 12 /* OPM.IMPL_R */, w: 0 /* TXS.B */, sr: 8 /* REG.Z */, dr: 1 /* REG.AL */ },
        { n: 'LASB', nm: 'LD', ms: 13 /* OPM.IMPL_R_DIR */, md: 12 /* OPM.IMPL_R */, w: 0 /* TXS.B */, sr: 10 /* REG.S */, dr: 1 /* REG.AL */ },
        { n: 'LACB', nm: 'LD', ms: 13 /* OPM.IMPL_R_DIR */, md: 12 /* OPM.IMPL_R */, w: 0 /* TXS.B */, sr: 12 /* REG.C */, dr: 1 /* REG.AL */ },
        { n: 'LAPB', nm: 'LD', ms: 13 /* OPM.IMPL_R_DIR */, md: 12 /* OPM.IMPL_R */, w: 0 /* TXS.B */, sr: 14 /* REG.PC */, dr: 1 /* REG.AL */ },
        // 0x9H
        { n: 'LDA', nm: 'LD', ms: 1 /* OPM.IMM */, md: 12 /* OPM.IMPL_R */, w: 1 /* TXS.W */, dr: 0 /* REG.A */ },
        { n: 'LDA', nm: 'LD', ms: 2 /* OPM.DIR */, md: 12 /* OPM.IMPL_R */, w: 1 /* TXS.W */, dr: 0 /* REG.A */ },
        { n: 'LDA', nm: 'LD', ms: 3 /* OPM.IND */, md: 12 /* OPM.IMPL_R */, w: 1 /* TXS.W */, dr: 0 /* REG.A */ },
        { n: 'LDA', nm: 'LD', ms: 4 /* OPM.PCO */, md: 12 /* OPM.IMPL_R */, w: 1 /* TXS.W */, dr: 0 /* REG.A */ },
        { n: 'LDA', nm: 'LD', ms: 5 /* OPM.IPO */, md: 12 /* OPM.IMPL_R */, w: 1 /* TXS.W */, dr: 0 /* REG.A */ },
        { n: 'LDA', nm: 'LD', ms: 6 /* OPM.MOD */, md: 12 /* OPM.IMPL_R */, w: 1 /* TXS.W */, dr: 0 /* REG.A */ },
        { n: 'SOP', nm: 'SET.PO', md: 0 /* OPM.IMPL */ },
        { n: '!ill97', md: 0 /* OPM.IMPL */ },
        { n: 'LAA', nm: 'LD', ms: 13 /* OPM.IMPL_R_DIR */, md: 12 /* OPM.IMPL_R */, w: 1 /* TXS.W */, sr: 0 /* REG.A */, dr: 0 /* REG.A */ },
        { n: 'LAB', nm: 'LD', ms: 13 /* OPM.IMPL_R_DIR */, md: 12 /* OPM.IMPL_R */, w: 1 /* TXS.W */, sr: 2 /* REG.B */, dr: 0 /* REG.A */ },
        { n: 'LAX', nm: 'LD', ms: 13 /* OPM.IMPL_R_DIR */, md: 12 /* OPM.IMPL_R */, w: 1 /* TXS.W */, sr: 4 /* REG.X */, dr: 0 /* REG.A */ },
        { n: 'LAY', nm: 'LD', ms: 13 /* OPM.IMPL_R_DIR */, md: 12 /* OPM.IMPL_R */, w: 1 /* TXS.W */, sr: 6 /* REG.Y */, dr: 0 /* REG.A */ },
        { n: 'LAZ', nm: 'LD', ms: 13 /* OPM.IMPL_R_DIR */, md: 12 /* OPM.IMPL_R */, w: 1 /* TXS.W */, sr: 8 /* REG.Z */, dr: 0 /* REG.A */ },
        { n: 'LAS', nm: 'LD', ms: 13 /* OPM.IMPL_R_DIR */, md: 12 /* OPM.IMPL_R */, w: 1 /* TXS.W */, sr: 10 /* REG.S */, dr: 0 /* REG.A */ },
        { n: 'LAC', nm: 'LD', ms: 13 /* OPM.IMPL_R_DIR */, md: 12 /* OPM.IMPL_R */, w: 1 /* TXS.W */, sr: 12 /* REG.C */, dr: 0 /* REG.A */ },
        { n: 'LAP', nm: 'LD', ms: 13 /* OPM.IMPL_R_DIR */, md: 12 /* OPM.IMPL_R */, w: 1 /* TXS.W */, sr: 14 /* REG.PC */, dr: 0 /* REG.A */ },
        // 0xAH
        { n: 'STAB', nm: 'ST', ms: 12 /* OPM.IMPL_R */, md: 1 /* OPM.IMM */, w: 0 /* TXS.B */, sr: 1 /* REG.AL */ },
        { n: 'STAB', nm: 'ST', ms: 12 /* OPM.IMPL_R */, md: 2 /* OPM.DIR */, w: 0 /* TXS.B */, sr: 1 /* REG.AL */ },
        { n: 'STAB', nm: 'ST', ms: 12 /* OPM.IMPL_R */, md: 3 /* OPM.IND */, w: 0 /* TXS.B */, sr: 1 /* REG.AL */ },
        { n: 'STAB', nm: 'ST', ms: 12 /* OPM.IMPL_R */, md: 4 /* OPM.PCO */, w: 0 /* TXS.B */, sr: 1 /* REG.AL */ },
        { n: 'STAB', nm: 'ST', ms: 12 /* OPM.IMPL_R */, md: 5 /* OPM.IPO */, w: 0 /* TXS.B */, sr: 1 /* REG.AL */ },
        { n: 'STAB', nm: 'ST', ms: 12 /* OPM.IMPL_R */, md: 6 /* OPM.MOD */, w: 0 /* TXS.B */, sr: 1 /* REG.AL */ },
        { n: 'SEP', nm: 'SET.PE', md: 0 /* OPM.IMPL */ },
        { n: '!illA7', md: 0 /* OPM.IMPL */ },
        { n: 'SAAB', nm: 'ST', ms: 12 /* OPM.IMPL_R */, md: 13 /* OPM.IMPL_R_DIR */, w: 0 /* TXS.B */, sr: 1 /* REG.AL */, dr: 0 /* REG.A */ },
        { n: 'SABB', nm: 'ST', ms: 12 /* OPM.IMPL_R */, md: 13 /* OPM.IMPL_R_DIR */, w: 0 /* TXS.B */, sr: 1 /* REG.AL */, dr: 2 /* REG.B */ },
        { n: 'SAXB', nm: 'ST', ms: 12 /* OPM.IMPL_R */, md: 13 /* OPM.IMPL_R_DIR */, w: 0 /* TXS.B */, sr: 1 /* REG.AL */, dr: 4 /* REG.X */ },
        { n: 'SAYB', nm: 'ST', ms: 12 /* OPM.IMPL_R */, md: 13 /* OPM.IMPL_R_DIR */, w: 0 /* TXS.B */, sr: 1 /* REG.AL */, dr: 6 /* REG.Y */ },
        { n: 'SAZB', nm: 'ST', ms: 12 /* OPM.IMPL_R */, md: 13 /* OPM.IMPL_R_DIR */, w: 0 /* TXS.B */, sr: 1 /* REG.AL */, dr: 8 /* REG.Z */ },
        { n: 'SASB', nm: 'ST', ms: 12 /* OPM.IMPL_R */, md: 13 /* OPM.IMPL_R_DIR */, w: 0 /* TXS.B */, sr: 1 /* REG.AL */, dr: 10 /* REG.S */ },
        { n: 'SACB', nm: 'ST', ms: 12 /* OPM.IMPL_R */, md: 13 /* OPM.IMPL_R_DIR */, w: 0 /* TXS.B */, sr: 1 /* REG.AL */, dr: 12 /* REG.C */ },
        { n: 'SAPB', nm: 'ST', ms: 12 /* OPM.IMPL_R */, md: 13 /* OPM.IMPL_R_DIR */, w: 0 /* TXS.B */, sr: 1 /* REG.AL */, dr: 14 /* REG.PC */ },
        // 0xBH
        { n: 'STA', nm: 'ST', ms: 12 /* OPM.IMPL_R */, md: 1 /* OPM.IMM */, w: 1 /* TXS.W */, sr: 0 /* REG.A */ },
        { n: 'STA', nm: 'ST', ms: 12 /* OPM.IMPL_R */, md: 2 /* OPM.DIR */, w: 1 /* TXS.W */, sr: 0 /* REG.A */ },
        { n: 'STA', nm: 'ST', ms: 12 /* OPM.IMPL_R */, md: 3 /* OPM.IND */, w: 1 /* TXS.W */, sr: 0 /* REG.A */ },
        { n: 'STA', nm: 'ST', ms: 12 /* OPM.IMPL_R */, md: 4 /* OPM.PCO */, w: 1 /* TXS.W */, sr: 0 /* REG.A */ },
        { n: 'STA', nm: 'ST', ms: 12 /* OPM.IMPL_R */, md: 5 /* OPM.IPO */, w: 1 /* TXS.W */, sr: 0 /* REG.A */ },
        { n: 'STA', nm: 'ST', ms: 12 /* OPM.IMPL_R */, md: 6 /* OPM.MOD */, w: 1 /* TXS.W */, sr: 0 /* REG.A */ },
        { n: 'ECK', nm: 'EN.CK', md: 0 /* OPM.IMPL */ },
        { n: '!illB7', md: 0 /* OPM.IMPL */ },
        { n: 'SAA', nm: 'ST', ms: 12 /* OPM.IMPL_R */, md: 13 /* OPM.IMPL_R_DIR */, w: 1 /* TXS.W */, sr: 0 /* REG.A */, dr: 0 /* REG.A */ },
        { n: 'SAB', nm: 'ST', ms: 12 /* OPM.IMPL_R */, md: 13 /* OPM.IMPL_R_DIR */, w: 1 /* TXS.W */, sr: 0 /* REG.A */, dr: 2 /* REG.B */ },
        { n: 'SAX', nm: 'ST', ms: 12 /* OPM.IMPL_R */, md: 13 /* OPM.IMPL_R_DIR */, w: 1 /* TXS.W */, sr: 0 /* REG.A */, dr: 4 /* REG.X */ },
        { n: 'SAY', nm: 'ST', ms: 12 /* OPM.IMPL_R */, md: 13 /* OPM.IMPL_R_DIR */, w: 1 /* TXS.W */, sr: 0 /* REG.A */, dr: 6 /* REG.Y */ },
        { n: 'SAZ', nm: 'ST', ms: 12 /* OPM.IMPL_R */, md: 13 /* OPM.IMPL_R_DIR */, w: 1 /* TXS.W */, sr: 0 /* REG.A */, dr: 8 /* REG.Z */ },
        { n: 'SAS', nm: 'ST', ms: 12 /* OPM.IMPL_R */, md: 13 /* OPM.IMPL_R_DIR */, w: 1 /* TXS.W */, sr: 0 /* REG.A */, dr: 10 /* REG.S */ },
        { n: 'SAC', nm: 'ST', ms: 12 /* OPM.IMPL_R */, md: 13 /* OPM.IMPL_R_DIR */, w: 1 /* TXS.W */, sr: 0 /* REG.A */, dr: 12 /* REG.C */ },
        { n: 'SAP', nm: 'ST', ms: 12 /* OPM.IMPL_R */, md: 13 /* OPM.IMPL_R_DIR */, w: 1 /* TXS.W */, sr: 0 /* REG.A */, dr: 14 /* REG.PC */ },
        // 0xCH
        { n: 'LDBB', nm: 'LD', ms: 1 /* OPM.IMM */, md: 12 /* OPM.IMPL_R */, w: 0 /* TXS.B */, dr: 3 /* REG.BL */ },
        { n: 'LDBB', nm: 'LD', ms: 2 /* OPM.DIR */, md: 12 /* OPM.IMPL_R */, w: 0 /* TXS.B */, dr: 3 /* REG.BL */ },
        { n: 'LDBB', nm: 'LD', ms: 3 /* OPM.IND */, md: 12 /* OPM.IMPL_R */, w: 0 /* TXS.B */, dr: 3 /* REG.BL */ },
        { n: 'LDBB', nm: 'LD', ms: 4 /* OPM.PCO */, md: 12 /* OPM.IMPL_R */, w: 0 /* TXS.B */, dr: 3 /* REG.BL */ },
        { n: 'LDBB', nm: 'LD', ms: 5 /* OPM.IPO */, md: 12 /* OPM.IMPL_R */, w: 0 /* TXS.B */, dr: 3 /* REG.BL */ },
        { n: 'LDBB', nm: 'LD', ms: 6 /* OPM.MOD */, md: 12 /* OPM.IMPL_R */, w: 0 /* TXS.B */, dr: 3 /* REG.BL */ },
        { n: 'DCK', nm: 'DIS.CK', md: 0 /* OPM.IMPL */ },
        { n: '!illC7', md: 0 /* OPM.IMPL */ },
        { n: 'LBAB', nm: 'LD', ms: 13 /* OPM.IMPL_R_DIR */, md: 12 /* OPM.IMPL_R */, w: 0 /* TXS.B */, sr: 0 /* REG.A */, dr: 3 /* REG.BL */ },
        { n: 'LBBB', nm: 'LD', ms: 13 /* OPM.IMPL_R_DIR */, md: 12 /* OPM.IMPL_R */, w: 0 /* TXS.B */, sr: 2 /* REG.B */, dr: 3 /* REG.BL */ },
        { n: 'LBXB', nm: 'LD', ms: 13 /* OPM.IMPL_R_DIR */, md: 12 /* OPM.IMPL_R */, w: 0 /* TXS.B */, sr: 4 /* REG.X */, dr: 3 /* REG.BL */ },
        { n: 'LBYB', nm: 'LD', ms: 13 /* OPM.IMPL_R_DIR */, md: 12 /* OPM.IMPL_R */, w: 0 /* TXS.B */, sr: 6 /* REG.Y */, dr: 3 /* REG.BL */ },
        { n: 'LBZB', nm: 'LD', ms: 13 /* OPM.IMPL_R_DIR */, md: 12 /* OPM.IMPL_R */, w: 0 /* TXS.B */, sr: 8 /* REG.Z */, dr: 3 /* REG.BL */ },
        { n: 'LBSB', nm: 'LD', ms: 13 /* OPM.IMPL_R_DIR */, md: 12 /* OPM.IMPL_R */, w: 0 /* TXS.B */, sr: 10 /* REG.S */, dr: 3 /* REG.BL */ },
        { n: 'LBCB', nm: 'LD', ms: 13 /* OPM.IMPL_R_DIR */, md: 12 /* OPM.IMPL_R */, w: 0 /* TXS.B */, sr: 12 /* REG.C */, dr: 3 /* REG.BL */ },
        { n: 'LBPB', nm: 'LD', ms: 13 /* OPM.IMPL_R_DIR */, md: 12 /* OPM.IMPL_R */, w: 0 /* TXS.B */, sr: 14 /* REG.PC */, dr: 3 /* REG.BL */ },
        // 0xDH
        { n: 'LDB', nm: 'LD', ms: 1 /* OPM.IMM */, md: 12 /* OPM.IMPL_R */, w: 1 /* TXS.W */, dr: 2 /* REG.B */ },
        { n: 'LDB', nm: 'LD', ms: 2 /* OPM.DIR */, md: 12 /* OPM.IMPL_R */, w: 1 /* TXS.W */, dr: 2 /* REG.B */ },
        { n: 'LDB', nm: 'LD', ms: 3 /* OPM.IND */, md: 12 /* OPM.IMPL_R */, w: 1 /* TXS.W */, dr: 2 /* REG.B */ },
        { n: 'LDB', nm: 'LD', ms: 4 /* OPM.PCO */, md: 12 /* OPM.IMPL_R */, w: 1 /* TXS.W */, dr: 2 /* REG.B */ },
        { n: 'LDB', nm: 'LD', ms: 5 /* OPM.IPO */, md: 12 /* OPM.IMPL_R */, w: 1 /* TXS.W */, dr: 2 /* REG.B */ },
        { n: 'LDB', nm: 'LD', ms: 6 /* OPM.MOD */, md: 12 /* OPM.IMPL_R */, w: 1 /* TXS.W */, dr: 2 /* REG.B */ },
        { n: 'STR', nm: 'STR', w: 1 /* TXS.W */, md: 9 /* OPM.RRSR */ },
        { n: 'SAR', nm: 'SAR', ms: 12 /* OPM.IMPL_R */, sr: 0 /* REG.A */, w: 1 /* TXS.W */, md: 0 /* OPM.IMPL */, x: 6 /* OPL_EXT.RII */ },
        { n: 'LBA', nm: 'LD', ms: 13 /* OPM.IMPL_R_DIR */, md: 12 /* OPM.IMPL_R */, w: 1 /* TXS.W */, sr: 0 /* REG.A */, dr: 2 /* REG.B */ },
        { n: 'LBB', nm: 'LD', ms: 13 /* OPM.IMPL_R_DIR */, md: 12 /* OPM.IMPL_R */, w: 1 /* TXS.W */, sr: 2 /* REG.B */, dr: 2 /* REG.B */ },
        { n: 'LBX', nm: 'LD', ms: 13 /* OPM.IMPL_R_DIR */, md: 12 /* OPM.IMPL_R */, w: 1 /* TXS.W */, sr: 4 /* REG.X */, dr: 2 /* REG.B */ },
        { n: 'LBY', nm: 'LD', ms: 13 /* OPM.IMPL_R_DIR */, md: 12 /* OPM.IMPL_R */, w: 1 /* TXS.W */, sr: 6 /* REG.Y */, dr: 2 /* REG.B */ },
        { n: 'LBZ', nm: 'LD', ms: 13 /* OPM.IMPL_R_DIR */, md: 12 /* OPM.IMPL_R */, w: 1 /* TXS.W */, sr: 8 /* REG.Z */, dr: 2 /* REG.B */ },
        { n: 'LBS', nm: 'LD', ms: 13 /* OPM.IMPL_R_DIR */, md: 12 /* OPM.IMPL_R */, w: 1 /* TXS.W */, sr: 10 /* REG.S */, dr: 2 /* REG.B */ },
        { n: 'LBC', nm: 'LD', ms: 13 /* OPM.IMPL_R_DIR */, md: 12 /* OPM.IMPL_R */, w: 1 /* TXS.W */, sr: 12 /* REG.C */, dr: 2 /* REG.B */ },
        { n: 'LBP', nm: 'LD', ms: 13 /* OPM.IMPL_R_DIR */, md: 12 /* OPM.IMPL_R */, w: 1 /* TXS.W */, sr: 14 /* REG.PC */, dr: 2 /* REG.B */ },
        // 0xEH
        { n: 'STBB', nm: 'ST', ms: 12 /* OPM.IMPL_R */, md: 1 /* OPM.IMM */, w: 0 /* TXS.B */, sr: 3 /* REG.BL */ },
        { n: 'STBB', nm: 'ST', ms: 12 /* OPM.IMPL_R */, md: 2 /* OPM.DIR */, w: 0 /* TXS.B */, sr: 3 /* REG.BL */ },
        { n: 'STBB', nm: 'ST', ms: 12 /* OPM.IMPL_R */, md: 3 /* OPM.IND */, w: 0 /* TXS.B */, sr: 3 /* REG.BL */ },
        { n: 'STBB', nm: 'ST', ms: 12 /* OPM.IMPL_R */, md: 4 /* OPM.PCO */, w: 0 /* TXS.B */, sr: 3 /* REG.BL */ },
        { n: 'STBB', nm: 'ST', ms: 12 /* OPM.IMPL_R */, md: 5 /* OPM.IPO */, w: 0 /* TXS.B */, sr: 3 /* REG.BL */ },
        { n: 'STBB', nm: 'ST', ms: 12 /* OPM.IMPL_R */, md: 6 /* OPM.MOD */, w: 0 /* TXS.B */, sr: 3 /* REG.BL */ },
        { n: 'LAR', nm: 'LAR', w: 1 /* TXS.W */, md: 12 /* OPM.IMPL_R */, dr: 0 /* REG.A */, ms: 0 /* OPM.IMPL */, x: 6 /* OPL_EXT.RII */ },
        { n: '!illE7', md: 0 /* OPM.IMPL */ },
        { n: 'SBAB', nm: 'ST', ms: 12 /* OPM.IMPL_R */, md: 13 /* OPM.IMPL_R_DIR */, w: 0 /* TXS.B */, sr: 3 /* REG.BL */, dr: 0 /* REG.A */ },
        { n: 'SBBB', nm: 'ST', ms: 12 /* OPM.IMPL_R */, md: 13 /* OPM.IMPL_R_DIR */, w: 0 /* TXS.B */, sr: 3 /* REG.BL */, dr: 2 /* REG.B */ },
        { n: 'SBXB', nm: 'ST', ms: 12 /* OPM.IMPL_R */, md: 13 /* OPM.IMPL_R_DIR */, w: 0 /* TXS.B */, sr: 3 /* REG.BL */, dr: 4 /* REG.X */ },
        { n: 'SBYB', nm: 'ST', ms: 12 /* OPM.IMPL_R */, md: 13 /* OPM.IMPL_R_DIR */, w: 0 /* TXS.B */, sr: 3 /* REG.BL */, dr: 6 /* REG.Y */ },
        { n: 'SBZB', nm: 'ST', ms: 12 /* OPM.IMPL_R */, md: 13 /* OPM.IMPL_R_DIR */, w: 0 /* TXS.B */, sr: 3 /* REG.BL */, dr: 8 /* REG.Z */ },
        { n: 'SBSB', nm: 'ST', ms: 12 /* OPM.IMPL_R */, md: 13 /* OPM.IMPL_R_DIR */, w: 0 /* TXS.B */, sr: 3 /* REG.BL */, dr: 10 /* REG.S */ },
        { n: 'SBCB', nm: 'ST', ms: 12 /* OPM.IMPL_R */, md: 13 /* OPM.IMPL_R_DIR */, w: 0 /* TXS.B */, sr: 3 /* REG.BL */, dr: 12 /* REG.C */ },
        { n: 'SBPB', nm: 'ST', ms: 12 /* OPM.IMPL_R */, md: 13 /* OPM.IMPL_R_DIR */, w: 0 /* TXS.B */, sr: 3 /* REG.BL */, dr: 14 /* REG.PC */ },
        // 0xFH
        { n: 'STB', nm: 'ST', ms: 12 /* OPM.IMPL_R */, md: 1 /* OPM.IMM */, w: 1 /* TXS.W */, sr: 2 /* REG.B */ },
        { n: 'STB', nm: 'ST', ms: 12 /* OPM.IMPL_R */, md: 2 /* OPM.DIR */, w: 1 /* TXS.W */, sr: 2 /* REG.B */ },
        { n: 'STB', nm: 'ST', ms: 12 /* OPM.IMPL_R */, md: 3 /* OPM.IND */, w: 1 /* TXS.W */, sr: 2 /* REG.B */ },
        { n: 'STB', nm: 'ST', ms: 12 /* OPM.IMPL_R */, md: 4 /* OPM.PCO */, w: 1 /* TXS.W */, sr: 2 /* REG.B */ },
        { n: 'STB', nm: 'ST', ms: 12 /* OPM.IMPL_R */, md: 5 /* OPM.IPO */, w: 1 /* TXS.W */, sr: 2 /* REG.B */ },
        { n: 'STB', nm: 'ST', ms: 12 /* OPM.IMPL_R */, md: 6 /* OPM.MOD */, w: 1 /* TXS.W */, sr: 2 /* REG.B */ },
        { n: 'LIO', md: 0 /* OPM.IMPL */, x: 7 /* OPL_EXT.XIO */ },
        { n: 'MVL', nm: 'MOVLGA', ms: 13 /* OPM.IMPL_R_DIR */, md: 13 /* OPM.IMPL_R_DIR */, w: 1 /* TXS.W */, sr: 2 /* REG.B */, dr: 6 /* REG.Y */ },
        { n: 'SBA', nm: 'ST', ms: 12 /* OPM.IMPL_R */, md: 13 /* OPM.IMPL_R_DIR */, w: 1 /* TXS.W */, sr: 2 /* REG.B */, dr: 0 /* REG.A */ },
        { n: 'SBB', nm: 'ST', ms: 12 /* OPM.IMPL_R */, md: 13 /* OPM.IMPL_R_DIR */, w: 1 /* TXS.W */, sr: 2 /* REG.B */, dr: 2 /* REG.B */ },
        { n: 'SBX', nm: 'ST', ms: 12 /* OPM.IMPL_R */, md: 13 /* OPM.IMPL_R_DIR */, w: 1 /* TXS.W */, sr: 2 /* REG.B */, dr: 4 /* REG.X */ },
        { n: 'SBY', nm: 'ST', ms: 12 /* OPM.IMPL_R */, md: 13 /* OPM.IMPL_R_DIR */, w: 1 /* TXS.W */, sr: 2 /* REG.B */, dr: 6 /* REG.Y */ },
        { n: 'SBZ', nm: 'ST', ms: 12 /* OPM.IMPL_R */, md: 13 /* OPM.IMPL_R_DIR */, w: 1 /* TXS.W */, sr: 2 /* REG.B */, dr: 8 /* REG.Z */ },
        { n: 'SBS', nm: 'ST', ms: 12 /* OPM.IMPL_R */, md: 13 /* OPM.IMPL_R_DIR */, w: 1 /* TXS.W */, sr: 2 /* REG.B */, dr: 10 /* REG.S */ },
        { n: 'SBC', nm: 'ST', ms: 12 /* OPM.IMPL_R */, md: 13 /* OPM.IMPL_R_DIR */, w: 1 /* TXS.W */, sr: 2 /* REG.B */, dr: 12 /* REG.C */ },
        { n: 'SBP', nm: 'ST', ms: 12 /* OPM.IMPL_R */, md: 13 /* OPM.IMPL_R_DIR */, w: 1 /* TXS.W */, sr: 2 /* REG.B */, dr: 14 /* REG.PC */ },
    ];
    const annotation_data = new Map();
    function annotation_import(src) {
        const lines = src.replace("\r", "").split(/\n/);
        const scan = {
            ws: /^[ \t\r\n]+/,
            num: /^0x[0-9a-fA-F]+/,
            punct: /^[,:]+/,
            comm: /^;.*$/,
            word: /^[A-Za-z_$@][A-Za-z0-9_$@]*/,
            ign: /^[>][A-Za-z0-9_$@]*/,
        };
        const defer = new Set([
            'comment', 'pre', 'plate', 'plate_comment', 'pre_comment',
            'label', 'code'
        ]);
        annotation_data.clear();
        let anno_lines = [];
        let prev_line = null;
        for (let line of lines) {
            let parse = { address: -1 };
            let offset = 0;
            let cmd_state = null;
            while (offset < line.length) {
                let fragment = line.substring(offset);
                let res;
                let test = function (v) {
                    let ires = v.exec(fragment);
                    if (ires != null && ires.length > 0 && ires[0].length > 0) {
                        offset += ires[0].length;
                        return ires;
                    }
                    else {
                        return null;
                    }
                };
                if (test(scan.ws)) {
                }
                else if (test(scan.punct)) {
                }
                else if (res = test(scan.num)) {
                    parse.address = parseInt(res[0]);
                }
                else if (res = test(scan.comm)) {
                    if (cmd_state != null && (cmd_state == 'pre_comment' ||
                        cmd_state == 'pre' ||
                        cmd_state == 'plate' ||
                        cmd_state == 'plate_comment' ||
                        cmd_state == 'pre_comment')) {
                        if (parse.address == -1 && prev_line != null) {
                            if (prev_line.pre == undefined) {
                                prev_line.pre = [res[0]];
                            }
                            else {
                                prev_line.pre.push(res[0]);
                            }
                        }
                        else {
                            parse.pre = [res[0]];
                        }
                    }
                    else {
                        if (parse.address == -1 && prev_line != null) {
                            if (prev_line.comm == undefined) {
                                prev_line.comm = [res[0]];
                            }
                            else {
                                prev_line.comm.push(res[0]);
                            }
                        }
                        else {
                            parse.comm = [res[0]];
                        }
                    }
                }
                else if (res = test(scan.word)) {
                    let cmd = res[0].toLowerCase();
                    if (cmd_state != null) {
                        if (cmd_state == 'label' || cmd_state == 'code') {
                            parse.label = [res[0]];
                        }
                        else if (cmd_state == 'comment') {
                            parse.comm = [res[0]];
                        }
                        else if (cmd_state == 'pre_comment' ||
                            cmd_state == 'pre' ||
                            cmd_state == 'plate' ||
                            cmd_state == 'plate_comment' ||
                            cmd_state == 'pre_comment') {
                            parse.pre = [res[0]];
                        }
                        else {
                        }
                        cmd_state = null;
                    }
                    else if (defer.has(cmd)) {
                        cmd_state = cmd;
                    }
                    else if (cmd == 'pstring16') {
                        parse.data = 'pstringhi ';
                    }
                    else {
                        console.warn('unhandled:', cmd);
                    }
                }
                else if (res = test(scan.ign)) {
                    if (res[0] == '>H') {
                        parse.data = 'word';
                    }
                    else if (res[0] == '>B') {
                        parse.data = 'byte';
                    }
                }
                else {
                    console.warn('input invalid');
                }
            }
            if (parse.address != -1) {
                anno_lines.push(parse);
                prev_line = parse;
                let last = annotation_data.get(parse.address);
                if (last == undefined) {
                    annotation_data.set(parse.address, parse);
                }
                else {
                    if (parse.pre != null) {
                        if (last.pre != null)
                            last.pre.push(...parse.pre);
                        else
                            last.pre = parse.pre;
                    }
                    if (parse.comm != null) {
                        if (last.comm != null)
                            last.comm.push(...parse.comm);
                        else
                            last.comm = parse.comm;
                    }
                    if (parse.label != null) {
                        if (last.label != null)
                            last.label.push(...parse.label);
                        else
                            last.label = parse.label;
                    }
                    if (parse.data != null) {
                        if (last.data != null)
                            console.error('redefinition of data');
                        else
                            last.data = parse.data;
                    }
                }
            }
        }
    }
    class CPU6 {
        constructor(m, page) {
            this._map = 0;
            this.mem = m;
            this.page_ram = page;
        }
        set map(v) {
            this._map = (v << 5);
        }
        fetch(address) {
            return this.mem.readmeta(address) & 255;
        }
        phys(address) {
            let page = this.page_ram[this._map | (address >> 11)] & 0x7f;
            return (page << 11) | (address & 2047);
        }
        disassembly(address, ret) {
            const DREF_L = name_conv == 1 /* NAMECON.MEI */ ? '[' : '(';
            const DREF_R = name_conv == 1 /* NAMECON.MEI */ ? ']' : ')';
            const DDREF_L = name_conv == 1 /* NAMECON.MEI */ ? '[[' : '((';
            const DDREF_R = name_conv == 1 /* NAMECON.MEI */ ? ']]' : '))';
            let vpc = address;
            let page = address >> 11;
            let ppc = this.phys(vpc++);
            ret.pa = ppc;
            ret.pg = page;
            let meta = this.mem.readmeta(ppc);
            if ((meta & 512 /* MEMSTAT.IO */) != 0) {
                ret.hb = '??';
                ret.asc = '';
                ret.l = 1;
                return;
            }
            let op = meta & 255;
            let is_brk = (meta & 28672 /* MEMSTAT.ALL_BRK */) != 0;
            let datah = [];
            let opcs = oplist[op];
            let anpre = '';
            let anstr = '';
            let opname = opcs.n;
            let anno_data = '';
            datah.push(op);
            function check_anno(a) {
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
            function is_hiascii(v) {
                return (v > 0x9f && v < 0xff) || (v == 0x89) || (v == 0x8a) || (v == 0x8c) || (v == 0x8d);
            }
            function ascenc(v) {
                if (v >= 0xa0 && v < 0xff) {
                    return String.fromCodePoint(v & 0x7f);
                }
                else if (v == 0x89) {
                    return "\u2192";
                }
                else if (v == 0x8a) {
                    return "\u2193";
                }
                else if (v == 0x8c) {
                    return "\u21ca";
                }
                else if (v == 0x8d) {
                    return "\u21b5";
                }
                else {
                    return "_";
                }
            }
            function addrrefw(a) {
                a &= 0xffff;
                if (mmwlist.has(a)) {
                    return `${hexlist(a, 4)} <${mmwlist.get(a)}>`;
                }
                else {
                    let anno = annotation_data.get(a);
                    if (anno && anno.label && anno.label.length > 0) {
                        return `${hexlist(a, 4)} <${anno.label[0]}>`;
                    }
                    return hexlist(a, 4);
                }
            }
            function addrref(a) {
                a &= 0xffff;
                if (mmiolist.has(a)) {
                    return `${hexlist(a, 4)} <${mmiolist.get(a)}>`;
                }
                else {
                    let anno = annotation_data.get(a);
                    if (anno && anno.label && anno.label.length > 0) {
                        return `${hexlist(a, 4)} <${anno.label[0]}>`;
                    }
                    return hexlist(a, 4);
                }
            }
            let astr = ascenc(op);
            let dfetch = () => {
                let ppc = this.phys(vpc++);
                check_anno(ppc);
                let emeta = this.mem.readmeta(ppc);
                if ((meta & 28672 /* MEMSTAT.ALL_BRK */) != 0)
                    is_brk = true;
                let rv = emeta & 255;
                datah.push(rv);
                astr += ascenc(rv);
                return rv;
            };
            let psstr = '';
            let pstr = '';
            check_anno(address);
            if (anno_data == 'byte') {
                for (let i = 0; i < datah.length; i++) {
                    //@ts-ignore
                    datah[i] = hex(datah[i]);
                }
                ret.hb = datah.join(' ');
                ret.asc = astr;
                ret.ins = '.byte';
                ret.par = hexlist(op, 2);
                ret.l = vpc - address;
                if (anpre.length > 0)
                    ret.pre = anpre;
                if (anstr.length > 0)
                    ret.post = anstr;
                return;
            }
            else if (anno_data == 'word') {
                let vl = dfetch();
                for (let i = 0; i < datah.length; i++) {
                    //@ts-ignore
                    datah[i] = hex(datah[i]);
                }
                ret.hb = datah.join(' ');
                ret.asc = astr;
                ret.ins = '.word';
                ret.par = hexlist((op << 8) | vl, 4);
                ret.l = vpc - address;
                if (anpre.length > 0)
                    ret.pre = anpre;
                if (anstr.length > 0)
                    ret.post = anstr;
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
                while (is_hiascii(f)) {
                    slen = (vpcs - vstart);
                    if (slen > 160)
                        break;
                    if (f == 0x89) {
                        vstr += '\\t';
                    }
                    else if (f == 0x8a) {
                        vstr += '\\n';
                    }
                    else if (f == 0x8d) {
                        vstr += '\\r';
                    }
                    else {
                        vstr += ascenc(f);
                        if (f != 0xa0)
                            nonspace = true;
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
            }
            else if (is_hiascii(op)) {
                let vpcs = vpc - 1;
                let pre = (this.fetch(this.phys(vpc - 3)) << 8) | this.fetch(this.phys(vpc - 2));
                let f = this.fetch(this.phys(vpcs++));
                let slen = 0;
                vstr = '';
                let nonspace = false;
                while (is_hiascii(f)) {
                    if ((vpcs - vpc) > 160)
                        break;
                    if (f == 0x89) {
                        vstr += '\\t';
                    }
                    else if (f == 0x8a) {
                        vstr += '\\n';
                    }
                    else if (f == 0x8d) {
                        vstr += '\\r';
                    }
                    else {
                        vstr += ascenc(f);
                        if (f != 0xa0)
                            nonspace = true;
                    }
                    slen = (vpcs - vpc);
                    if (pre == slen && slen >= 2 && nonspace) {
                        // pascal string
                        ret.hb = '';
                        ret.asc = '';
                        ret.ic = "pstr";
                        ret.ins = '.pstringhi ';
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
                    ret.ic = "pstr";
                    ret.ins = '.pstringhi ';
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
                else if (f == 0 && slen > 3 && nonspace) {
                    // zstring/cstring
                    ret.hb = '';
                    ret.asc = '';
                    ret.ic = "zstr";
                    ret.ins = '.zstringhi ';
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
                if (!nonspace) {
                    vstr = '';
                }
            }
            let r = 1;
            if (opcs.l !== undefined) {
                while (r < opcs.l) {
                    dfetch();
                    r++;
                }
            }
            let rsh = 0;
            if (opcs.w == 1 /* TXS.W */) {
                rsh = 16;
            }
            function decode_mode(mode, is_write, regm) {
                let disp;
                let rvc;
                let advh, advl, adr;
                switch (mode) {
                    case 0 /* OPM.IMPL */: return '';
                    case 1 /* OPM.IMM */:
                        if (opcs.w == 0 /* TXS.B */) {
                            return (is_write ? '>#' : '#') + hexlist(dfetch());
                        }
                        if (opcs.w == 1 /* TXS.W */) {
                            let hi = dfetch();
                            let lo = dfetch();
                            return (is_write ? '>#' : '#') + hexlist((hi << 8) | lo, 4);
                        }
                        return (is_write ? '>#' : '#') + '<invalid>';
                    case 2 /* OPM.DIR */:
                        advh = dfetch();
                        advl = dfetch();
                        adr = (advh << 8) | advl;
                        switch (opcs.w) {
                            case 2 /* TXS.F */: return `:${addrref(adr)}`;
                            case 0 /* TXS.B */: return `${DREF_L}${addrref(adr)}${DREF_R}`;
                            case 1 /* TXS.W */: return `${DREF_L}${addrrefw(adr)}${DREF_R}`;
                        }
                        return '#<invalid>';
                    case 3 /* OPM.IND */:
                        advh = dfetch();
                        advl = dfetch();
                        adr = (advh << 8) | advl;
                        if (opcs.w == 2 /* TXS.F */) {
                            return ':' + DREF_L + addrref(adr) + DREF_R;
                        }
                        return DDREF_L + addrref(adr) + DDREF_R;
                    case 4 /* OPM.PCO */:
                        disp = sbyte(dfetch());
                        if (opcs.w == 2 /* TXS.F */) {
                            return `PC${hexlistp(disp)} \u21d2 ${addrrefw(vpc + disp)}`;
                        }
                        else if (opcs.w == 1 /* TXS.W */) {
                            return `${DREF_L} PC${hexlistp(disp)} \u21d2 ${addrrefw(vpc + disp)} ${DREF_R}`;
                        }
                        return `${DREF_L} PC${hexlistp(disp)} \u21d2 ${addrref(vpc + disp)} ${DREF_R}`;
                    case 5 /* OPM.IPO */:
                        disp = sbyte(dfetch());
                        if (opcs.w == 2 /* TXS.F */) {
                            return `${DREF_L} PC${hexlistp(disp)} \u21d2 ${addrrefw(vpc + disp)} ${DREF_R}`;
                        }
                        else if (opcs.w == 1 /* TXS.W */) {
                            return `${DDREF_L} PC${hexlistp(disp)} \u21d2 ${addrrefw(vpc + disp)} ${DDREF_R}`;
                        }
                        return `${DDREF_L} PC${hexlistp(disp)} \u21d2 ${addrref(vpc + disp)} ${DDREF_R}`;
                    case 6 /* OPM.MOD */: {
                        rvc = dfetch();
                        let modv = rvc & 15;
                        let reg = rvc >> 4;
                        disp = 0;
                        let res = regname[16 + reg];
                        if ((reg & 1) != 0) {
                            return '<invalid>' + res;
                        }
                        if ((modv & 8) > 0) {
                            disp = sbyte(dfetch());
                        }
                        if ((modv & 3) == 2) {
                            res = '--' + res;
                        }
                        else if ((modv & 3) == 1) {
                            res = res + '++';
                        }
                        if ((modv & 8) > 0) {
                            res = `${res} ${disp < 0 ? '-' : '+'} ${hexlist(disp < 0 ? -disp : disp)}`;
                        }
                        res = `${DREF_L}${res}${DREF_R}`;
                        if ((modv & 4) > 0) {
                            res = `${DREF_L}${res}${DREF_R}`;
                        }
                        return res;
                    }
                    case 7 /* OPM.RR */:
                    case 8 /* OPM.RRX */:
                    case 10 /* OPM.RRS */:
                    case 9 /* OPM.RRSR */: {
                        if (!is_write)
                            throw new Error('RR* in source operand, should be in dest');
                        rvc = dfetch();
                        let regsrc = (rvc >> 4);
                        let regdst = (rvc & 15);
                        const rrmode = ((regsrc & 1) << 1) | (regdst & 1);
                        let strdst;
                        if (opcs.w == 1 /* TXS.W */) {
                            regsrc = regsrc & 14;
                            regdst = regdst & 14;
                            if (mode == 8 /* OPM.RRX */ && (regdst != (regdst | 2)))
                                strdst = `${regname[16 + regdst]}:${regname[16 + (regdst | 2)]}`;
                            else
                                strdst = regname[16 + regdst];
                        }
                        else {
                            strdst = regname[regdst];
                        }
                        if (opcs.w == 1 /* TXS.W */ && rrmode > 0) {
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
                            if (mode == 9 /* OPM.RRSR */) {
                                if (rrmode == 2) {
                                    // MSN odd
                                    return `${strdst}, >#${hexlist(adr, 4)}`;
                                }
                                else if (rrmode == 1) {
                                    // MSN even
                                    return `${strdst}, ${DREF_L}${addrrefw(sword(adr))}${DREF_R}`;
                                }
                                else {
                                    return `${strdst}, ${DREF_L}${regname[16 + regsrc]}${hexlistp(sword(adr))}${DREF_R}`;
                                }
                            }
                            else if (mode == 10 /* OPM.RRS */) {
                                if (rrmode == 2) {
                                    // MSN odd
                                    return `#${hexlist(adr, 4)}, ${strdst}`;
                                }
                                else if (rrmode == 1) {
                                    // MSN even
                                    return `${DREF_L}${addrrefw(sword(adr))}${DREF_R}, ${strdst}`;
                                }
                                else {
                                    return `${DREF_L}${regname[16 + regsrc]}${hexlistp(sword(adr))}${DREF_R}, ${strdst}`;
                                }
                            }
                            else if (rrmode == 2) {
                                // MSN odd
                                return `#${hexlist(adr, 4)}, ${regname[16 + regsrc]} \u21d2 ${strdst}`;
                            }
                            else if (rrmode == 1) {
                                // MSN even
                                return `${DREF_L}${addrrefw(sword(adr))}${DREF_R}, ${regname[16 + regsrc]} \u21d2 ${strdst}`;
                            }
                            else {
                                return `${DREF_L}${regname[16 + regsrc]} + ${hexlistp(sword(adr))}${DREF_R}, ${regname[16 + regdst]} \u21d2 ${strdst}`;
                            }
                        }
                        else {
                            return `${regname[rsh + regsrc]}, ${regname[rsh + regdst]}`;
                        }
                        break;
                    }
                    case 11 /* OPM.RC */: {
                        if (!is_write)
                            throw new Error('RC in source operand, should be in dest');
                        rvc = dfetch();
                        let regdst = rvc >> 4;
                        let regsrc = rvc & 15;
                        if (opcs.i !== undefined) {
                            regsrc += opcs.i;
                        }
                        if (opcs.w == 1 /* TXS.W */ && (regdst & 1) != 0) {
                            advh = dfetch();
                            advl = dfetch();
                            adr = sword((advh << 8) | advl);
                            regdst = regdst & 14;
                            if (regdst == 0) {
                                return `${DREF_L}${addrref(adr)}${DREF_R}, ${hexlist(regsrc, 1)}`;
                            }
                            return `${DREF_L}${addrref(adr)} + ${regname[16 + regdst]}${DREF_R}, ${hexlist(regsrc, 1)}`;
                        }
                        else {
                            return regname[rsh + regdst] + ',' + hexlist(regsrc, 1);
                        }
                    }
                    case 12 /* OPM.IMPL_R */:
                        if (name_conv != 1 /* NAMECON.MEI */) {
                            return '';
                        }
                        if (regm != undefined) {
                            return regname[rsh + regm];
                        }
                        else {
                            return '!R';
                        }
                    case 13 /* OPM.IMPL_R_DIR */:
                        if (name_conv != 1 /* NAMECON.MEI */) {
                            return '';
                        }
                        if (regm != undefined) {
                            return `${DREF_L}${regname[16 + regm]}${DREF_R}`;
                        }
                        else {
                            return `${DREF_L}!R${DREF_R}`;
                        }
                }
            }
            let exm_data = 0;
            let exm_reg = false;
            function decode_exmode(mode, is_dest) {
                let v0;
                if (mode == 2 && exm_reg)
                    v0 = exm_data;
                else
                    v0 = dfetch();
                let regh = v0 >> 4;
                let regl = v0 & 15;
                switch (mode) {
                    case 0:
                        let al = dfetch();
                        return `${DREF_L}${hexlist((v0 << 8) | al, 4)}${DREF_R}`;
                    case 1:
                        let litv = dfetch();
                        if ((regl & 1) != 0) {
                            throw 0;
                        }
                        if ((regh & 1) != 0) {
                            litv = sword((litv << 8) | dfetch());
                            regh &= 14;
                        }
                        else {
                            litv = sbyte(litv);
                        }
                        return `${DREF_L}${regname[16 + regh]}${(regl != 0) ? ' + ' + regname[16 + regl] : ''}${hexlistp(litv)}${DREF_R}`;
                    case 2:
                        if (is_dest)
                            return `${DREF_L}${regname[16 + regl]}${DREF_R}`;
                        else {
                            exm_data = v0;
                            exm_reg = true;
                            return `${DREF_L}${regname[16 + regh]}${DREF_R}`;
                        }
                    case 3:
                        return `#${hexlist(v0, 2)}`;
                }
                throw 0;
            }
            if (opcs.ms != null) {
                pstr = decode_mode(opcs.ms, false, opcs.sr);
                psstr = decode_mode(opcs.md, true, opcs.dr);
            }
            else {
                pstr = decode_mode(opcs.md, true, opcs.dr);
            }
            extenc: switch (opcs.x) {
                case undefined:
                    break;
                case 0 /* OPL_EXT.MPUSH */:
                case 1 /* OPL_EXT.MPOP */: {
                    let rvc = dfetch();
                    if (opcs.x == 1 /* OPL_EXT.MPOP */) {
                        opname = 'MPOP';
                    }
                    else {
                        opname = 'MPUSH';
                    }
                    let rstart = (rvc >> 4);
                    let rcount = (rvc & 15);
                    pstr = regname[rstart++];
                    while (rcount > 0) {
                        pstr += ',' + regname[rstart++];
                        rcount--;
                    }
                    break;
                }
                case 2 /* OPL_EXT.PAGE */: {
                    let rvc = dfetch();
                    let mod1 = (rvc >> 2) & 3;
                    let mod2 = rvc & 3;
                    let sel = (rvc >> 4);
                    const opr1 = opcs.xd[0][sel];
                    const ncon = opcs.xd[name_conv == 1 /* NAMECON.MEI */ ? 1 : 2];
                    if (sel < ncon.length) {
                        opname += '.' + ncon[sel];
                    }
                    else {
                        opname += '.' + hex(sel, 1);
                    }
                    if (opr1 == undefined) {
                        pstr = '#<invalid>';
                    }
                    else
                        try {
                            if (mod1 == 3) {
                                let v = dfetch();
                                pstr = `m=#${hexlist(v & 7, 1)},${opr1}=#${hexlist(v >> 3, 2)}`;
                            }
                            else {
                                pstr = `(m,${opr1})=${decode_exmode(mod1, false)}`;
                            }
                            if (mod2 == 3) {
                                pstr = '#<invalid>';
                            }
                            else {
                                psstr = decode_exmode(mod2, true);
                            }
                        }
                        catch (e) {
                            pstr = '#<invalid>';
                        }
                    break;
                }
                case 3 /* OPL_EXT.DMA */: {
                    let rvc = dfetch();
                    let reg = (rvc >> 4);
                    let sel = (rvc & 15);
                    const ncon = opcs.xd[name_conv == 1 /* NAMECON.MEI */ ? 2 : 1];
                    if (sel < ncon.length) {
                        if (name_conv == 1 /* NAMECON.MEI */)
                            opname += '.' + ncon[sel];
                        else
                            opname = ncon[sel];
                    }
                    else {
                        opname += hex(sel, 1);
                    }
                    switch (sel) {
                        case 0:
                            pstr = regname[16 + reg];
                            break;
                        case 1:
                            psstr = regname[16 + reg];
                            break;
                        case 2:
                            pstr = regname[16 + reg];
                            break;
                        case 3:
                            psstr = regname[16 + reg];
                            break;
                        case 4:
                            psstr = `#${hexlist(reg, 1)}`;
                            break;
                        case 5:
                            psstr = regname[reg | 1];
                            break;
                        case 6: break;
                        case 7: break;
                        case 8:
                            psstr = regname[reg | 1];
                            break;
                        case 9:
                            pstr = regname[reg | 1];
                            break;
                    }
                    break;
                }
                case 4 /* OPL_EXT.BIG */: {
                    let osb = dfetch();
                    let rvc = dfetch();
                    const oss = (osb >> 4) + 1;
                    const osd = (osb & 15) + 1;
                    const mod1 = (rvc >> 2) & 3;
                    const mod2 = rvc & 3;
                    const sel = (rvc >> 4);
                    const ncon = opcs.xd[name_conv == 1 /* NAMECON.MEI */ ? 0 : 1];
                    if (sel < ncon.length) {
                        if (name_conv == 1 /* NAMECON.MEI */)
                            opname += '.' + ncon[sel];
                        else
                            opname = ncon[sel];
                    }
                    else {
                        opname += '.' + hex(sel, 1);
                        pstr = '#<invalid>';
                        break;
                    }
                    try {
                        pstr = `${hexlist(oss, 1)}/${decode_exmode(mod1, false)}`;
                        if (mod2 == 3) {
                            pstr = '#<invalid>';
                        }
                        else {
                            psstr = `${hexlist(osd, 1)}/${decode_exmode(mod2, true)}`;
                        }
                    }
                    catch (e) {
                        pstr = '#<invalid>';
                    }
                    break;
                }
                case 5 /* OPL_EXT.MEM */: {
                    const rvc = dfetch();
                    const mod1 = (rvc >> 2) & 3;
                    const mod2 = rvc & 3;
                    const sel = (rvc >> 4);
                    const ncon = opcs.xd[name_conv == 1 /* NAMECON.MEI */ ? 2 : 1];
                    if (sel < ncon.length) {
                        if (name_conv == 1 /* NAMECON.MEI */)
                            opname += '.' + ncon[sel];
                        else
                            opname = ncon[sel];
                    }
                    else {
                        opname += hex(sel, 1);
                        pstr = '#<invalid>';
                        break;
                    }
                    const nci = opcs.xd[0][sel];
                    // 0: none
                    // 1: len=#FF, term=AH
                    // 2: len=AL, term=AH
                    // TODO 3: len=AL
                    // TODO 4: len=AL
                    // TODO 5: len=AL
                    // TODO 6: len=AL
                    // TODO 7: len=AL
                    // TODO 8: len=AL
                    // TODO 9: len=AL
                    if (opcs.sr !== undefined) {
                        if (name_conv == 1 /* NAMECON.MEI */) {
                            if ((nci & 2) != 0) {
                                pstr = 'l=AL, ';
                            }
                            if ((nci & 1) != 0) {
                                pstr += 't=AH, ';
                            }
                        }
                    }
                    else {
                        if ((nci & 2) != 0) {
                            const lvl = dfetch();
                            pstr = `${name_conv == 1 /* NAMECON.MEI */ ? 'l=' : ''}#${hexlist(lvl)}, `;
                        }
                        if ((nci & 1) != 0) {
                            const lvt = dfetch();
                            pstr += `${name_conv == 1 /* NAMECON.MEI */ ? 't=' : ''}#${hexlist(lvt)}, `;
                        }
                    }
                    try {
                        if (mod2 == 3 || (mod1 == 3 && (nci & 4) == 0)) {
                            pstr = '#<invalid>';
                        }
                        else {
                            pstr += decode_exmode(mod1, false);
                            psstr = decode_exmode(mod2, true);
                        }
                    }
                    catch (e) {
                        pstr = '#<invalid>';
                    }
                    break;
                }
                case 6 /* OPL_EXT.RII */: {
                    const rvc = dfetch();
                    if (opcs.ms == 0 /* OPM.IMPL */)
                        pstr = `r#${hexlist(rvc)}`;
                    else
                        psstr = `r#${hexlist(rvc)}`;
                    break;
                }
                case 7 /* OPL_EXT.XIO */: {
                    const rvc = dfetch();
                    const rvd = sbyte(dfetch());
                    const regh = (rvc >> 4);
                    const regl = rvc & 14;
                    // F6 JK D8
                    // this is a system mode instruction, traps from user mode
                    // uses low bits from J,K
                    // D8 is signed 8 bit displacement
                    // EA = (KW + D8) | 0x3F000 // always I/O area
                    // 0,0: LIO  JW = [EA] // always reads I/O area
                    // 1,0: LIOB JL = [EA] // always reads I/O area
                    // 0,1: SIO  EA = [JW] // always writes I/O area
                    // 1,1: SIOB EA = [JL] // always writes I/O area
                    pstr = `${DREF_L}${regname[16 + regl]}${hexlistp(rvd)}${DREF_R}`;
                    if ((rvc & 1) != 0) {
                        opname = name_conv == 1 /* NAMECON.MEI */ ? 'ST.IO' : 'SIO';
                        psstr = pstr;
                        pstr = regname[regh + ((rvc & 16) != 0 ? 0 : 16)];
                    }
                    else {
                        if (name_conv == 1 /* NAMECON.MEI */)
                            opname = 'LD.IO';
                        psstr = regname[regh + ((rvc & 16) != 0 ? 0 : 16)];
                    }
                    break;
                }
                default: opname += '.<unhandled>';
            }
            if (name_conv == 1 /* NAMECON.MEI */ && opcs.nm !== undefined) {
                opname = opcs.nm;
            }
            if (pstr.length > 0 && psstr.length > 0) {
                pstr += ', ';
            }
            for (let i = 0; i < datah.length; i++) {
                //@ts-ignore
                datah[i] = hex(datah[i]);
            }
            ret.hb = datah.join(datah.length > 5 ? '' : ' ');
            ret.asc = datah.length > 5 ? '' : astr;
            ret.ins = opname;
            ret.par = ` ${pstr}${psstr}`;
            ret.is_brk = is_brk;
            ret.l = vpc - address;
            if (anpre.length > 0) {
                ret.pre = anpre;
            }
            if (anstr.length > 0) {
                ret.post = anstr;
            }
            else if (vstr.length > 5) {
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
    loadbin(bpl_rom_fc, bpl_rom, { invert: true, remap: [0, 1, 2, 3, 4, 8, 5, 6, 7] });
    cx_crt0.mux = mmio_mux.muxports[0];
    mmio_mux.muxports[0].line = cx_crt0;
    if (cx_crt1) {
        cx_crt1.mux = mmio_mux.muxports[1];
        mmio_mux.muxports[1].line = cx_crt1;
    }
    if (cx_crt2) {
        cx_crt2.mux = mmio_mux.muxports[2];
        mmio_mux.muxports[2].line = cx_crt2;
    }
    const dsk2_0 = new DSK2();
    run_hw.push(dsk2_0);
    bpl.configio(0, mmio_mux);
    bpl.configio(1, dsk2_0);
    const mmio_0 = new MMIOMulti();
    const mmio_1 = new MMIOMulti();
    const mmio_7 = new MMIOMulti();
    const mmio_8 = new MMIOMulti();
    mmio_1.adddev(0, 0x20, cx_diag0);
    mmio_1.adddev(0x40, 0x10, dsk2_0);
    const mmio_t = new MMIOTrace();
    const test_tape = new MockTape9Tk();
    mmio_7.adddev(0, 16, test_tape);
    mmio_7.adddev(0x10, 240, mmio_t);
    const main_ffc = new FinchFloppyControl();
    bpl.configio(2, main_ffc);
    mmio_8.adddev(0, 2, main_ffc);
    run_hshw.push(main_ffc);
    const test_cmd = new TestCMD();
    run_hshw.push(test_cmd);
    mmio_8.adddev(0x08, 2, test_cmd);
    const prt_0 = new MockPrinter();
    mmio_0.adddev(0xe0, 0x10, prt_0);
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
    function brload(buffer, into) {
        let offset = 0;
        const dv = new DataView(buffer);
        const limit = buffer.byteLength;
        function brload_rec(depth, into) {
            let b = dv.getUint8(offset++);
            const m = b >> 5;
            const v = b & 31;
            let n = false;
            function read_enc() {
                if (v < 24)
                    return v;
                if (v == 24) {
                    if (offset + 1 > limit)
                        throw new Error();
                    let q = dv.getUint8(offset++);
                    if (q < 24)
                        throw new Error();
                    return q;
                }
                if (v == 25) {
                    if (offset + 2 > limit)
                        throw new Error();
                    let q = dv.getUint16(offset, false);
                    offset += 2;
                    if (q < 256)
                        throw new Error();
                    return q;
                }
                if (v == 26) {
                    if (offset + 4 > limit)
                        throw new Error();
                    let q = dv.getUint32(offset, false);
                    offset += 4;
                    if (q < 65536)
                        throw new Error();
                    return q;
                }
                if (v == 27)
                    throw new Error();
                throw new Error();
            }
            switch (m) {
                case 0: return read_enc();
                case 1: return -(read_enc() + 1);
                case 2: throw new Error();
                case 3: {
                    const len = read_enc();
                    let s = '';
                    for (let i = 0; i < len; i++) {
                        if (offset + 1 > limit)
                            throw new Error();
                        const c = dv.getUint8(offset++);
                        if (c < 128)
                            s += String.fromCharCode(c);
                        else if ((c & 248) == 240) { // 3
                            if (offset + 3 > limit)
                                throw new Error();
                            const c2 = dv.getUint8(offset++);
                            if ((c2 & 192) != 128)
                                throw new Error();
                            const c1 = dv.getUint8(offset++);
                            if ((c1 & 192) != 128)
                                throw new Error();
                            const c0 = dv.getUint8(offset++);
                            if ((c0 & 192) != 128)
                                throw new Error();
                            s += String.fromCharCode(((c & 31) << 18) | ((c2 & 63) << 12) | ((c1 & 63) << 6) | (c0 & 63));
                        }
                        else if ((c & 240) == 224) { // 2
                            if (offset + 2 > limit)
                                throw new Error();
                            const c1 = dv.getUint8(offset++);
                            if ((c1 & 192) != 128)
                                throw new Error();
                            const c0 = dv.getUint8(offset++);
                            if ((c0 & 192) != 128)
                                throw new Error();
                            s += String.fromCharCode(((c & 31) << 12) | ((c1 & 63) << 6) | (c0 & 63));
                        }
                        else if ((c & 224) == 192) { // 1
                            if (offset + 1 > limit)
                                throw new Error();
                            const c0 = dv.getUint8(offset++);
                            if ((c0 & 192) != 128)
                                throw new Error();
                            s += String.fromCharCode(((c & 31) << 6) | (c0 & 63));
                        }
                        else
                            throw new Error();
                    }
                    return s;
                }
                case 4: {
                    const len = read_enc();
                    if (into !== undefined) {
                        if (typeof into != 'object' || !Array.isArray(into)) {
                            throw new Error();
                        }
                    }
                    const a = (into !== undefined) ? into : [];
                    for (let i = 0; i < len; i++) {
                        a[i] = brload_rec(depth + 1, a[i]);
                    }
                    return a;
                }
                case 5: {
                    const len = read_enc();
                    if (into !== undefined) {
                        if (into == null
                            || typeof into != 'object'
                            || Array.isArray(into))
                            throw new Error();
                    }
                    const o = (into !== undefined) ? into : {};
                    for (let i = 0; i < len; i++) {
                        const k = brload_rec(depth + 1);
                        if (typeof k == 'number' || typeof k == 'string') {
                            const v = brload_rec(depth + 1, o[k]);
                            o[k] = v;
                        }
                        else
                            throw new Error();
                    }
                    return o;
                }
                case 6: {
                    const tv = read_enc();
                    const item = brload_rec(depth + 1);
                    if (typeof item == 'number') {
                        if (tv == 6) {
                            if (into !== undefined) {
                                if (typeof into == 'object' && Array.isArray(into)) {
                                    for (let i = 0; i < 8 && i < into.length; i++) {
                                        if (into[i] === false || into[i] === true) {
                                            into[i] = (item & (1 << i)) != 0;
                                        }
                                        else
                                            throw new Error();
                                    }
                                    return into;
                                }
                                throw new Error();
                            }
                            return [
                                (item & 1) != 0, (item & 2) != 0, (item & 4) != 0, (item & 8) != 0,
                                (item & 16) != 0, (item & 32) != 0, (item & 64) != 0, (item & 128) != 0,
                            ];
                        }
                    }
                    return item;
                }
                case 7: {
                    if (v == 20)
                        return false;
                    if (v == 21)
                        return true;
                    if (v == 22)
                        return null;
                    if (v == 23)
                        return undefined;
                    throw new Error();
                }
            }
            throw new Error();
        }
        return brload_rec(0, into);
    }
    const brscratch = new Uint8Array(16);
    const brscratchv = new DataView(brscratch.buffer);
    function brenc_int(value) {
        if (value < 24) {
            brscratch[0] |= value;
            return 1;
        }
        else if (value < 256) {
            brscratch[0] |= 24;
            brscratchv.setUint8(1, value);
            return 2;
        }
        else if (value < 65536) {
            brscratch[0] |= 25;
            brscratchv.setUint16(1, value, false);
            return 3;
        }
        else if (value < 4294967296) {
            brscratch[0] |= 27;
            brscratchv.setUint32(1, value, false);
            return 5;
        }
        throw new Error();
    }
    function brsave(value) {
        let ds = '';
        function brsave_rec(value) {
            if (value === false) {
                ds += String.fromCharCode(244);
                return;
            }
            else if (value === true) {
                ds += String.fromCharCode(245);
                return;
            }
            else if (value === null) {
                ds += String.fromCharCode(246);
                return;
            }
            else if (value === undefined) {
                ds += String.fromCharCode(247);
                return;
            }
            else if (typeof value == 'number') {
                if (Math.floor(value) != value)
                    throw new Error();
                brscratch[0] = 0;
                if (value < 0) {
                    brscratch[0] = 32;
                    value = -(value + 1);
                }
                let dlen = brenc_int(value);
                for (let i = 0; i < dlen; i++) {
                    ds += String.fromCharCode(brscratch[i]);
                }
                return;
            }
            else if (typeof value == 'string') {
                brscratch[0] = 96;
                let eslen = 0;
                for (let c of value) {
                    if (c.codePointAt(0) > 127)
                        throw new Error();
                    eslen++;
                }
                const dlen = brenc_int(eslen);
                for (let i = 0; i < dlen; i++) {
                    ds += String.fromCharCode(brscratch[i]);
                }
                for (let c of value) {
                    ds += c;
                }
                return;
            }
            else if (typeof value == 'object') {
                if (Array.isArray(value)) {
                    let is_b = value.length > 1;
                    let b_val = 0;
                    for (let i = 0; is_b && i < value.length; i++) {
                        if (value[i] === true) {
                            b_val |= 1 << i;
                        }
                        else if (value[i] !== false) {
                            is_b = false;
                            break;
                        }
                    }
                    if (is_b && value.length < 8) {
                        ds += String.fromCharCode(198);
                        brsave_rec(b_val);
                        return;
                    }
                    brscratch[0] = 128;
                    const dlen = brenc_int(value.length);
                    for (let i = 0; i < dlen; i++) {
                        ds += String.fromCharCode(brscratch[i]);
                    }
                    for (let i = 0; i < value.length; i++) {
                        brsave_rec(value[i]);
                    }
                }
                else {
                    brscratch[0] = 160;
                    const kv = Object.entries(value);
                    const dlen = brenc_int(kv.length);
                    for (let i = 0; i < dlen; i++) {
                        ds += String.fromCharCode(brscratch[i]);
                    }
                    for (let i = 0; i < kv.length; i++) {
                        if (/^0|(?:[1-9][0-9]*)$/.test(kv[i][0])) {
                            const kn = parseInt(kv[i][0]);
                            brsave_rec(kn);
                        }
                        else {
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
        for (let i = 0; i < ds.length; i++) {
            bv[i] = ds.charCodeAt(i);
        }
        return bv;
    }
    function to_csr(buffer) {
        const dv = new DataView(buffer);
        let s = '';
        let i = 0;
        const limit = buffer.byteLength;
        while (i < limit) {
            let v;
            if (i + 3 < limit) {
                v = dv.getUint32(i, true);
            }
            else if (i + 2 < limit) {
                v = dv.getUint8(i) | (dv.getUint8(i + 1) << 8) | (dv.getUint8(i + 2) << 16);
                v += 4328521728;
            }
            else if (i + 1 < limit) {
                v = dv.getUint8(i) | (dv.getUint8(i + 1) << 8);
                v += 4311744512;
            }
            else {
                v = dv.getUint8(i);
                v += 4294967296;
            }
            const v0 = v % 95;
            v = (v / 95) | 0;
            const v1 = v % 95;
            v = (v / 95) | 0;
            const v2 = v % 95;
            v = (v / 95) | 0;
            const v3 = v % 95;
            v = (v / 95) | 0;
            s += String.fromCharCode(32 + v) +
                String.fromCharCode(32 + v0) +
                String.fromCharCode(32 + v1) +
                String.fromCharCode(32 + v2) +
                String.fromCharCode(32 + v3);
            i += 4;
        }
        return s;
    }
    function from_csr(s) {
        const blocks = (s.length / 5) | 0;
        const buffer = new ArrayBuffer(blocks * 4);
        const dv = new DataView(buffer);
        const limit = blocks * 5;
        let i = 0;
        let o = 0;
        while (i + 4 < limit) {
            const sv = s.charCodeAt(i) - 32;
            const sv0 = s.charCodeAt(i + 1) - 32;
            const sv1 = s.charCodeAt(i + 2) - 32;
            const sv2 = s.charCodeAt(i + 3) - 32;
            const sv3 = s.charCodeAt(i + 4) - 32;
            let v = sv * 95 + sv3;
            v = v * 95 + sv2;
            v = v * 95 + sv1;
            v = v * 95 + sv0;
            if (v > 4294967295)
                v -= 4294967296;
            dv.setUint32(o, v, true);
            o += 4;
            i += 5;
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
        // TODO uicore
        // 0: string -- UI font -- N/A could be a thing though
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
        // TODO net
        // 0: bool local_button -> remote_check -- successfully connected?
        {
            // 0: bool show_dis = view_dis.checked;
            // 1: bool HEX_CONV = false -- (impl)
            // 2: number NAME_CONV 0|1|2; -- (impl)
            show_dis = CONFIG.disassm[0];
            view_dis.checked = show_dis;
            HEX_CONV = CONFIG.disassm[1];
            name_conv = CONFIG.disassm[2];
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
            // [n][0] 1: bool inp_crtsize // tall
            // [n][0] 2: bool inp_crtwide // wide
            // [n][0] 3: bool loc_crt0 // f=top/t=bottom
            for (let i = 0; i < crts.length; i++) {
                const crt = crts[i];
                const viewopts = crt[0];
                if (ui_crts[i]) {
                    ui_crts[i].view.checked = viewopts[0];
                    ui_crts[i].tall.checked = viewopts[1];
                    ui_crts[i].wide.checked = viewopts[2];
                }
                if (i == 0) {
                    if (viewopts[3]) { // f=top/t=bottom
                        loc_crt0[0].checked = false; //top
                        loc_crt0[1].checked = true; //bottom
                    }
                    else {
                        loc_crt0[1].checked = false; //bottom
                        loc_crt0[0].checked = true; //top
                    }
                }
            }
        }
        do {
            const ffcs = CONFIG.ffc;
            if (ffcs == undefined)
                break;
            // [n][0] bool installed -- N/A
            // [n][1] bool show_ffc = view_ffc.checked;
            for (let i = 0; i < ffcs.length; i++) {
                const ffc = ffcs[i];
                show_ffc = ffc[1];
                view_ffc.checked = show_ffc;
            }
        } while (false);
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
            if (opt_rtc[2].checked)
                rtcsrc = 2;
            if (opt_rtc[1].checked)
                rtcsrc = 1;
            if (opt_rtc[0].checked)
                rtcsrc = 0;
            CONFIG.cpu[2] = rtcsrc;
        }
        {
            // 0: number run_rate = RUNRATES[val];
            for (let i = 0; i < RUNRATES.length; i++) {
                if (RUNRATES[i] == run_rate) {
                    CONFIG.emu[0] = i;
                    break;
                }
            }
        }
        // TODO net
        // 0: bool local_button -> remote_check -- successfully connected?
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
            for (let i = 0; i < crts.length; i++) {
                const crt = crts[i];
                const viewopts = crt[0];
                if (ui_crts[i]) {
                    viewopts[0] = ui_crts[i].view.checked;
                    viewopts[1] = ui_crts[i].tall.checked;
                    viewopts[2] = ui_crts[i].wide.checked;
                }
                if (i == 0) {
                    viewopts[3] = loc_crt0[1].checked;
                }
            }
        }
        do {
            const ffcs = CONFIG.ffc;
            if (ffcs == undefined)
                break;
            // [n][0] bool installed -- N/A
            // [n][1] bool show_ffc = view_ffc.checked;
            for (let i = 0; i < ffcs.length; i++) {
                const ffc = ffcs[i];
                if (i == 0) {
                    ffc[1] = show_ffc;
                }
            }
        } while (false);
    }
    //@ts-ignore
    this.window.rtd = rtd;
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
        let d = brsave(CONFIG_LL);
        let csr = to_csr(d.buffer);
        try {
            localStorage.setItem('cencfg', csr);
        }
        catch (ex) {
            console.warn('unable to save config string:', [csr]);
        }
        //let hso = hexstr(d);
        //const bv = new Uint8Array(from_csr(csr));
        //let hsi = hexstr(bv);
        //console.log(hso);
        //console.log(hsi);
        //console.log(csr);
        //console.log(brload(bv.buffer, CONFIG_LL));
    }
    function config_initialize() {
        let lsv = localStorage.getItem('cencfg');
        if (lsv == null)
            return;
        try {
            const bv = new Uint8Array(from_csr(lsv));
            console.log(brload(bv.buffer, CONFIG_LL));
            config_load();
        }
        catch (ex) {
            console.warn('unable to load config:', [lsv], ex);
        }
    }
    config_initialize();
    //@ts-ignore
    if (name_conv == 0 /* NAMECON.CENT */)
        conv_ee.checked = true;
    if (name_conv == 1 /* NAMECON.MEI */)
        conv_mei.checked = true;
    //@ts-ignore
    if (name_conv == 2 /* NAMECON.WIKI */)
        conv_uew.checked = true;
    cx_crt0.show_ui = ui_crts[0].view.checked;
    frame_crt1.show = ui_crts[1].view.checked;
    frame_crt2.show = ui_crts[2].view.checked;
    let config_timeout = 0;
    function config_handle() {
        config_timeout = 0;
        rtd();
    }
    function config_updated() {
        if (config_timeout != 0) {
            clearTimeout(config_timeout);
        }
        config_timeout = setTimeout(config_handle, 10000);
    }
    setupmemory();
    update_microlist();
    mcsim.step(true);
    mcsim.showstate(true);
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
    loadhex(mem0, program_rotr, 0x100);
    //mem.loadbin(wipl_dump);
    function show_disasm() {
        let vpc;
        if (run_follow) {
            vpc = last_pc;
            cpu.map = last_map;
        }
        else {
            vpc = dis_vpc;
            cpu.map = dis_map;
        }
        const empty = '';
        const ret = {
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
                listitem.a_ref = ret.pa;
                listitem.addr.innerText = `${hex(ret.pa >> 8, 3)}:${hex(vpc, 4)}: `;
                style_if(listitem.line, 'brk', ret.is_brk);
                listitem.pre.innerText = ret.pre;
                listitem.hex.innerText = ret.hb;
                listitem.ascii.innerText = ret.asc;
                listitem.inst.innerText = ret.ins;
                listitem.param.innerText = ret.par;
                listitem.comm.innerText = ret.post;
                vpc = (vpc + ret.l) & 0xffff;
            }
            catch (e) {
                listitem.hex.innerText = '';
                listitem.inst.innerText = '';
                listitem.comm.innerText = '{{ERROR}}';
                vpc = (vpc + 1) & 0xffff;
            }
        }
        dis_ppc_end = ret.pa + ret.l;
    }
    const rex_hex5 = /^[0-9a-fA-F]{1,5}$/;
    function handle_dbg_input(cmd) {
        if (rex_hex5.test(cmd.value)) {
            dis_vpc = parseInt(cmd.value, 16) & 0xffff;
            run_follow = false;
            show_disasm();
        }
        else {
            run_follow = true;
        }
    }
    handle_dbg_input(in_dbgcmd);
    in_dbgcmd.addEventListener('input', function (ev) {
        handle_dbg_input(this);
    });
    in_dbgcmd.addEventListener('keypress', function (ev) {
        if (ev.code == 'Enter' || ev.code == 'NumpadEnter') {
            handle_dbg_input(this);
        }
    });
    in_diagins.addEventListener('change', function (ev) {
        setupmemory();
        config_updated();
    });
    // sense_switch
    function update_sense() {
        style_if(btn_ss1, 'active', (sense_switch & 1) > 0);
        style_if(btn_ss2, 'active', (sense_switch & 2) > 0);
        style_if(btn_ss3, 'active', (sense_switch & 4) > 0);
        style_if(btn_ss4, 'active', (sense_switch & 8) > 0);
        style_if(fp_rf, 'active', (sense_switch & 8) > 0);
        style_if(btn_ssR, 'active', (dswitch & 8) > 0);
        style_if(btn_ssH, 'active', (dswitch & 4) > 0);
        style_if(btn_ssI, 'active', (dswitch & 2) > 0);
    }
    function update_diagsw() {
        style_if(btn_dt1, 'active', (cx_dip & 1) != 0);
        style_if(btn_dt2, 'active', (cx_dip & 2) != 0);
        style_if(btn_dt4, 'active', (cx_dip & 4) != 0);
        style_if(btn_dt8, 'active', (cx_dip & 8) != 0);
        style_if(sts_dt1, 'active', (cx_diag0.dip & 1) != 0);
        style_if(sts_dt2, 'active', (cx_diag0.dip & 2) != 0);
        style_if(sts_dt4, 'active', (cx_diag0.dip & 4) != 0);
        style_if(sts_dt8, 'active', (cx_diag0.dip & 8) != 0);
    }
    update_sense();
    update_diagsw();
    let active_connection = null;
    class WSConnection {
        constructor() {
            active_connection = this;
            style_if(local_button, 'active', active_connection != null);
            console.log('network connecting');
            this.socket = new WebSocket('ws://127.0.0.1:42646/');
            this.socket.binaryType = 'arraybuffer';
            this.socket.onopen = () => {
                console.log('network open');
            };
            this.socket.onclose = (ev) => {
                console.log('network closed', ev.code, `${ev.reason}`);
                active_connection = null;
                style_if(local_button, 'active', active_connection != null);
            };
            this.socket.onerror = () => {
                console.warn('network error');
                this.socket.close();
            };
            this.socket.onmessage = (ev) => {
                if (typeof ev.data == 'string') {
                    this.message_str(ev.data);
                }
                else if (ev.data instanceof ArrayBuffer) {
                    this.message(ev.data);
                }
            };
        }
        message_str(data) {
        }
        message(data) {
            const message = new DataView(data);
        }
    }
    function remote_check() {
        if (active_connection != null) {
            active_connection.socket.close();
            return;
        }
        new WSConnection();
    }
    btn_ss1.addEventListener('click', function (ev) { sense_switch ^= 1; update_sense(); config_updated(); });
    btn_ss2.addEventListener('click', function (ev) { sense_switch ^= 2; update_sense(); config_updated(); });
    btn_ss3.addEventListener('click', function (ev) { sense_switch ^= 4; update_sense(); config_updated(); });
    btn_ss4.addEventListener('click', function (ev) { sense_switch ^= 8; update_sense(); config_updated(); });
    btn_ssR.addEventListener('click', function (ev) { dswitch ^= 8; update_sense(); config_updated(); });
    btn_ssH.addEventListener('click', function (ev) { dswitch ^= 4; update_sense(); config_updated(); });
    btn_ssI.addEventListener('click', function (ev) { dswitch ^= 2; update_sense(); config_updated(); });
    btn_dt1.addEventListener('click', function (ev) { cx_dip ^= 1; update_diagsw(); });
    btn_dt2.addEventListener('click', function (ev) { cx_dip ^= 2; update_diagsw(); });
    btn_dt4.addEventListener('click', function (ev) { cx_dip ^= 4; update_diagsw(); });
    btn_dt8.addEventListener('click', function (ev) { cx_dip ^= 8; update_diagsw(); });
    btn_dtrun.addEventListener('click', function (ev) { cx_diag0.dip = cx_dip; update_diagsw(); config_updated(); });
    local_button.addEventListener('click', remote_check);
    reset_button.addEventListener('click', function (ev) { mcsim.reset(); });
    fp_rf.addEventListener('click', function (ev) { sense_switch ^= 8; update_sense(); config_updated(); });
    fp_load.addEventListener('click', function (ev) {
        if ((sense_switch | 2) != sense_switch) {
            sense_switch |= 2;
            config_updated();
            update_sense();
        }
        mcsim.reset();
    });
    fp_select.addEventListener('click', function (ev) {
        if ((sense_switch & 253) != sense_switch) {
            sense_switch &= 253;
            config_updated();
            update_sense();
        }
        mcsim.reset();
    });
    micro_button.addEventListener('click', function (ev) {
        frame_manager.toggle_show_raise(frame_mclist);
    });
    memory_button.addEventListener('click', function (ev) {
        show_mem = !show_mem;
        frame_memory.show = show_mem;
        if (show_mem) {
            frame_manager.raise_frame(frame_memory);
            update_memview();
        }
    });
    disk_button.addEventListener('click', function (ev) {
        frame_manager.toggle_show_raise(frame_disks);
        if (frame_disks.show)
            disk_view.update();
    });
    run_button.addEventListener('click', function (ev) {
        run_control(run_ctl == 0);
    });
    function update_runrate(new_rate) {
        run_rate = new_rate;
        config_updated();
        style_if(run_rate1, 'active', run_rate == 1);
        style_if(run_rate2, 'active', run_rate == 10);
        style_if(run_rate3, 'active', run_rate == 100);
        style_if(run_rate4, 'active', run_rate == 1000);
        style_if(run_rate5, 'active', run_rate == 10000);
        style_if(run_rate6, 'active', run_rate == 50000);
        style_if(run_rate7, 'active', run_rate == 100000);
        style_if(run_rate8, 'active', run_rate == 150000);
    }
    update_runrate(run_rate);
    run_rate1.addEventListener('click', function (ev) { update_runrate(1); });
    run_rate2.addEventListener('click', function (ev) { update_runrate(10); });
    run_rate3.addEventListener('click', function (ev) { update_runrate(100); });
    run_rate4.addEventListener('click', function (ev) { update_runrate(1000); });
    run_rate5.addEventListener('click', function (ev) { update_runrate(10000); });
    // can't handle this speed ;)
    run_rate6.addEventListener('click', function (ev) { update_runrate(50000); });
    run_rate7.addEventListener('click', function (ev) { update_runrate(100000); });
    run_rate8.addEventListener('click', function (ev) { update_runrate(150000); });
    step_button.addEventListener('click', function (ev) {
        run_once = true;
        run_step = true;
        run_follow = true;
        show_disasm();
        run_stop = function () {
            dis_vpc = mcsim.memaddr & 0xffff;
            handle_dbg_input(in_dbgcmd);
            show_disasm();
        };
        run_control(true);
    });
    microstep_button.addEventListener('click', function (ev) {
        run_once = true;
        mcsim.step(false);
        mcsim.step(true);
        mcsim.showstate(true);
        main_ffc.step(true);
        if (dis_after)
            show_disasm();
        if (memv_after)
            update_memview();
    });
    btn_settings.addEventListener('click', function (ev) {
        if (win_settings.style.display == 'none') {
            win_settings.style.display = '';
        }
        else {
            win_settings.style.display = 'none';
        }
    });
    btn_cm_import.addEventListener('click', function (ev) {
        annotation_import(txt_anno.value);
        show_disasm();
    });
    btn_cm_tocrt.addEventListener('click', function (ev) {
        console_text_import(txt_anno.value);
    });
    btn_cm_clear.addEventListener('click', function (ev) {
        txt_anno.value = '';
    });
    opt_rtc[0].addEventListener('change', function (ev) { if (this.checked)
        CONFIG.cpu[2] = 0; });
    opt_rtc[1].addEventListener('change', function (ev) { if (this.checked)
        CONFIG.cpu[2] = 1; });
    opt_rtc[2].addEventListener('change', function (ev) { if (this.checked)
        CONFIG.cpu[2] = 2; });
    conv_ee.addEventListener('change', function (ev) {
        name_conv = 0 /* NAMECON.CENT */;
        config_updated();
        show_disasm();
    });
    conv_mei.addEventListener('change', function (ev) {
        name_conv = 1 /* NAMECON.MEI */;
        config_updated();
        show_disasm();
    });
    conv_uew.addEventListener('change', function (ev) {
        name_conv = 2 /* NAMECON.WIKI */;
        config_updated();
        show_disasm();
    });
    conv_hex.addEventListener('change', function (ev) {
        HEX_CONV = this.checked;
        config_updated();
        show_disasm();
    });
    document.body.addEventListener('dragstart', function (ev) {
        const dt = ev.dataTransfer;
        if (dt) {
            dt.dropEffect = 'copy';
        }
        ev.preventDefault();
    });
    document.body.addEventListener('dragover', function (ev) {
        const dt = ev.dataTransfer;
        if (!dt) {
            ev.preventDefault();
            return;
        }
        if (dt && dt.items.length > 0 && dt.items[0].kind == 'file') {
            dt.dropEffect = 'copy';
        }
        else if (dt && dt.types.length > 0) {
            dt.dropEffect = 'copy';
        }
        else {
            dt.dropEffect = 'none';
        }
        ev.preventDefault();
    });
    function update_layout() {
        var _a, _b, _c, _d;
        display_if(dc_regs, show_reg);
        display_if(dc_int, show_int);
        display_if(dc_pages, show_page);
        display_if(dc_uop, show_uop);
        display_if(dc_listing, view_dis.checked);
        display_if(dc_ffc, show_ffc);
        display_if(dc_crt0, cx_crt0.show_ui);
        style_if(cv_term0, 'tall', ui_crts[0].tall.checked);
        style_if(cv_term0, 'wide', ui_crts[0].wide.checked);
        frame_crt1.show = ui_crts[1].view.checked;
        style_if(cv_term1, 'tall', ui_crts[1].tall.checked);
        style_if(cv_term1, 'wide', ui_crts[1].wide.checked);
        frame_crt2.show = ui_crts[2].view.checked;
        style_if(cv_term2, 'tall', ui_crts[2].tall.checked);
        style_if(cv_term2, 'wide', ui_crts[2].wide.checked);
        (_a = dc_regs.parentElement) === null || _a === void 0 ? void 0 : _a.removeChild(dc_regs);
        (_b = dc_crt0.parentElement) === null || _b === void 0 ? void 0 : _b.removeChild(dc_crt0);
        con_rows[1].removeChild(con_row2col2);
        let crt_wide_layout = ui_crts[0].wide.checked && !loc_crt0[1].checked;
        let crt_tall_layout = ui_crts[0].tall.checked;
        const reg_fits_on_first_row = show_reg && window.innerWidth >= 1688;
        const crt_fits_on_first_row = !ui_crts[0].wide.checked && !loc_crt0[1].checked && cx_crt0.show_ui && window.innerWidth >= 1410;
        let show_reg_layout = show_reg;
        let first_row_hp = !show_int || !show_uop || !reg_fits_on_first_row;
        if (!crt_wide_layout && reg_fits_on_first_row) {
            first_row_hp = false;
        }
        if (window.innerWidth < 1392) {
            crt_wide_layout = true;
            show_reg_layout = false;
        }
        if (loc_crt0[1].checked) { // crt bottom
            if (first_row_hp || !reg_fits_on_first_row) {
                con_rows[1].appendChild(dc_regs);
                crt_wide_layout = true;
                crt_tall_layout = false;
                show_reg_layout = false;
            }
            else {
                con_rows[0].appendChild(dc_regs);
                crt_wide_layout = true;
            }
        }
        else { // crt top
            if (!crt_fits_on_first_row && reg_fits_on_first_row) {
                con_rows[0].appendChild(dc_regs);
                con_rows[1].appendChild(dc_crt0);
            }
            else {
                con_rows[0].appendChild(dc_crt0);
                con_rows[1].appendChild(dc_regs);
            }
        }
        con_rows[1].appendChild(con_row2col2);
        (_c = dc_pages.parentElement) === null || _c === void 0 ? void 0 : _c.removeChild(dc_pages);
        (_d = dc_hawk.parentElement) === null || _d === void 0 ? void 0 : _d.removeChild(dc_hawk);
        if (first_row_hp && !crt_fits_on_first_row) {
            con_row1col2.appendChild(dc_hawk);
            con_row1col2.appendChild(dc_pages);
        }
        else if (crt_tall_layout && crt_fits_on_first_row) {
            con_row1col1.appendChild(dc_hawk);
            con_row1col1.appendChild(dc_pages);
        }
        else if (show_reg_layout && crt_fits_on_first_row) {
            con_row2col2.appendChild(dc_hawk);
            con_row2col2.appendChild(dc_pages);
        }
        else {
            con_rows[2].appendChild(dc_pages);
            con_rows[3].appendChild(dc_hawk);
        }
        if (loc_crt0[1].checked) {
            con_row6col2.appendChild(dc_crt0);
            con_row6col2.appendChild(dc_textio);
        }
    }
    window.addEventListener('resize', update_layout);
    function layout_and_config() {
        update_layout();
        config_updated();
    }
    loc_crt0[0].addEventListener('change', layout_and_config);
    loc_crt0[1].addEventListener('change', layout_and_config);
    ui_crts[0].view.addEventListener('change', function () {
        cx_crt0.show_ui = this.checked;
        config_updated();
        update_layout();
    });
    ui_crts[0].tall.addEventListener('change', layout_and_config);
    ui_crts[0].wide.addEventListener('change', layout_and_config);
    ui_crts[1].view.addEventListener('change', layout_and_config);
    ui_crts[1].tall.addEventListener('change', layout_and_config);
    ui_crts[1].wide.addEventListener('change', layout_and_config);
    ui_crts[2].view.addEventListener('change', layout_and_config);
    ui_crts[2].tall.addEventListener('change', layout_and_config);
    ui_crts[2].wide.addEventListener('change', layout_and_config);
    view_reg.addEventListener('change', function () {
        show_reg = this.checked;
        config_updated();
        update_layout();
    });
    view_page.addEventListener('change', function () {
        show_page = this.checked;
        config_updated();
        update_layout();
    });
    view_int.addEventListener('change', function () {
        show_int = this.checked;
        config_updated();
        update_layout();
    });
    view_uop.addEventListener('change', function () {
        show_uop = this.checked;
        config_updated();
        update_layout();
    });
    view_dis.addEventListener('change', function () {
        show_dis = this.checked;
        config_updated();
        update_layout();
    });
    view_ffc.addEventListener('change', function () {
        show_ffc = this.checked;
        config_updated();
        update_layout();
    });
    update_layout();
    class DiskImageUI {
        constructor(id_base, drive) {
            this.sta = document.getElementById(`${id_base}_sta`);
            this.wp = document.getElementById(`${id_base}wp`);
            this.selrem = document.getElementById(`${id_base}sel`);
            this.newdl = document.getElementById(`${id_base}new`);
            this.drive = drive;
            const self = this;
            this.newdl.addEventListener('click', (ev) => {
                if (this.image != null) {
                    export_disk(this.image);
                }
                else {
                    const buf = new ArrayBuffer(6651904);
                    const new_image = {
                        type: 'hawk',
                        stride: 512,
                        filename: 'NEWDISK',
                        backing_data: buf,
                        protect: false,
                        data: new Uint8Array(buf)
                    };
                    this.setactive(new_image);
                }
            });
            this.selrem.addEventListener('click', (ev) => {
                if (this.image) {
                    this.setactive(null);
                }
                else {
                    console.error('not implemented');
                }
            });
            this.wp.addEventListener('change', function (ev) {
                if (self.image != null) {
                    self.image.protect = this.checked;
                }
            });
        }
        setactive(image) {
            if (image != null) {
                disk_images[this.sta.id.substring(0, 5) + image.filename] = image;
                this.image = image;
                image.protect = this.wp.checked;
                this.sta.innerText = image.filename;
                this.selrem.innerText = 'Rem';
                this.newdl.innerText = 'DL';
            }
            else {
                delete this.image;
                this.sta.innerText = '';
                this.selrem.innerText = 'Sel';
                this.newdl.innerText = 'New';
            }
            if (this.drive != null) {
                this.drive.set_disk(image);
            }
        }
    }
    diskui.push(new DiskImageUI('dsk0', dsk2_0.units[0]));
    diskui.push(new DiskImageUI('dsk1', dsk2_0.units[1]));
    document.body.addEventListener('drop', async function (ev) {
        const dt = ev.dataTransfer;
        ev.preventDefault();
        if (dt == null || dt.files.length < 1) {
            return;
        }
        let file = dt.files[0];
        let accept = false;
        if (file.name.match(/\.(img|dsk)$/i) != null) {
            let buf = await file.arrayBuffer();
            let im_kind = 'empty';
            let im_stride = 512;
            if (file.size == 6651904) {
                im_kind = 'hawk';
                im_stride = 512;
            }
            else if (file.size == 5196800) {
                im_kind = 'hawk';
                im_stride = 400;
            }
            else if (file.size == 32524800) {
                im_kind = 'finch';
                im_stride = 13440;
            }
            else if (file.size == 28072000) {
                im_kind = 'finch';
                im_stride = 400;
            }
            else if (file.size == 35932160) {
                im_kind = 'finch';
                im_stride = 512;
            }
            const loaded_image = {
                type: im_kind,
                stride: im_stride,
                filename: file.name,
                backing_data: buf,
                protect: false,
                data: new Uint8Array(buf)
            };
            if (im_kind == 'hawk') {
                if (diskui[1].image == null) {
                    diskui[1].setactive(loaded_image);
                    console.log(`loaded disk image as Hawk0 fixed @ ${im_stride} B/sec`);
                }
                else {
                    diskui[0].setactive(loaded_image);
                    console.log(`loaded disk image as Hawk0 removable @ ${im_stride} B/sec`);
                }
            }
            else if (im_kind == 'finch') {
                if (im_stride == 13440) {
                    console.log('loaded disk image as Finch0 Raw Track Data');
                }
                else {
                    console.log(`loaded disk image as Finch0 @ ${im_stride} B/sec`);
                }
            }
            accept = true;
        }
        if (!accept && (file.name.match(/\.bin$/i) != null ||
            file.type === '' ||
            file.type == 'application/octet-stream')) {
            win_load.show(file).then(function (res) {
                console.log('load file', file.name, 'at', res.address, 'as', res.kind);
                const address = res.address;
                const kind = res.kind;
                file.arrayBuffer().then(function (b) {
                    let bv = new DataView(b);
                    const l = b.byteLength;
                    for (let ofs = 0; ofs < l; ofs++) {
                        bpl.writebyte((address + ofs) & 0x3ffff, bv.getUint8(ofs));
                    }
                });
            }, function () { console.log('cancel file', file.name); });
            accept = true;
        }
        if (!accept) {
            console.log('unknown drop!', file.name, file.type);
        }
    });
    show_disasm();
});
//# sourceMappingURL=cen.js.map