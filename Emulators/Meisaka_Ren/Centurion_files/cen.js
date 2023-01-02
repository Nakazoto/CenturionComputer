"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
window.addEventListener('load', function () {
    return __awaiter(this, void 0, void 0, function* () {
        // hi there
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
        const micro_button = document.getElementById('b_micro');
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
        const d_listing = document.getElementById('listing');
        const d_micro = document.getElementById('micro');
        const in_softcaps = document.getElementById('softcaps');
        const in_diagins = document.getElementById('diagins');
        const in_dbgcmd = document.getElementById('dbgcmd');
        const btnSaveFixed = document.getElementById('saveFixed');
        const btnSaveRemovable = document.getElementById('saveRemovable');
        const btn_cm_import = document.getElementById('cm_imp');
        const btn_cm_tocrt = document.getElementById('cm_vki');
        const btn_cm_clear = document.getElementById('cm_clear');
        const txt_anno = document.getElementById('anno');
        const cv_diag = document.getElementById('fp_diag');
        const cx_diag = cv_diag.getContext('2d');
        const btn_vctrl = document.getElementById('vctrl');
        const span_vbel = document.getElementById('vbel');
        const vt_fkeys = [
            document.getElementById('vcf1'),
            document.getElementById('vcf2'),
            document.getElementById('vcf3'),
            document.getElementById('vcf4'),
            document.getElementById('vcf5'),
            document.getElementById('vcf6'),
            document.getElementById('vcf7'),
            document.getElementById('vcf8')
        ];
        const dskui = [{
                sta: document.getElementById('dsk0_sta'),
                wp: document.getElementById('dsk0wp')
            }, {
                sta: document.getElementById('dsk1_sta'),
                wp: document.getElementById('dsk1wp')
            }];
        function style_if(elem, domclass, cond) {
            if (cond) {
                elem.classList.add(domclass);
            }
            else {
                elem.classList.remove(domclass);
            }
        }
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
            const o = {
                con: document.getElementById('wload'),
                file_name: document.getElementById('wload_fn'),
                file_type: document.getElementById('wload_ft'),
                file_size: document.getElementById('wload_fs'),
                load_addr: document.getElementById('wload_addr'),
                load_opt: [
                    document.getElementById('wload_lt0'),
                    document.getElementById('wload_lt1')
                ],
                show() {
                    this.con.style.display = '';
                    do_cancel();
                    return new Promise(function (resolve, reject) {
                        accept_fn = resolve;
                        cancel_fn = reject;
                    });
                },
                hide() {
                    this.con.style.display = 'none';
                }
            };
            document.getElementById('wload_h').addEventListener('click', function (ev) {
                o.hide();
                let f = accept_fn;
                accept_fn = null;
                cancel_fn = null;
                if (f != null) {
                    let address = parseInt(o.load_addr.value, 16);
                    if (isNaN(address)) {
                        address = 0x100;
                    }
                    let r = { address, kind: '' };
                    if (o.load_opt[0].checked) {
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
        const cx_term0 = cv_term0.getContext('2d');
        const cv_map = document.getElementById('fp_flagsc');
        const cx_map = cv_map.getContext('2d');
        cx_diag.fillStyle = '#ff3232';
        cx_diag.font = '16px monospace';
        cx_term0.fillStyle = '#6ac';
        cx_term0.strokeStyle = '#6ac';
        cx_term0.font = '12px monospace';
        cx_map.font = '20px monospace';
        let run_ctl = 0;
        let run_rate = 1;
        let run_step = false;
        let run_busy = false;
        let dis_after = false;
        let run_follow = false;
        let dis_vpc = 0x100;
        let dis_vpc_end = 0x200;
        let run_accu = 0;
        let run_accutime = 0;
        let run_once = false;
        let rate_match_input = false;
        const run_hw = [];
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
                }
                return;
            }
            if (run && (run_ctl == 0)) {
                run_once = true;
                fp_ext[1].classList.add('a');
                run_ctl = setInterval(function () {
                    run_busy = true;
                    run_follow = (run_rate <= 100);
                    let runtime = Date.now();
                    if (run_rate > 10000) {
                        let hsr = (run_rate / 100) | 0;
                        for (let i = 0; i < hsr; i++) {
                            run_hw_steps(100);
                            mcsim.hsstep();
                            if (run_ctl == 0) {
                                do_run_stop();
                                break;
                            }
                        }
                    }
                    else {
                        for (let i = 0; i < run_rate; i++) {
                            run_hw_steps(1);
                            mcsim.step(i == (run_rate - 1));
                            if (run_ctl == 0) {
                                do_run_stop();
                                break;
                            }
                        }
                    }
                    runtime = Date.now() - runtime;
                    run_accutime += runtime;
                    run_accu += run_rate;
                    run_busy = false;
                    if (run_ctl == 0) {
                        mcsim.step(true);
                        mcsim.showstate(true);
                    }
                    else {
                        mcsim.step(false);
                        mcsim.showstate(false);
                    }
                    if (dis_after) {
                        show_disasm();
                    }
                }, 20);
            }
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
            f1: bload(`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`),
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
            m: bload(`twBDgIJjBPiFlwJDhV74AEOFTs6C70OFPpaPAAIOEADBaFPNgomALKqdCC5srr2Aar5DvYLvLACF
xgLgzIWAjsGF0AD+/clmhXFnAMwAhV5OIgUAfIXZwk1pKRaFAMAAhTU1AQHG0AAAXynyfMYAhdnC
NQABboXWAMwpx+Ru9wCdM4XYB+DwCGy08w5DpMzJhfGF/QcB8YW56zxq7gAw/YcJtIZOwa5Dhb5D
8L5DhT67fsF+fv3JHuwADB4AvkNQAM4AwjOFNjPJZv1m5zxJLkMxAFlZWVlZWVlZWVlZWVlZWVnu
AA4AAG4Nyc0AxOokhdA3Nzc3+MSFNzc3N+fxxAAzf2YA8PAQkgUJQ4VuXAAAAADKBDMAZg8ICjMF
BwcECAwlBg07DzYzFyEVMwUJCjIEGh4eGxwXAOXJDhEFMwAgACAAMDM7ImazHDOg7RsEATMwETMw
IY4CmRwz7mbB6TMwMzA3MzRD5skcM+5mkvkSMw9mhQHtIiPJHFB/fwTMMw9mhYrQAAAAW8RAzQUF
ADMPMwo83wnwBWl/CO68zaDwM8CFZgtLAMzKuACuxvAwM8BmhfAJADMPhzswM8BOMGbk9y6OAgeQ
N80+zfAB9wFB8AagDtdo2tCQAYiFUvsQwYUAANUIC8qFxezuELH9cczC9ACFek5MgD+/f9/v/jIA
wGCFTII2PjgkBtkADwBrAMBghcWCxD44JAbZOyzWLwAOYLSvgkM+OLElAK47HmcADmDwgAUDPpgk
Bs0+uXupAA5gAAOCST44JAtm+d4EBQAO7veQgkyF6HsEhTg7poUAGVKUBz47hdbOC4UeeGaqhXdS
AHEFhc7wjQT9ABwGkYWHdgAAO4V+EwFiM2yA/GYAEWYAADuFrjuaYjNnbIXNAPoFAAAAbAATE2Iz
agGOCgTQBQAAAGyFpZveAAAAAAAArQWEAAAD8IXUYjN6zv6qAFsFlP6FDj3kG2Iz/XgFAAABBaT4
hQsOAABiM3wA0B0AzQW0O4WuOwZv3gAAgB7+NjOFNgY2ExsgCwAbm0cTABYAAPyFAAD8EwESHQAA
hQPAwA4ODg7wAwwMBgQGAggKV0JSJjZH8FcBESFmACCCAFcTNjOFZgNmylcFCv2FADtbDjYzhWYA
AAA7ha47AI5G2bQFNjOFZgBmzmbOZs5wAANDhT5kAJwBZs5mzmbOMDAAhQAKAgCFAAAAAMQAAADE
hQAAJACnXuqFAn6IzcpsyjYPM4VmTsoAhQCTqJeuAMyFwsbCQ9LQygD0zs4AuXR0m63GyzMA09N/
m3HN3AjqyEOFDkOFZIUJydLOCA8B+/sAPgeFxpsAIMkFgACS4QEBZgDGAGwAAADJ/QDNzgCd57g2
M4VmuH7AhX8cBgIAEwBjNjOFZrx+wBqgCM6FyQhTys4AZgC0fg73OMMqAIgwgDPJMApmRH4OLGYP
AUPgDIXaM4U2M35+DoXKCS47VwzQhdMAAIUAfg4mCC5DCMoM0IUAAAAAAGdlCIUOEeOeO4WuOwps
hfOO/vDH738QGGYAhNkF2ACQjsEAysAe85AP6wJgDjOFNjNHZs0DAs0AqVDOzs7Ohc7OzspjICAA
AH9DhU4wxoXmSGjKFGg6zrS+8MyFKIV/xqAKyly3sPOQCAgzwtWF1oWCZs4AAAAAAJoABEOFPlBD
hSY8xA4AAAAAAIUAAEOFDkPsyczNzCgAC9GyYUP3AQFI9uACPoWO/uyuUGFbXsKAIwjgKMzq7grM
hb0lABCAhcUACUOFDkNa9zNLxb5DsJkpERkR5MzNNjs5cMW+Q6SFxX8fQ/f2AoXBAHYExYWuhdnd
LsUmCZKRAImKfzfM6u5dfi4M950Ahcp+9AQ3EYVAAQwukPCIhdnCfA7Mhc4B6AFOydCN0YaRhABB
OMzF1KkBi9AAhWsFzpoAqP7NyS7AAYAQC54Ri6HBtE50D2hDMhA2CEOFPqfQwvZOXM3F6sgQNmwA
xP3ud+794AAAAI7uzjOYzIXF8OqoJvEAABEuAbzz3MUAwW7JnsR16G1kQ0LxM4VmD07CzpAksLDR
qLW1B9e0MwMADbgNJaCsvaxZeQC7u4W7u4W7AADwAQDwFo1YcIUicCEQYI5fhQAE5UASZgMGB2vt
qEYBA/APOOXOjgMDAcoBOGqQgFCFEhD35dU+1U5rhRyOxcIFMIAQCM2QPgAEB8X96oBZzsKxaH/+
wj4ChRcAEGnOFhW+Q4UOQ4dJ+cmO9gA5AA8gf6zFQAKsyazBAMyhlAPBAALFBJQGnb7JAKzBk0OF
ToXCwsYAELQAABMAoMxZyoCOZcUGlMaUyMl3l1qTnACAOsHCgBHkjtzwhQrEAIXthTrBxkcF6+kA
BcoA5ZGF8IUCP1ne3sE6CeGICgDF7qjD/YVo26h4M4U2HA/izen2JozNAEYT8LwZgFmfxgEz0I4I
ChMThWbGMzME0YU9zYFYggADMScUkQHJXeH7H8V0WFQAxcG1EbhE1EbZqIGFGo7WYMVWBMkaYdQA
tADU68EATlJDhT7FxADJejufCMzJTlHm98kyqJZ/gIh/TH6CRI61FS/wpgC9ARQACtkMgXcGCMHU
MATFHoMQqIbZ1r3lAMJKEcUBLIIHAczNBZsF5dY5wQXwHsWOq7DrQgXkBTOF2IAsGsDGmcgA0QXM
BfwbC3qFZgLOgtbZ1WZOEDOFZqSkJoUMLgBDhW4szMFDf4U+QMkzhTYzIzOFByPNS87Fu60=`),
            map: bload(`iwEZT4uLha97k4uOyn6Li/39/Pz7+/r6Vvn+7t7Ougfv7+/v7+/v7x0eIiMkIYuL+Pj4+Pj4+Pgu
LyolTU4fH0VFRUVFRUugQUFBQEBAQECJiYmJiYl8fUNDQ0BAQEBAFGVlZWVlt7AxZGRkZGRQUwlU
VFRUVIuJiWRkZGRkkJAbUVFRUVGLPTM1NTU1NTU1FVRUVFRUiwkzNTU1NTU1NStRUVFRUYsJMzU1
NTU1NTU8VFRUVFSLCTM1NTU1NTU1LGBgYGBgiwk0NjY2NjY2Nj5iYmJiYmuLNDY2NjY2NjYmYGBg
YGCLCTQ2NjY2NjY2MGJiYmJiixM0NjY2NjY2Ng==`)
        };
        const mclisting = [];
        const disk_images = {
            main: null,
            main_view: null,
            fixed: null,
            fixed_view: null,
        };
        const vt_width = 8;
        const vt_height = 10;
        const vt_font_data = new ImageData(128, 128);
        (() => {
            const vtf = new Uint32Array(vt_font_data.data.buffer);
            for (let y = 0; y < 64; y++) {
                const line0 = (y) * 128;
                //const line0 = (y << 1) * 128;
                //const line1 = ((y << 1) + 1) * 128;
                const vtline = y * 16;
                for (let x = 0; x < 128; x++) {
                    let bs = (x & 7);
                    let v = (vtfont[vtline + (x >> 3)] >> bs) & 1;
                    // #66aaf0
                    if (v > 0) {
                        vtf[line0 + x] = 0xcff0aa66;
                        //vtf[line1 + x] = 0xcff0aa66;
                        if (bs > 0) {
                            vtf[line0 + x - 1] |= 0x4ff0aa66;
                            //vtf[line1 + x - 1] |= 0x7cf0aa66;
                        }
                        if (bs < 7) {
                            vtf[line0 + x + 1] |= 0x4ff0aa66;
                            //vtf[line1 + x + 1] |= 0x7cf0aa66;
                        }
                    }
                }
            }
        })();
        const vt_font_bmp = yield createImageBitmap(vt_font_data);
        class VTerm {
            constructor(c) {
                this.buffer = new Uint8Array(80 * 24);
                this.blink = false;
                this.cursor_x = 0;
                this.cursor_y = 0;
                this.input_buf = [];
                this.mux = null;
                this.esc_mode = 0;
                this.esc_extra = 0;
                this.vbel_id = 0;
                this.ctx = c;
            }
            render_char(vcc, vcx, vcy) {
                const vtfx = (vcc & 15) * 8;
                const vtfy = (vcc >> 4) * 8;
                //this.ctx.strokeText(this.chardec(vcc), vcx, vcy + VTerm.char_base);
                this.ctx.drawImage(vt_font_bmp, vtfx, vtfy, 8, 8, vcx, vcy + 2, 8, 8);
            }
            update_blink() {
                const vcx = this.cursor_x * vt_width;
                const vcy = this.cursor_y * vt_height;
                const vca = this.cursor_y * VTerm.columns + this.cursor_x;
                let vcc = this.buffer[vca];
                this.ctx.clearRect(vcx, vcy, vt_width, vt_height);
                if (this.blink) {
                    this.ctx.fillRect(vcx, vcy, vt_width, vt_height);
                }
                else {
                    this.render_char(vcc, vcx, vcy);
                }
                this.blink = !this.blink;
            }
            chardec(c) {
                if ((c < 32) || (c > 127))
                    return 0;
                return c - 32;
            }
            scroll() {
                this.ctx.clearRect(0, 0, cv_term0.width, cv_term0.height);
                for (let r = 1; r < VTerm.rows; r++) {
                    const vcy = (r - 1) * vt_height;
                    const vcb = r * VTerm.columns;
                    for (let col = 0; col < VTerm.columns; col++) {
                        const vca = (r - 1) * VTerm.columns + col;
                        const vcx = col * vt_width;
                        let vcc = this.buffer[vca] = this.buffer[vcb + col];
                        this.render_char(vcc, vcx, vcy);
                    }
                }
                for (let vcx = 0; vcx < VTerm.columns; vcx++) {
                    const vca = (VTerm.rows - 1) * VTerm.columns + vcx;
                    this.buffer[vca] = 32;
                }
            }
            advance_line() {
                this.cursor_y++;
                if (this.cursor_y >= VTerm.rows) {
                    this.cursor_y = VTerm.rows - 1;
                    this.scroll();
                }
            }
            advance_cursor() {
                this.cursor_x++;
                if (this.cursor_x >= VTerm.columns) {
                    this.cursor_x = 0;
                    this.advance_line();
                }
            }
            write(c) {
                const vcx = this.cursor_x * vt_width;
                const vcy = this.cursor_y * vt_height;
                const vca = this.cursor_y * VTerm.columns + this.cursor_x;
                c = c & 255;
                if (this.esc_mode > 0) {
                    if (this.esc_mode == 2) {
                        this.esc_extra = c - 32;
                        this.esc_mode = 3;
                        if (this.esc_extra >= VTerm.rows) {
                            this.esc_mode = 0;
                        }
                        return;
                    }
                    if (this.esc_mode == 3) {
                        this.esc_mode = 0;
                        c -= 32;
                        if (c < VTerm.columns) {
                            this.cursor_x = c;
                            this.cursor_y = this.esc_extra;
                        }
                        this.ctx.clearRect(vcx, vcy, vt_width, vt_height);
                        this.render_char(this.buffer[vca], vcx, vcy);
                        return;
                    }
                    this.esc_mode = 0;
                    switch (c) {
                        case 5: // transmit status message
                            break;
                        case 48: // set vis attr
                            // maybe TODO?
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
                            // 64       constant normal
                            // 74       constant reverse
                            // 6c       print-only
                            // 7c       print-only reverse
                            break;
                        case 49: // begin line drawing
                            break;
                        case 50: // end line drawing
                            break;
                        case 51: // begin transparent mode
                        case 52: // end transparent mode
                            break;
                        case 71: // erase unprotected + home cursor
                        case 75: // erase unprotected from cursor to next field (or EOL if null form)
                        case 79: // cursor to previous unprotected field
                        case 82: // enter forms mode
                            break;
                        case 88: // print variable/print-only data to aux port
                            break;
                        case 89: // set cursor addr
                            this.esc_mode = 2;
                            break;
                        case 107: // erase unprotected from cursor to end of screen
                        case 115: // reset
                            break;
                        case 120: // print all data to aux port
                            break;
                    }
                    return;
                }
                if (c < 32) {
                    switch (c) {
                        case 0: // NUL
                            break;
                        case 1: // SOH
                            this.cursor_x = 0;
                            this.cursor_y = VTerm.rows - 1;
                            break;
                        case 6: // ACK
                            this.advance_cursor();
                            break;
                        case 7: // BEL (TODO)
                            span_vbel.classList.add('a');
                            if (this.vbel_id > 0) {
                                clearTimeout(this.vbel_id);
                            }
                            this.vbel_id = setTimeout(() => {
                                this.vbel_id = 0;
                                span_vbel.classList.remove('a');
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
                            break;
                        case 11: // VT
                            // TODO next char & 0x1f is row address
                            break;
                        case 12: { // FF (clear)
                            this.cursor_x = 0;
                            this.cursor_y = 0;
                            this.ctx.clearRect(0, 0, cv_term0.width, cv_term0.height);
                            let limit = VTerm.columns * VTerm.rows;
                            for (let q = 0; q < limit; q++) {
                                this.buffer[q] = 32;
                            }
                            return;
                        }
                        case 13: // CR
                            this.cursor_x = 0;
                            break;
                        case 16: // DLE (set horz address)
                            // TODO
                            // next char & 0x7f is converted to col address
                            // ((c >> 4) * 10) + (c & 0xf)
                            break;
                        case 18: // DC4 (aux port on)
                        case 20: // DC4 (aux port off)
                            break;
                        case 26: // SUB
                            this.cursor_y--;
                            if (this.cursor_y < 0) {
                                this.cursor_y = VTerm.rows - 1;
                            }
                            break;
                        case 27: // ESC
                            this.esc_mode = 1;
                            return;
                        default:
                            this.buffer[vca] = c;
                            this.advance_cursor();
                    }
                    this.ctx.clearRect(vcx, vcy, vt_width, vt_height);
                    this.render_char(this.buffer[vca], vcx, vcy);
                    return;
                }
                this.buffer[vca] = c;
                this.ctx.clearRect(vcx, vcy, vt_width, vt_height);
                this.render_char(c, vcx, vcy);
                this.advance_cursor();
            }
            receive(c) {
                if (this.input_buf.length < 8)
                    this.input_buf.push(c);
                if (this.mux != null) {
                    this.mux.receive_some(this.input_buf);
                }
            }
            text_import(txt) {
                let last = false;
                for (let c of txt) {
                    let v = c.codePointAt(0);
                    if (v == 10) {
                        if (last) {
                            this.input_buf.push(10); // backslash + newline (linefeed)
                        }
                        else {
                            this.input_buf.push(13); // typical Centurion newline
                        }
                        last = false;
                    }
                    else if (v == 92) { // backslash
                        last = true;
                    }
                    else {
                        if (last)
                            this.input_buf.push(92);
                        this.input_buf.push(v);
                        last = false;
                    }
                }
                if (this.mux != null) {
                    this.mux.receive_some(this.input_buf);
                }
            }
        }
        VTerm.columns = 80;
        VTerm.rows = 24;
        VTerm.char_base = 0;
        const cx_crt0 = new VTerm(cx_term0);
        function console_text_import(txt) {
            rate_match_input = true;
            cx_crt0.text_import(txt);
        }
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
        setInterval(function () { cx_crt0.update_blink(); }, 500);
        let vcontrol = false;
        btn_vctrl.addEventListener('click', function (ev) {
            vcontrol = !vcontrol;
            style_if(this, 'active', vcontrol);
            cv_term0.focus();
        });
        function send_fn(a) {
            cx_crt0.receive(2);
            cx_crt0.receive(a.charCodeAt(0));
            cx_crt0.receive(13);
            cv_term0.focus();
        }
        vt_fkeys[0].addEventListener('click', function (ev) { send_fn('1'); });
        vt_fkeys[1].addEventListener('click', function (ev) { send_fn('2'); });
        vt_fkeys[2].addEventListener('click', function (ev) { send_fn('3'); });
        vt_fkeys[3].addEventListener('click', function (ev) { send_fn('4'); });
        vt_fkeys[4].addEventListener('click', function (ev) { send_fn('5'); });
        vt_fkeys[5].addEventListener('click', function (ev) { send_fn('6'); });
        vt_fkeys[6].addEventListener('click', function (ev) { send_fn('7'); });
        vt_fkeys[7].addEventListener('click', function (ev) { send_fn('8'); });
        cv_term0.addEventListener('keypress', function (ev) {
            ev.preventDefault();
        });
        cv_term0.addEventListener('keydown', function (ev) {
            //console.log(ev.key.toUpperCase().charCodeAt(0));
            if (ev.ctrlKey || vcontrol) {
                let vcc = vtctrlkeys[ev.code];
                if (vcc !== undefined) {
                    cx_crt0.receive(vcc);
                }
                vcontrol = false;
                btn_vctrl.classList.remove('active');
            }
            else if (ev.key.length == 1) {
                if (in_softcaps.checked) {
                    cx_crt0.receive(ev.key.toUpperCase().charCodeAt(0));
                }
                else {
                    cx_crt0.receive(ev.key.charCodeAt(0));
                }
            }
            else
                switch (ev.key) {
                    case 'Backspace':
                        cx_crt0.receive(8);
                        break;
                    case 'Tab':
                        cx_crt0.receive(9);
                        break;
                    case 'Enter':
                        cx_crt0.receive(13);
                        break;
                    case 'Escape':
                        cx_crt0.receive(27);
                        break;
                    case 'ArrowUp':
                        cx_crt0.receive(26);
                        break;
                    case 'ArrowDown':
                        cx_crt0.receive(10);
                        break;
                    case 'ArrowLeft':
                        cx_crt0.receive(21);
                        break;
                    case 'ArrowRight':
                        cx_crt0.receive(6);
                        break;
                    case 'Home':
                        cx_crt0.receive(1);
                }
            ev.preventDefault();
        });
        cv_term0.addEventListener('keyup', function (ev) {
            ev.preventDefault();
        });
        (() => {
            for (let c of 'Centurion VI Simulator 2022') {
                cx_crt0.write(c.charCodeAt(0));
            }
        })();
        const init_program = '79 86 23 C8 E5 EC EC EF F2 EC E4 A1 8D 8A 00 71 80 01';
        const program_rotl = '60 AA AA 60 AA AA 55 40 37 00 37 00 37 00 37 00 37 00 37 00 37 00 37 00 37 00 37 00 37 00 37 00 37 00 37 00 37 00 37 00 71 01 03';
        const program_rotr = '60 AA AA 60 AA AA 55 40 36 00 36 00 36 00 36 00 36 00 36 00 36 00 36 00 36 00 36 00 36 00 36 00 36 00 36 00 36 00 36 00 71 01 03';
        let HEX_CONV = false;
        function hexlist(v, l = 2) {
            const pre = HEX_CONV ? '0x' : '';
            if (v < 0)
                return '-' + pre + ((-v).toString(16).toUpperCase().padStart(l, '0'));
            return pre + v.toString(16).toUpperCase().padStart(l, '0');
        }
        function hex(v, l = 2) {
            if (v < 0)
                return '-' + ((-v).toString(16).toUpperCase().padStart(l, '0'));
            return v.toString(16).toUpperCase().padStart(l, '0');
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
        function nyb(c) {
            return (c >> 4).toString(2).padStart(4, '0') + ' ' + (c & 15).toString(2).padStart(4, '0');
        }
        function bit(v, b) {
            return (v >> b) & 1;
        }
        const ALU_FN = ['+', '|', '&', '^'];
        const ALU_F = [
            { on: 0, ivr: false, ivs: false },
            { on: 0, ivr: true, ivs: false },
            { on: 0, ivr: false, ivs: true },
            { on: 1, ivr: false, ivs: false },
            { on: 2, ivr: false, ivs: false },
            { on: 2, ivr: true, ivs: false },
            { on: 3, ivr: false, ivs: false },
            { on: 3, ivr: true, ivs: false }
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
            static trace_str(srci, fni, dsti, ia, ib) {
                const vals_2 = `[${hex(ia, 1)}]`;
                const vals_3 = `[${hex(ib, 1)}]`;
                let val_r;
                let val_s;
                switch (srci & 7) {
                    default:
                    case 0:
                        val_r = vals_2;
                        val_s = 'Q';
                        break;
                    case 1:
                        val_r = vals_2;
                        val_s = vals_3;
                        break;
                    case 2:
                        val_r = '0';
                        val_s = 'Q';
                        break;
                    case 3:
                        val_r = '0';
                        val_s = vals_3;
                        break;
                    case 4:
                        val_r = '0';
                        val_s = vals_2;
                        break;
                    case 5:
                        val_r = 'D';
                        val_s = vals_2;
                        break;
                    case 6:
                        val_r = 'D';
                        val_s = 'Q';
                        break;
                    case 7:
                        val_r = 'D';
                        val_s = '0';
                        break;
                }
                let dst;
                switch (dsti & 7) {
                    default:
                    case 0:
                        dst = '      Q=  F=';
                        break;
                    case 1:
                        dst = '          F=';
                        break;
                    case 2:
                        dst = `F=${vals_2} ${vals_3}=  `;
                        break;
                    case 3:
                        dst = `      ${vals_3}=F=`;
                        break;
                    case 4:
                        dst = `>>Q >>${vals_3}=F=`;
                        break;
                    case 5:
                        dst = `    >>${vals_3}=F=`;
                        break;
                    case 6:
                        dst = `<<Q <<${vals_3}=F=`;
                        break;
                    case 7:
                        dst = `    <<${vals_3}=F=`;
                        break;
                }
                const fn = ALU_F[fni];
                return `SFD:${srci}${fni}${dsti} ${dst}${fn.ivr ? '~' : ' '}${val_r}${ALU_FN[fn.on]}${fn.ivs ? '~' : ' '}${val_s}`;
            }
        }
        const FN_SEQ_SN = ['uPC', 'AHR', 'STK', 'DIR'];
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
                this.is_write = true;
            }
            configio(id, m) {
                this.decode_io[id] = m;
            }
            clearmemory(base, sz = 256) {
                let aval = base & -256;
                let atarget = aval + sz;
                while (aval < atarget) {
                    let aindex = aval >> 8;
                    delete this.decode_hi[aindex];
                    aval += 256;
                }
            }
            configmemory(base, m, sz = 256) {
                let aval = base & -256;
                let atarget = aval + sz; // TODO
                let dev = {
                    dev: m,
                    base: aval,
                };
                if (m.is_write) {
                    dev.devw = m;
                }
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
            is_mmio(address) {
                let aindex = address >> 8;
                let dev = this.decode_hi[aindex];
                if (dev) {
                    return dev.dev.is_io == true;
                }
                else {
                    return true;
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
                if (dev && dev.devw) {
                    dev.devw.writebyte(address - dev.base, value);
                    if ((address >= dis_vpc) && (address < dis_vpc_end)) {
                        dis_after = true;
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
            let memdata_in = 0;
            let memdata_out = 0;
            let resetting = true;
            let physaddr = 0;
            let busctl = 0;
            let sysctl = 0;
            let sys_write_latch = false;
            let sys_read_in = false;
            let cycles = 0;
            let rtc = false;
            let f12a = 0;
            let f12b = 0;
            let b15a = 1;
            let dma_12 = 0;
            let dma_13 = 0;
            let dma_func = null;
            let swap = 0;
            let result = 0;
            let level = 0;
            let reqlevel = 0;
            let rir = 0;
            let rdr = 0;
            let pta = 0;
            let pta1a = 0;
            let pta2a = 0;
            let pta3a = 0;
            const mco = {
                step,
                hsstep,
                loadcache,
                showstate,
                reset,
                dma_request,
                dma_int(en) {
                    dma_12 = en ? 1 : 0;
                },
                physaddr() { return physaddr; },
                parity: 0,
                memfault: 0,
            };
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
                dma_13 = 0;
                cycles = 0;
                bpl.reset();
            }
            ;
            function showstate(in_halt) {
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
                mcs_alu.innerText = malu1;
                mcs_alu2.innerText = malu2;
                mcs_alu3.innerText = malu3;
                mcs_p.innerText = `${mcp} ${mpc} ${mhr}`;
                mcs_s.innerText = mstk;
                mcr_res.innerText = hex(result, 2);
                mcr_swap.innerText = hex(swap, 2);
                mcr_level.innerText = hex(level, 1);
                fp_level.innerText = `${hex(level, 1)} [${bin(level, 4)}]`;
                mcr_rfir.innerText = hex(rir);
                mcr_rfdr.innerText = hex(rdr);
                mcr_pta.innerText = hex(pta, 1);
                const is_running = (sysctl & 16) != 0;
                style_if(fp_runhalt[0], 'a', is_running); // run
                style_if(fp_runhalt[1], 'a', !is_running); // halt
                style_if(fp_ext[0], 'a', run_step);
                style_if(fp_ext[2], 'a', mco.memfault != 0);
                cx_map.clearRect(0, 0, cv_map.width, cv_map.height);
                const baseline = 22;
                cx_map.fillStyle = '#ff3232';
                if ((sysctl & 64) != 0) {
                    cx_map.fillRect(0, 0, 48, 30);
                }
                cx_map.fillStyle = '#aeaeae';
                cx_map.fillText('ABT', 8, baseline);
                let hrr2 = run_rate >> 1;
                if (in_halt) {
                    hrr2 = 0;
                    ccr_fa = ccr_f;
                    ccr_la = ccr_l;
                    ccr_ma = ccr_m;
                    ccr_va = ccr_v;
                    pta1a = pta & 1;
                    pta2a = (pta >> 1) & 1;
                    pta3a = (pta >> 2) & 1;
                }
                let hrr1 = hrr2 >> 1;
                let hrr3 = hrr2 + hrr1;
                function drawfill(v, x, t) {
                    if (v > 0) {
                        if (v > hrr3) {
                            cx_map.fillStyle = '#ff3232';
                        }
                        else if (v > hrr2) {
                            cx_map.fillStyle = '#c01c1c';
                        }
                        else if (v > hrr1) {
                            cx_map.fillStyle = '#901c1c';
                        }
                        else {
                            cx_map.fillStyle = '#400c0c';
                        }
                        cx_map.fillRect(x, 0, 27, 30);
                    }
                    cx_map.fillStyle = '#aeaeae';
                    cx_map.fillText(t, x + 7, baseline);
                }
                drawfill(pta3a, 49, '3');
                drawfill(pta2a, 77, '2');
                drawfill(pta1a, 105, '1');
                drawfill(ccr_fa, 133, 'F');
                drawfill(ccr_la, 161, 'L');
                drawfill(ccr_ma, 189, 'M');
                drawfill(ccr_va, 217, 'V');
                ccr_va = 0;
                ccr_fa = 0;
                ccr_la = 0;
                ccr_ma = 0;
                pta1a = 0;
                pta2a = 0;
                pta3a = 0;
                const ptindex = pta << 5;
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
                const bc = busctl;
                const sc = sysctl;
                mcr_bus.innerText = `${(bc & 1) > 0 ? 'I' : '-'} ${(bc & 2) > 0 ? '--' : 'AE'} ${(bc & 4) > 0 ? '--' : 'AC'} ${(bc & 8) > 0 ? 'U' : 'D'}` +
                    ` ${(bc & 16) > 0 ? 'DA' : '--'} ${(bc & 32) > 0 ? 'PT' : '--'} ${(bc & 64) > 0 ? 'MFE' : '---'}${(bc & 128) > 0 ? 'DMA' : '---'}`;
                mcr_sys.innerText = `${(sc & 1) > 0 ? 'DM4' : '---'} ${(sc & 2) > 0 ? 'DM3' : '---'} ${(sc & 4) > 0 ? 'TE' : '--'} ${(sc & 8) > 0 ? '-' : 'M'}` +
                    ` ${(sc & 16) > 0 ? 'R' : 'H'} ${(sc & 32) > 0 ? '--' : 'TR'} ${(sc & 64) > 0 ? 'A' : '-'} ${(sc & 128) > 0 ? 'IA' : '--'}`;
                const mpaddress = ((pgram & 127) << 11) | (memaddr & 0x7ff);
                mcr_addr.innerText = hex(workaddr, 4) + ' ' + hex(memaddr, 4) + ' ' + ((pgram & 128) != 0 ? '*' : '.') + hex(mpaddress, 5) + ' ' + hex(physaddr, 5);
                fp_addr.innerText = `${hex(memaddr, 4)} [${bin((memaddr >> 12) & 15, 4)} ${bin((memaddr >> 8) & 15, 4)} ${bin((memaddr >> 4) & 15, 4)} ${bin(memaddr & 15, 4)}]`;
            }
            ///////////////////////////////// Microcode stepping ////////////////////////////////////
            // fast delay:
            // 3ec 40 1B FFF8 92 800D orig
            //     40 23 FFF8 fc 800D fast
            // 3ed 40 23 7E11E1E00D orig
            //     40 1b 7E11E1E00D fast
            uc.f[0x3ec] = 0x23;
            uc.m[0x3ec] = 0x01;
            uc.f[0x3ed] = 0x1b;
            function dma_request(stepfn) {
                dma_func = stepfn;
                dma_13 = 1;
            }
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
                    const seq1_si_k6dc = seq12_s0i | ((((v6 >> 5) & 2) & (seq2_si_k6b ^ 2)) ^ 2);
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
                        seq0_si,
                        seq12_s0i,
                        seq2_si_k6b,
                        seq1_si_k6dc,
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
            let pindex = 0;
            let pgram = 0;
            let pgaddr = 0;
            let is_mmio = 0;
            let is_regmmio = 0;
            let notpgbit = 0;
            let is_mem = 0;
            function mempt_set() {
                pindex = ((memaddr >> 11) & 31) | (pta << 5);
                pgram = pagetb[pindex];
                pgaddr = (pgram & 127) | (((pgram & 112) == 112) ? 128 : 0);
                is_mmio = ((pgram & 253) == 253) ? 0 : 1;
                const is_reg = (((pgram & 127) == 0) && ((memaddr & 1792) == 0)) ? 0 : 1;
                is_regmmio = (is_reg & is_mmio) ^ 1;
                notpgbit = (pgram >> 7) ^ 1;
                is_mem = (is_reg & notpgbit) ^ 1;
                physaddr = (pgaddr << 11) | (memaddr & 0x7ff);
            }
            const mc_dma_control = {
                read() {
                    let v = bpl.readbyte(physaddr & 0x3ffff);
                    const count_up = (busctl & 8) != 0;
                    workaddr = (workaddr + (count_up ? 1 : -1)) & 0xffff;
                    memaddr = (memaddr + (count_up ? 1 : -1)) & 0xffff;
                    mempt_set();
                    return v;
                },
                write(value) {
                    bpl.writebyte(physaddr & 0x3ffff, value);
                    const count_up = (busctl & 8) != 0;
                    workaddr = (workaddr + (count_up ? 1 : -1)) & 0xffff;
                    memaddr = (memaddr + (count_up ? 1 : -1)) & 0xffff;
                    mempt_set();
                },
                end() {
                    dma_13 = 0;
                    dma_func = null;
                }
            };
            // this function is a variant that favours speed
            function hsstep() {
                for (let ql = 0; ql < 100; ql++) {
                    const mci = mpscache[mcpc];
                    const intena = (busctl & 1) != 0;
                    const sysint = reqlevel;
                    const dmaint = intena && (level < 2) && (dma_12 != 0);
                    const count_up = (busctl & 8) != 0;
                    if (run_once) {
                        run_once = false;
                    }
                    else if ((run_step && (mcpc == 0x101)) || mclisting[mcpc].bp) {
                        run_control(false);
                        dis_after = true;
                        dis_vpc = physaddr & 0x3ffff;
                        return;
                    }
                    let k9_com = 1;
                    if (mci.k9_en) {
                        switch (mci.k9_sel) {
                            case 0: /* TODO f12b */
                                k9_com = 1;
                                break;
                            case 1: /* rir.0 nor 4 */
                                k9_com = ((rir | (rir >> 4)) & 1) ^ 1;
                                break;
                            case 2: /* rir.0 */
                                k9_com = rir & 1;
                                break;
                            case 3: /* mmio/reg */
                                k9_com = is_regmmio;
                                break;
                            case 4: /* REG/pbit */
                                k9_com = is_mem;
                                break;
                            case 5: /* DMA P2.13 */
                                k9_com = dma_13;
                                break;
                            case 6: /* TODO B15A */
                                k9_com = b15a ^ 1;
                                break;
                            case 7: /* TODO F13->H13A any INT */
                                k9_com = dma_13;
                                if (dmaint || (intena && bpl.is_interrupt(level))) {
                                    k9_com = 1;
                                }
                                if (rtc && ((sysctl & 0x4) != 0)) {
                                    k9_com = 1;
                                }
                                break;
                        }
                        k9_com = k9_com ^ 1;
                    }
                    // branch and condition selectors
                    let seq_or = 0;
                    // seqencer control
                    const k9_com3 = k9_com | (k9_com << 1);
                    const seq0_s = (k9_com3 & mci.seq0_si) ^ 3;
                    const seq1_s = (k9_com3 & mci.seq1_si_k6dc) ^ 3;
                    const seq2_s = (k9_com3 & mci.seq2_si_k6b) ^ 3;
                    const seq_fc = (2 | k9_com) & mci.seq_fci;
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
                            h6a = h6b = ((alu_flag >> 3) & 1); /* TODO both get flag.C? */
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
                                if (dma_13 == 0)
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
                        case 1: break; // L13A_SET
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
                    if (cycles >= 8333) {
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
                            alu_flag = (aluc.zero) |
                                (aluc.sign << 1) | (aluc.over << 2) |
                                (aluc.main_carry_out << 3) | (aluc.half_carry_out << 4) | ((prevflag & 1) << 5);
                            break;
                        case 3: // DataRD
                            if (sys_write_latch) {
                                memdata_in = memdata_out;
                            }
                            else if (sys_read_in) {
                                mco.memfault = 0;
                                memdata_in = bpl.readbyte(physaddr & 0x3ffff);
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
                    if (((busctl & 20) == 16) && dma_func != null) {
                        dma_func((workaddr == 0xffff), mc_dma_control);
                    }
                    switch (mci.x_h11) {
                        case 0: break; // nop
                        case 1: // RD_START /* TODO */
                            sys_read_in = true;
                            break;
                        case 2: // WT_START /* TODO */
                            bpl.writebyte(physaddr & 0x3ffff, memdata_out);
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
                    ccr_la += ccr_l;
                    ccr_fa += ccr_f;
                    ccr_ma += ccr_m;
                    ccr_va += ccr_v;
                    pta1a += pta & 1;
                    pta2a += (pta >> 1) & 1;
                    pta3a += (pta >> 2) & 1;
                    aluc.step(mci.aluc_d, mci.aluc_b);
                    mcpc = ((s2.output << 8) | (s1.output << 4) | (s0.output)) & 0x7ff;
                }
            }
            function step(debug_output = false) {
                const mci = mpscache[mcpc];
                const intena = (busctl & 1) != 0;
                const intreq = intena && bpl.is_interrupt(level); // inverted on bus
                const sysint = reqlevel;
                const dmaint = intena && (level < 2) && (dma_12 != 0);
                const count_up = (busctl & 8) != 0;
                let k9_com = 1;
                if (mci.k9_en) {
                    switch (mci.k9_sel) {
                        case 0: /* TODO f12b */
                            k9_com = 1;
                            break;
                        case 1: /* rir.0 nor 4 */
                            k9_com = ((rir | (rir >> 4)) & 1) ^ 1;
                            break;
                        case 2: /* rir.0 */
                            k9_com = rir & 1;
                            break;
                        case 3: /* TODO: double check this (mmio/reg addressed) */
                            k9_com = is_regmmio;
                            break;
                        case 4: /* REG/pbit */
                            k9_com = is_mem;
                            break;
                        case 5: /* DMA P2.13 */
                            k9_com = dma_13;
                            break;
                        case 6: /* TODO B15A */
                            k9_com = b15a ^ 1;
                            break;
                        case 7: /* TODO F13->H13A any INT */
                            k9_com = dma_13;
                            if (intreq || dmaint) {
                                k9_com = 1;
                            }
                            if (rtc && ((sysctl & 0x4) != 0)) {
                                k9_com = 1;
                            }
                            break;
                    }
                    k9_com = k9_com ^ 1;
                }
                // branch and condition selectors
                let seq_or = 0;
                // seqencer control
                const k9_com3 = k9_com | (k9_com << 1);
                const seq0_s = (k9_com3 & mci.seq0_si) ^ 3;
                const seq1_s = (k9_com3 & mci.seq1_si_k6dc) ^ 3;
                const seq2_s = (k9_com3 & mci.seq2_si_k6b) ^ 3;
                const seq_fc = (2 | k9_com) & mci.seq_fci;
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
                        h6a = h6b = ((alu_flag >> 3) & 1); /* TODO both get flag.C? */
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
                            //seq_or |= 4; // TODO typically low
                            if (dma_13 == 0)
                                seq_or |= 8; // TODO - typically high if no DMA connection
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
                        dis_after = true;
                        dis_vpc = physaddr & 0x3ffff;
                    }
                    if (run_once) {
                        run_once = false;
                    }
                    else if ((run_step && (mcpc == 0x101)) || mclisting[mcpc].bp) {
                        run_control(false);
                        debug_output = true;
                    }
                }
                if (debug_output) {
                    let debug = mc_listing(mcpc, datapath, data_f, aluc.y);
                    mcs_op.innerText = debug.seq;
                    mcs_op_alu.innerText = debug.alu;
                    mcs_op_bus.innerText = debug.bus;
                    return;
                }
                if (mci.dp_sel == 11)
                    resetting = false;
                switch (mci.x_k11) {
                    case 0: break; // nop
                    case 1: break; // L13A_SET
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
                if (cycles >= 8333) {
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
                            memdata_in = bpl.readbyte(physaddr & 0x3ffff);
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
                if (((busctl & 20) == 16) && dma_func != null) {
                    dma_func((workaddr == 0xffff), mc_dma_control);
                }
                switch (mci.x_h11) {
                    case 0: break; // nop
                    case 1: // RD_START /* TODO */
                        sys_read_in = true;
                        break;
                    case 2: // WT_START /* TODO */
                        bpl.writebyte(physaddr & 0x3ffff, memdata_out);
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
                ccr_la += ccr_l;
                ccr_fa += ccr_f;
                ccr_ma += ccr_m;
                ccr_va += ccr_v;
                pta1a += pta & 1;
                pta2a += (pta >> 1) & 1;
                pta3a += (pta >> 2) & 1;
                aluc.step(mci.aluc_d, mci.aluc_b);
                mcpc = ((s2.output << 8) | (s1.output << 4) | (s0.output)) & 0x7ff;
            }
            return mco;
        }
        const mcsim = mcsetup();
        const FN_E6 = [
            '', 'Result=F', 'RIdx=F', 'Level=F',
            'PTA=F', 'ASwap', 'SEQ_RE', 'CondRegLD'
        ];
        function mc_listing(address, datapath, data_f, alu_y) {
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
            const seq1_si_k6dc = seq12_s0i | ((((c1 >> 21) & 2) & (seq2_si_k6b ^ 2)) ^ 2);
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
            const k9_fn = (!k9_en ? 'nop' : [
                '(0)BusAct',
                '(1)RIR.~0|4',
                '(2)RIR.0',
                '(3)Ad=IO/REG',
                '(4)Ad=REG/pbit',
                '(5)DMA_REQ',
                '(6)MemFault',
                '(7)IntCheck' // this one needs a better name (checks multiple interrupt lines)
            ][k9_sel]);
            let d_branch0 = '';
            let d_branch1 = '';
            let d_branch2 = '';
            let d_branch3 = '';
            if (seq_branch == 0) {
                switch (j13_sel) {
                    case 0:
                        if ((seqjmp | 1) != seqjmp)
                            d_branch0 = ' |1:ALUF.S';
                        if ((seqjmp | 2) != seqjmp)
                            d_branch1 = ' |2:ALUF.Z';
                        break;
                    case 1:
                        if ((seqjmp | 1) != seqjmp)
                            d_branch0 = ' |1:ALUF.H';
                        if ((seqjmp | 2) != seqjmp)
                            d_branch1 = ' |2:ALUF.V';
                        break;
                    case 2:
                        if ((seqjmp | 1) != seqjmp)
                            d_branch0 = ' |1:~pbit ';
                        if ((seqjmp | 2) != seqjmp)
                            d_branch1 = ' |2:~MMIO ';
                        break;
                    case 3: break; // nop
                }
                switch (k13_sel) {
                    case 0:
                        if ((seqjmp | 4) != seqjmp)
                            d_branch2 = ' |4:INT_ENA';
                        if ((seqjmp | 8) != seqjmp)
                            d_branch3 = ' |8:CCR.L  ';
                        break;
                    case 1:
                        if ((seqjmp | 4) != seqjmp)
                            d_branch2 = ' |4:DMA_INT';
                        if ((seqjmp | 8) != seqjmp)
                            d_branch3 = ' |8:INT_REQ';
                        break;
                    case 2:
                        if ((seqjmp | 4) != seqjmp)
                            d_branch2 = ' |4:MEM_INT';
                        if ((seqjmp | 8) != seqjmp)
                            d_branch3 = ' |8:DMA_REQ';
                        break;
                    case 3: break; // nop
                }
            }
            const seq0_s = seq0_si ^ 3;
            const seq1_s = seq1_si_k6dc ^ 3;
            const seq2_s = seq2_si_k6b ^ 3;
            const seq_fc = seq_fci;
            const d_f6h6 = ['0   ', '1   ', 'FL.C', '0!  '][x_f6h6] +
                ' SIn:' + (((aluc_d & 2) == 0) ? ['alu.s', 'AFL.C', 'q0   ', 'alu.c'][x_f6h6] : ['0    ', 'AFL.C', 'alu.s', '1    '][x_f6h6]);
            const lh = ALU.trace_str(aluc_s, aluc_f, aluc_d, aluc_a, aluc_b).padEnd(30);
            const d_ccr = (x_e6 == 7) ? ( // only for CCR load
            'cV=' + ['.  ', 'Z  ', 'R.V', 'LZ '][j12_sel] +
                ' cM=' + ['.  ', 'S  ', 'R.M', 'S  '][j12_sel] +
                ' cF=' + (j11_en ? '0' : ['Res.5', '1', '.', 'alu.o', 'Res.5', '1', '.', 'alu.o'][j11_sel]).padEnd(5) +
                ' cL=' + (j10_en ? '0' : ['.', '~', 'C', '(3)0', 'R.L', 'ALU.7', 'ALU.0/Q7', 'ALU.Q0'][j10_sel]).padEnd(8)) : '                                  ';
            const d_k11 = [
                /* 0 */ '',
                /* 1 */ 'DMAEndReset',
                /* 2 */ 'SysCtl:' + [
                    /* . */ 'P2.3', 'P2.4', 'RTC', 'MapDis',
                    /* . */ 'FP.Run', 'RTC.R', 'FP.ABT', 'INT_ACK'
                ][busctla] + '=' + busctld,
                /* 3 */ 'BusCtl:' + [
                    /* . */ 'IntEN', 'AddrToSys', 'DMACountDIS', 'AddrU/D',
                    /* . */ 'AddrCtlSel', 'ParityTest', 'ParityEN', 'DMA_EN'
                ][busctla] + '=' + busctld,
                /* 4 */ 'REG_WR(R)',
                /* 5 */ 'PTR_WR',
                /* 6 */ 'WA_LD',
                /* 7 */ 'SysDatOut_WR'
            ][x_k11];
            const mce7 = ['', 'BusReady', 'ALUFlag_LD', 'DataRD'][x_e7];
            const mch11 = [
                '', 'RD_START', 'WT_START', 'WorkAddr_LDH',
                'WorkAddr_Count', 'MemAddr_Count', 'F=MapROM', 'NibSwap'
            ][x_h11];
            const mcd_d45 = [
                'SWAPR', 'RDR', 'MA_H', 'MA_L', 'SWAPR', 'RDR', 'MA_H', 'MA_L',
                'PA', 'CCR_DSense', 'SysDatIn', 'R_H14', 'R_INTDIP', `RCnst(${hex(mpconst_m6)})`, '', ''
            ][dp_sel];
            return {
                seq: `${((datapath != undefined) ? hex(address, 3) : '')}` +
                    `:${hex(c1, 6)}${hex(c0, 8)} ${FN_SEQ_SN[seq2_s]} ${FN_SEQ_SN[seq1_s]} ${FN_SEQ_SN[seq0_s]} ${FN_SEQ_FE[seq_fc]} K9:${k9_fn.padEnd(14)} [${hex(seqjmp, 3)}]${d_branch0}${d_branch1}${d_branch2}${d_branch3}`,
                alu: (alu_y != undefined) ? `${lh} CIn=${d_f6h6} (${hex(data_f, 2)}:${hex(alu_y, 2)}) ${d_ccr}` : `${lh} CIn=${d_f6h6} ${d_ccr}`,
                bus: 'D4/5:DP' + ((datapath != undefined) ? `(${hex(datapath)})` : '') +
                    `=${mcd_d45.padEnd(10)} R:${x_c14_sel ? 'Lv' : 'RI'}${rir0 != 0 ? '|1' : '  '} K11:${d_k11.padEnd(18)} H11:${mch11.padEnd(14)} E6:${FN_E6[x_e6].padEnd(12)} E7:${mce7.padEnd(11)}`
            };
        }
        const listmax = 100;
        const listing = [];
        (function () {
            for (let i = 0; i < listmax; i++) {
                let listnode = document.createElement('div');
                listing.push(listnode);
                d_listing.appendChild(listnode);
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
                    mc1: document.createElement('div'),
                    mc2: document.createElement('div'),
                    mc3: document.createElement('div'),
                    bp: false,
                    bpc: bpcnode,
                };
                bpcnode.addEventListener('click', function (ev) {
                    const lst = listobj;
                    lst.bp = this.checked;
                });
                rightnode.appendChild(listobj.mc1);
                rightnode.appendChild(listobj.mc2);
                rightnode.appendChild(listobj.mc3);
                let lo = mc_listing(i);
                listobj.mc1.innerText = lo.seq;
                listobj.mc2.innerText = lo.alu;
                listobj.mc3.innerText = lo.bus;
                mclisting.push(listobj);
                d_micro.appendChild(listnode);
            }
        })();
        function update_microlist() {
            for (let i = 0; i < 2048; i++) {
                const m = mclisting[i];
                m.bpc.checked = m.bp;
            }
        }
        class DiagIO {
            constructor() {
                this.is_write = true;
                // TOS:1a, Aux:1d, Hawk:17-19, MUXINT:16, DMA:11/13
                this.dip = 0x0d;
                this.hexout = 0;
                this.points = 0;
                this.blank = false;
            }
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
                    default: return 0;
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
            }
        }
        class DSK2 {
            constructor() {
                this.is_io = true;
                this.is_write = true;
                this.sel_unit = 0;
                this.units = [new DSK2Unit(), new DSK2Unit()];
                this.busy = false;
                this.busy_time = 0;
                this.wpmask = 0;
                this.seeking = false;
                this.seek_done = false;
                this.sect_remain = 0;
                this.command = -1;
                this.interrupt_en = false;
                this.interrupt_pend = false;
            }
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
                            if (this.interrupt_en)
                                mcsim.dma_int(true);
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
                let v = 0;
                let u;
                switch (address) {
                    case 0:
                        v = this.sel_unit;
                        break;
                    case 1: // cylh
                        u = this.units[this.sel_unit];
                        if (u) {
                            v = u.sel_address >> 8;
                        }
                        break;
                    case 2: // cyll:h:sec
                        u = this.units[this.sel_unit];
                        if (u) {
                            v = u.sel_address & 0xff;
                        }
                        break;
                    case 3: // wpmask?
                        v = this.wpmask;
                        break;
                    case 4: // stat hi / 0 tmo adrerr fmterr | 0 seekerr fault busy
                        if (this.sel_unit == 1 || this.sel_unit == 0) {
                            v = ((this.busy || this.seeking) ? 1 : 0);
                        }
                        break;
                    case 5: // stat lo / wtpr wten oncyl ready | seekcom3..0
                        if (this.sel_unit == 1 || this.sel_unit == 0) {
                            v = ((dskui[this.sel_unit].wp.checked !== false) ? 0x80 : 0) /* wp */ |
                                ((this.wpmask & (1 << this.sel_unit)) ? 0x40 : 0) |
                                (this.seeking ? 0 : 0x20) /* oncyl */ |
                                (disk_images.main_view != null ? 0x10 : 0) /* ready */ |
                                (this.seek_done ? 0x01 : 0);
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
            do_dma_read() {
                const u = this.units[this.sel_unit];
                const unitdata = disk_images[this.sel_unit == 0 ? 'main_view' : 'fixed_view'];
                if (u == null || unitdata == null)
                    return;
                mcsim.dma_request((atend, ctrl) => {
                    if (atend) {
                        ctrl.end();
                        this.busy_time = 10;
                    }
                    else {
                        if (this.sect_remain <= 0) {
                            this.sect_remain = 400;
                            u.sel_address++;
                        }
                        const fileaddr = u.sel_address * 512;
                        let b = unitdata.getUint8(fileaddr + 400 - this.sect_remain);
                        ctrl.write(b);
                        this.sect_remain--;
                    }
                });
            }
            do_dma_write() {
                const u = this.units[this.sel_unit];
                const unitdata = disk_images[this.sel_unit == 0 ? 'main_view' : 'fixed_view'];
                if (u == null || unitdata == null)
                    return;
                mcsim.dma_request((atend, ctrl) => {
                    if (atend) {
                        ctrl.end();
                        this.busy_time = 10;
                    }
                    else {
                        if (this.sect_remain <= 0) {
                            this.sect_remain = 400;
                            u.sel_address++;
                        }
                        const fileaddr = u.sel_address * 512;
                        let b = ctrl.read();
                        unitdata.setUint8(fileaddr + 400 - this.sect_remain, b);
                        this.sect_remain--;
                    }
                });
            }
            writebyte(address, value) {
                var _a, _b;
                const u = this.units[this.sel_unit];
                switch (address) {
                    case 0:
                        this.sel_unit = value & 0x7;
                        break;
                    case 1: // cylh
                        if (u) {
                            u.sel_address = (u.sel_address & 0xff) | (value << 8);
                        }
                        break;
                    case 2: // cyll:h:sec
                        if (u) {
                            u.sel_address = (u.sel_address & 0xff00) | (value & 0xff);
                        }
                        break;
                    case 3: // wpmask
                        this.wpmask = value & 0xff;
                        break;
                    case 8: // cmd
                        if (u == null)
                            break;
                        // 0=read
                        // 1=write
                        // 2=seek
                        // 3=rtzcal
                        // 4=format?
                        this.seek_done = false;
                        this.busy = true;
                        this.command = value;
                        switch (value) {
                            case 0:
                                //console.log('DSK2:read:', hex(u.sel_address, 4));
                                this.busy_time = 0;
                                this.sect_remain = 400;
                                this.do_dma_read();
                                break;
                            case 4: // verify?? (typically issued after cmd 1)
                            case 1:
                                this.busy_time = 1;
                                this.sect_remain = 400;
                                if (((this.wpmask & (1 << this.sel_unit)) != 0) && !(((_b = (_a = dskui[this.sel_unit]) === null || _a === void 0 ? void 0 : _a.wp) === null || _b === void 0 ? void 0 : _b.checked) !== false)) {
                                    this.busy_time = 0;
                                    //console.log('DSK2:do_write:', hex(u.sel_address, 4));
                                    this.do_dma_write();
                                }
                                else {
                                    console.log('DSK2:wp_write:', hex(u.sel_address, 4));
                                }
                                break;
                            case 2:
                                //console.log('DSK2:seek:', hex(this.sel_address, 4));
                                this.busy_time = 40;
                                this.seeking = true;
                                break;
                            case 3:
                                //console.log('DSK2:rtz');
                                this.busy_time = 200;
                                this.seeking = true;
                                break;
                            default:
                                console.log('DSK2:cmd:', hex(value), hex(u.sel_address, 4));
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
        class MUXPort {
            constructor(card) {
                this.write_busy = false;
                this.write_full = false;
                this.read_busy = false;
                this.read_full = false;
                this.read_buffer = 0;
                this._cts = true;
                this.buf_write = 0;
                this.input_interval = 0;
                this.card = card;
            }
            run(increment) {
                if (rate_match_input && cx_crt0.input_buf.length > 0) {
                    this.input_interval += increment;
                    if (this.input_interval >= 20000) {
                        this.input_interval = 0;
                        this.receive_some(cx_crt0.input_buf);
                    }
                    if (cx_crt0.input_buf.length == 0) {
                        rate_match_input = false;
                    }
                }
            }
            get cts() { return this._cts; }
            set cts(value) {
                this._cts = value;
                if (!rate_match_input)
                    this.receive_some(cx_crt0.input_buf);
            }
            read_status() {
                return (this.write_busy ? 0 : 2) | (this.read_busy ? 1 : 0) | 0x20;
            }
            read_data() {
                let vcc = this.read_buffer;
                this.read_buffer = 0;
                this.read_busy = false;
                if (!rate_match_input)
                    this.receive_some(cx_crt0.input_buf);
                return vcc;
            }
            write_control(value) {
            }
            write_data(value) {
                this.write_busy = true;
                this.buf_write = value;
                //setTimeout(()=>{
                this.write_busy = false;
                cx_crt0.write(this.buf_write & 0x7f);
                //}, 0);
            }
            receive_some(buffer) {
                if (!this._cts)
                    return;
                if (this.read_busy) {
                    //this.card.interrupt_pend = true;
                    //this.card.mux_cause = true;
                    return;
                }
                let sv = buffer.shift();
                if (sv !== undefined) {
                    this.receive(sv);
                }
            }
            receive(data) {
                this.read_buffer = data;
                this.read_busy = true;
                this.card.interrupt_pend = true;
                this.card.mux_cause = true;
            }
        }
        class MockPrinter {
            constructor() {
                this.is_io = true;
                this.is_write = true;
            }
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
        class TestCMD {
            constructor() {
                this.is_io = true;
                this.is_write = true;
                this.data_in = 0;
                this.data_out = 0;
                this.data_fout = false;
                this.data_fin = false;
                this.state = 0;
                this.address = 0;
                this.count = 0;
            }
            process() {
                switch (this.state) {
                    case 0:
                        if (this.data_fin) {
                            if (this.data_in == 0x46) {
                                this.state = 0x46;
                            }
                            if (this.data_in == 0x47) {
                                this.state = 0x46;
                            }
                            this.data_fin = false;
                        }
                        break;
                    case 1:
                        if (this.data_fin) {
                            this.data_fin = false;
                        }
                        break;
                    case 0x40:
                        if (this.data_fin) {
                            this.data_fin = false;
                        }
                        break;
                    case 0x46:
                        if (this.data_fin) {
                            this.data_fin = false;
                            this.state = 0x100;
                        }
                        break;
                    case 0x100:
                        if (this.data_fin) {
                            this.data_fin = false;
                            this.state = 0x101;
                        }
                        break;
                    case 0x101:
                        if (this.data_fin) {
                            this.data_fin = false;
                            this.state = 0x102;
                        }
                        break;
                    case 0x102:
                        if (this.data_fin) {
                            this.data_fin = false;
                            this.state = 0;
                            this.data_out = 0;
                            this.data_fout = true;
                        }
                        break;
                }
            }
            readbyte(address) {
                let value = 0;
                if (address == 1) {
                    if (this.data_fout)
                        value |= 1;
                    if (this.data_fin)
                        value |= 2;
                    if (this.state > 16)
                        value |= 8;
                    this.process();
                }
                else {
                    this.data_fout = false;
                    value = this.data_out;
                    if (this.state == 1) {
                        this.state = 0x40;
                    }
                    //console.log('CMDTrace-R', address, hex(value));
                }
                return value;
            }
            writebyte(address, value) {
                if (address == 0) {
                    this.data_in = value;
                    this.data_fin = true;
                }
                else {
                    console.log('CMDTrace-W', address, hex(value));
                }
            }
        }
        class MMIOTrace {
            constructor() {
                this.v = new Uint8Array(20);
                this.is_io = true;
                this.is_write = true;
            }
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
                this.is_io = true;
                this.is_write = true;
                this.devices = [];
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
        class MMIOMux {
            constructor() {
                this.muxports = [new MUXPort(this)];
                this.is_io = true;
                this.is_write = true;
                this.interrupt_level = 0;
                this.interrupt_en = false;
                this.interrupt_pend = false;
                this.mux_cause = false;
                this.tx_int = 0;
                run_hw.push(this.muxports[0]);
            }
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
        class MemBase {
            constructor(init) {
                this.contents = this.allocate();
                this.view = new DataView(this.contents);
                if (init) {
                    if (init.bin !== undefined) {
                        this.loadbin(init.bin, init.addr);
                    }
                    if (init.hex !== undefined) {
                        this.loadhex(init.hex);
                    }
                }
            }
            allocate() {
                throw new Error('abstract');
            }
            readbyte(address) {
                return this.view.getUint8(address);
            }
            writebyte(address, value) {
                this.view.setUint8(address, value & 255);
            }
            loadbin(v, addrfn) {
                const l = v.length;
                if (addrfn == null) {
                    for (let a = 0; a < l; a++) {
                        this.writebyte(a, v[a]);
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
                            this.writebyte(a, v[txa]);
                        }
                    }
                    else {
                        for (let a = 0; a < l; a++) {
                            let txa = a ^ xm;
                            this.writebyte(a, v[txa]);
                        }
                    }
                }
            }
            // load a space/lf delimited list of hex values
            loadhex(h, ofs = 0) {
                let msh = h.split(/[ \n]/);
                let vpc = ofs;
                msh.forEach(value => {
                    if (value !== '') {
                        let v = parseInt(value, 16);
                        this.writebyte(vpc, v & 0xff);
                        vpc++;
                    }
                });
            }
        }
        class RamBase extends MemBase {
            constructor() {
                super(...arguments);
                this.is_io = false;
                this.is_write = true;
            }
        }
        class SysMem extends RamBase {
            constructor() {
                super(...arguments);
                this.pram = new ArrayBuffer(0x800);
                this.pview = new DataView(this.pram);
            }
            allocate() {
                return new ArrayBuffer(0x4000);
            }
            readbyte(address) {
                const value = this.view.getUint8(address);
                let pval = value ^ (value >> 4);
                pval = pval ^ (pval >> 2);
                pval = (pval ^ (pval >> 1)) & 1;
                const bit = (address & 7);
                const pv = (this.pview.getUint8(address >> 3) >> bit) & 1;
                mcsim.memfault = pv ^ pval;
                return value;
            }
            writebyte(address, value) {
                let pval = value ^ (value >> 4);
                pval = pval ^ (pval >> 2);
                pval = (pval ^ (pval >> 1) ^ mcsim.parity) & 1;
                const bit = (address & 7);
                const pv = (this.pview.getUint8(address >> 3) & ((1 << bit) ^ 255)) | (pval << bit);
                this.pview.setUint8(address >> 3, pv);
                this.view.setUint8(address, value & 255);
            }
        }
        class ROM512 extends MemBase {
            allocate() {
                return new ArrayBuffer(512);
            }
        }
        class ROM2k extends MemBase {
            allocate() {
                return new ArrayBuffer(2048);
            }
        }
        class RAM2k extends RamBase {
            allocate() {
                return new ArrayBuffer(2048);
            }
        }
        const regname = [
            'AH', 'AL', 'BH', 'BL', 'XH', 'XL', 'YH', 'YL',
            'ZH', 'ZL', 'SH', 'SL', 'CH', 'CL', 'PCH', 'PCL',
            'A', 'A!', 'B', 'B!', 'X', 'X!', 'Y', 'Y!',
            'Z', 'Z!', 'S', 'S!', 'C', 'C!', 'PC', 'PC!',
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
        let NAME_CONV = 1;
        const NB = String.fromCodePoint(0xa0);
        const oplist = [
            // 0x0H
            { n: 'HALT', md: 0 /* OPM.IMPL */ }, { n: 'NOP', md: 0 /* OPM.IMPL */ },
            { n: 'SF', md: 0 /* OPM.IMPL */ }, { n: 'RF', md: 0 /* OPM.IMPL */ },
            { n: 'EI', md: 0 /* OPM.IMPL */ }, { n: 'DI', md: 0 /* OPM.IMPL */ },
            { n: 'SL', md: 0 /* OPM.IMPL */ }, { n: 'RL', md: 0 /* OPM.IMPL */ },
            { n: 'CL', nm: 'COML', md: 0 /* OPM.IMPL */ },
            { n: 'RSR', nm: 'RET', md: 0 /* OPM.IMPL */ },
            { n: 'RI', nm: 'RETI', md: 0 /* OPM.IMPL */ },
            { n: '!ill0B', md: 0 /* OPM.IMPL */ },
            { n: 'SYN', md: 0 /* OPM.IMPL */ },
            { n: 'PCX', nm: 'MOV', ms: 10 /* OPM.IMPL_R */, md: 10 /* OPM.IMPL_R */, w: 1 /* TXS.W */, sr: 14 /* REG.PC */, dr: 4 /* REG.X */ },
            { n: 'DLY', nm: 'DELAY', md: 0 /* OPM.IMPL */ },
            { n: 'RSV', nm: 'SPVRET', md: 0 /* OPM.IMPL */ },
            // 0x1H
            { n: 'BL', md: 4 /* OPM.PCO */, w: 2 /* TXS.F */ }, { n: 'BNL', md: 4 /* OPM.PCO */, w: 2 /* TXS.F */ },
            { n: 'BF', md: 4 /* OPM.PCO */, w: 2 /* TXS.F */ }, { n: 'BNF', md: 4 /* OPM.PCO */, w: 2 /* TXS.F */ },
            { n: 'BZ', md: 4 /* OPM.PCO */, w: 2 /* TXS.F */ }, { n: 'BNZ', md: 4 /* OPM.PCO */, w: 2 /* TXS.F */ },
            { n: 'BM', md: 4 /* OPM.PCO */, w: 2 /* TXS.F */ }, { n: 'BP', md: 4 /* OPM.PCO */, w: 2 /* TXS.F */ },
            { n: 'BGE', md: 4 /* OPM.PCO */, w: 2 /* TXS.F */ }, { n: 'BLE', md: 4 /* OPM.PCO */, w: 2 /* TXS.F */ },
            { n: 'BS1', md: 4 /* OPM.PCO */, w: 2 /* TXS.F */ }, { n: 'BS2', md: 4 /* OPM.PCO */, w: 2 /* TXS.F */ },
            { n: 'BS3', md: 4 /* OPM.PCO */, w: 2 /* TXS.F */ }, { n: 'BS4', md: 4 /* OPM.PCO */, w: 2 /* TXS.F */ },
            { n: '?BTM?', md: 0 /* OPM.IMPL */ },
            { n: '?BEP?', md: 0 /* OPM.IMPL */ },
            // 0x2H
            { n: 'INRB', nm: 'INC', md: 8 /* OPM.RC */, w: 0 /* TXS.B */, i: 1 }, { n: 'DCRB', nm: 'DEC', md: 8 /* OPM.RC */, w: 0 /* TXS.B */, i: 1 },
            { n: 'CLRB', md: 8 /* OPM.RC */, w: 0 /* TXS.B */ }, { n: 'IVR', nm: 'NOT', md: 8 /* OPM.RC */, w: 0 /* TXS.B */ },
            { n: 'SRRB', nm: 'SRA', md: 8 /* OPM.RC */, w: 0 /* TXS.B */, i: 1 }, { n: 'SLRB', nm: 'SLL', md: 8 /* OPM.RC */, w: 0 /* TXS.B */, i: 1 },
            { n: 'RRRB', nm: 'RORC', md: 8 /* OPM.RC */, w: 0 /* TXS.B */, i: 1 }, { n: 'RLRB', nm: 'ROLC', md: 8 /* OPM.RC */, w: 0 /* TXS.B */, i: 1 },
            { n: 'INAB', nm: 'INC', md: 10 /* OPM.IMPL_R */, w: 0 /* TXS.B */, dr: 1 /* REG.AL */ },
            { n: 'DCAB', nm: 'DEC', md: 10 /* OPM.IMPL_R */, w: 0 /* TXS.B */, dr: 1 /* REG.AL */ },
            { n: 'CLAB', nm: 'CLR', md: 10 /* OPM.IMPL_R */, w: 0 /* TXS.B */, dr: 1 /* REG.AL */ },
            { n: 'IVAB', nm: 'NOT', md: 10 /* OPM.IMPL_R */, w: 0 /* TXS.B */, dr: 1 /* REG.AL */ },
            { n: 'SRAB', nm: 'SRA', md: 10 /* OPM.IMPL_R */, w: 0 /* TXS.B */, dr: 1 /* REG.AL */ },
            { n: 'SLAB', nm: 'SLL', md: 10 /* OPM.IMPL_R */, w: 0 /* TXS.B */, dr: 1 /* REG.AL */ },
            { n: 'page', md: 0 /* OPM.IMPL */, x: 2 /* OPL_EXT.PAGE */ },
            { n: 'dma.', md: 0 /* OPM.IMPL */, x: 3 /* OPL_EXT.DMA */ },
            // 0x3H
            { n: 'INR', nm: 'INC', md: 8 /* OPM.RC */, w: 1 /* TXS.W */, i: 1 }, { n: 'DCR', nm: 'DEC', md: 8 /* OPM.RC */, w: 1 /* TXS.W */, i: 1 },
            { n: 'CLR', md: 8 /* OPM.RC */, w: 1 /* TXS.W */ }, { n: 'IVR', nm: 'NOT', md: 8 /* OPM.RC */, w: 1 /* TXS.W */ },
            { n: 'SRR', nm: 'SRA', md: 8 /* OPM.RC */, w: 1 /* TXS.W */, i: 1 }, { n: 'SLR', nm: 'SLL', md: 8 /* OPM.RC */, w: 1 /* TXS.W */, i: 1 },
            { n: 'RRR', nm: 'RORC', md: 8 /* OPM.RC */, w: 1 /* TXS.W */, i: 1 }, { n: 'RLR', nm: 'ROLC', md: 8 /* OPM.RC */, w: 1 /* TXS.W */, i: 1 },
            { n: 'INA', nm: 'INC', md: 10 /* OPM.IMPL_R */, w: 1 /* TXS.W */, dr: 0 /* REG.A */ },
            { n: 'DCA', nm: 'DEC', md: 10 /* OPM.IMPL_R */, w: 1 /* TXS.W */, dr: 0 /* REG.A */ },
            { n: 'CLA', nm: 'CLR', md: 10 /* OPM.IMPL_R */, w: 1 /* TXS.W */, dr: 0 /* REG.A */ },
            { n: 'IVA', nm: 'NOT', md: 10 /* OPM.IMPL_R */, w: 1 /* TXS.W */, dr: 0 /* REG.A */ },
            { n: 'SRA', nm: 'SRA', md: 10 /* OPM.IMPL_R */, w: 1 /* TXS.W */, dr: 0 /* REG.A */ },
            { n: 'SLA', nm: 'SLL', md: 10 /* OPM.IMPL_R */, w: 1 /* TXS.W */, dr: 0 /* REG.A */ },
            { n: 'INX', nm: 'INC', md: 10 /* OPM.IMPL_R */, w: 1 /* TXS.W */, dr: 4 /* REG.X */ },
            { n: 'DCX', nm: 'DEC', md: 10 /* OPM.IMPL_R */, w: 1 /* TXS.W */, dr: 4 /* REG.X */ },
            // 0x4H
            { n: 'ADDB', md: 7 /* OPM.RR */, w: 0 /* TXS.B */ }, { n: 'SUBB', md: 7 /* OPM.RR */, w: 0 /* TXS.B */ },
            { n: 'ANDB', md: 7 /* OPM.RR */, w: 0 /* TXS.B */ }, { n: 'ORIB', nm: 'OR', md: 7 /* OPM.RR */, w: 0 /* TXS.B */ },
            { n: 'OREB', nm: 'XOR', md: 7 /* OPM.RR */, w: 0 /* TXS.B */ },
            { n: 'XFRB', nm: 'MOV', md: 7 /* OPM.RR */, w: 0 /* TXS.B */ },
            { n: 'big', md: 0 /* OPM.IMPL */ },
            { n: 'mem', md: 0 /* OPM.IMPL */ },
            { n: 'AABB', nm: 'ADD', ms: 10 /* OPM.IMPL_R */, md: 10 /* OPM.IMPL_R */, w: 0 /* TXS.B */, sr: 1 /* REG.AL */, dr: 3 /* REG.BL */ },
            { n: 'SABB', nm: 'SUB', ms: 10 /* OPM.IMPL_R */, md: 10 /* OPM.IMPL_R */, w: 0 /* TXS.B */, sr: 1 /* REG.AL */, dr: 3 /* REG.BL */ },
            { n: 'NABB', nm: 'AND', ms: 10 /* OPM.IMPL_R */, md: 10 /* OPM.IMPL_R */, w: 0 /* TXS.B */, sr: 1 /* REG.AL */, dr: 3 /* REG.BL */ },
            { n: 'XAXB', nm: 'MOV', ms: 10 /* OPM.IMPL_R */, md: 10 /* OPM.IMPL_R */, w: 0 /* TXS.B */, sr: 1 /* REG.AL */, dr: 5 /* REG.XL */ },
            { n: 'XAYB', nm: 'MOV', ms: 10 /* OPM.IMPL_R */, md: 10 /* OPM.IMPL_R */, w: 0 /* TXS.B */, sr: 1 /* REG.AL */, dr: 7 /* REG.YL */ },
            { n: 'XABB', nm: 'MOV', ms: 10 /* OPM.IMPL_R */, md: 10 /* OPM.IMPL_R */, w: 0 /* TXS.B */, sr: 1 /* REG.AL */, dr: 3 /* REG.BL */ },
            { n: 'XAZB', nm: 'MOV', ms: 10 /* OPM.IMPL_R */, md: 10 /* OPM.IMPL_R */, w: 0 /* TXS.B */, sr: 1 /* REG.AL */, dr: 9 /* REG.ZL */ },
            { n: 'XASB', nm: 'MOV', ms: 10 /* OPM.IMPL_R */, md: 10 /* OPM.IMPL_R */, w: 0 /* TXS.B */, sr: 1 /* REG.AL */, dr: 11 /* REG.SL */ },
            // 0x5H
            { n: 'ADD', md: 9 /* OPM.RRX */, w: 1 /* TXS.W */ }, { n: 'SUB', md: 9 /* OPM.RRX */, w: 1 /* TXS.W */ },
            { n: 'AND', md: 9 /* OPM.RRX */, w: 1 /* TXS.W */ }, { n: 'ORI', nm: 'OR', md: 9 /* OPM.RRX */, w: 1 /* TXS.W */ },
            { n: 'ORE', nm: 'XOR', md: 9 /* OPM.RRX */, w: 1 /* TXS.W */ }, { n: 'XFR', nm: 'MOV', md: 9 /* OPM.RRX */, w: 1 /* TXS.W */ },
            { n: 'EAO', md: 0 /* OPM.IMPL */ },
            { n: 'DAO', md: 0 /* OPM.IMPL */ },
            { n: 'AAB', nm: 'ADD', ms: 10 /* OPM.IMPL_R */, md: 10 /* OPM.IMPL_R */, w: 1 /* TXS.W */, sr: 0 /* REG.A */, dr: 2 /* REG.B */ },
            { n: 'SAB', nm: 'SUB', ms: 10 /* OPM.IMPL_R */, md: 10 /* OPM.IMPL_R */, w: 1 /* TXS.W */, sr: 0 /* REG.A */, dr: 2 /* REG.B */ },
            { n: 'NAB', nm: 'AND', ms: 10 /* OPM.IMPL_R */, md: 10 /* OPM.IMPL_R */, w: 1 /* TXS.W */, sr: 0 /* REG.A */, dr: 2 /* REG.B */ },
            { n: 'XAX', nm: 'MOV', ms: 10 /* OPM.IMPL_R */, md: 10 /* OPM.IMPL_R */, w: 1 /* TXS.W */, sr: 0 /* REG.A */, dr: 4 /* REG.X */ },
            { n: 'XAY', nm: 'MOV', ms: 10 /* OPM.IMPL_R */, md: 10 /* OPM.IMPL_R */, w: 1 /* TXS.W */, sr: 0 /* REG.A */, dr: 6 /* REG.Y */ },
            { n: 'XAB', nm: 'MOV', ms: 10 /* OPM.IMPL_R */, md: 10 /* OPM.IMPL_R */, w: 1 /* TXS.W */, sr: 0 /* REG.A */, dr: 2 /* REG.B */ },
            { n: 'XAZ', nm: 'MOV', ms: 10 /* OPM.IMPL_R */, md: 10 /* OPM.IMPL_R */, w: 1 /* TXS.W */, sr: 0 /* REG.A */, dr: 8 /* REG.Z */ },
            { n: 'XAS', nm: 'MOV', ms: 10 /* OPM.IMPL_R */, md: 10 /* OPM.IMPL_R */, w: 1 /* TXS.W */, sr: 0 /* REG.A */, dr: 10 /* REG.S */ },
            // 0x6H
            { n: 'LDX', nm: 'LD', ms: 1 /* OPM.IMM */, w: 1 /* TXS.W */, md: 10 /* OPM.IMPL_R */, dr: 4 /* REG.X */ },
            { n: 'LDX', nm: 'LD', ms: 2 /* OPM.DIR */, w: 1 /* TXS.W */, md: 10 /* OPM.IMPL_R */, dr: 4 /* REG.X */ },
            { n: 'LDX', nm: 'LD', ms: 3 /* OPM.IND */, w: 1 /* TXS.W */, md: 10 /* OPM.IMPL_R */, dr: 4 /* REG.X */ },
            { n: 'LDX', nm: 'LD', ms: 4 /* OPM.PCO */, w: 1 /* TXS.W */, md: 10 /* OPM.IMPL_R */, dr: 4 /* REG.X */ },
            { n: 'LDX', nm: 'LD', ms: 5 /* OPM.IPO */, w: 1 /* TXS.W */, md: 10 /* OPM.IMPL_R */, dr: 4 /* REG.X */ },
            { n: 'LDX', nm: 'LD', ms: 6 /* OPM.MOD */, w: 1 /* TXS.W */, md: 10 /* OPM.IMPL_R */, dr: 4 /* REG.X */ },
            { n: 'SVC', md: 0 /* OPM.IMPL */ },
            { n: 'mem', md: 0 /* OPM.IMPL */ },
            { n: 'STX', nm: 'ST', md: 1 /* OPM.IMM */, ms: 10 /* OPM.IMPL_R */, w: 1 /* TXS.W */, sr: 4 /* REG.X */ },
            { n: 'STX', nm: 'ST', md: 2 /* OPM.DIR */, ms: 10 /* OPM.IMPL_R */, w: 1 /* TXS.W */, sr: 4 /* REG.X */ },
            { n: 'STX', nm: 'ST', md: 3 /* OPM.IND */, ms: 10 /* OPM.IMPL_R */, w: 1 /* TXS.W */, sr: 4 /* REG.X */ },
            { n: 'STX', nm: 'ST', md: 4 /* OPM.PCO */, ms: 10 /* OPM.IMPL_R */, w: 1 /* TXS.W */, sr: 4 /* REG.X */ },
            { n: 'STX', nm: 'ST', md: 5 /* OPM.IPO */, ms: 10 /* OPM.IMPL_R */, w: 1 /* TXS.W */, sr: 4 /* REG.X */ },
            { n: 'STX', nm: 'ST', md: 6 /* OPM.MOD */, ms: 10 /* OPM.IMPL_R */, w: 1 /* TXS.W */, sr: 4 /* REG.X */ },
            { n: 'LST', md: 0 /* OPM.IMPL */ },
            { n: 'SST', md: 0 /* OPM.IMPL */ },
            // 0x7H
            { n: '!ill', md: 1 /* OPM.IMM */, w: 2 /* TXS.F */ }, { n: 'JMP', md: 2 /* OPM.DIR */, w: 2 /* TXS.F */ },
            { n: 'JMP', md: 3 /* OPM.IND */, w: 2 /* TXS.F */ }, { n: 'JMP', md: 4 /* OPM.PCO */, w: 2 /* TXS.F */ },
            { n: 'JMP', md: 5 /* OPM.IPO */, w: 2 /* TXS.F */ }, { n: 'JMP', md: 6 /* OPM.MOD */, w: 2 /* TXS.F */ },
            { n: 'EPE', md: 0 /* OPM.IMPL */ },
            { n: 'MUL', md: 9 /* OPM.RRX */, w: 2 /* TXS.F */ },
            { n: 'JSR', nm: 'CALL', md: 9 /* OPM.RRX */, w: 2 /* TXS.F */ }, { n: 'JSR', nm: 'CALL', md: 2 /* OPM.DIR */, w: 2 /* TXS.F */ },
            { n: 'JSR', nm: 'CALL', md: 3 /* OPM.IND */, w: 2 /* TXS.F */ }, { n: 'JSR', nm: 'CALL', md: 4 /* OPM.PCO */, w: 2 /* TXS.F */ },
            { n: 'JSR', nm: 'CALL', md: 5 /* OPM.IPO */, w: 2 /* TXS.F */ }, { n: 'JSR', nm: 'CALL', md: 6 /* OPM.MOD */, w: 2 /* TXS.F */ },
            { n: 'STK', md: 0 /* OPM.IMPL */, x: 0 /* OPL_EXT.MPUSH */ },
            { n: 'POP', md: 0 /* OPM.IMPL */, x: 1 /* OPL_EXT.MPOP */ },
            // 0x8H
            { n: 'LDAB', nm: 'LD', ms: 1 /* OPM.IMM */, md: 10 /* OPM.IMPL_R */, w: 0 /* TXS.B */, dr: 1 /* REG.AL */ },
            { n: 'LDAB', nm: 'LD', ms: 2 /* OPM.DIR */, md: 10 /* OPM.IMPL_R */, w: 0 /* TXS.B */, dr: 1 /* REG.AL */ },
            { n: 'LDAB', nm: 'LD', ms: 3 /* OPM.IND */, md: 10 /* OPM.IMPL_R */, w: 0 /* TXS.B */, dr: 1 /* REG.AL */ },
            { n: 'LDAB', nm: 'LD', ms: 4 /* OPM.PCO */, md: 10 /* OPM.IMPL_R */, w: 0 /* TXS.B */, dr: 1 /* REG.AL */ },
            { n: 'LDAB', nm: 'LD', ms: 5 /* OPM.IPO */, md: 10 /* OPM.IMPL_R */, w: 0 /* TXS.B */, dr: 1 /* REG.AL */ },
            { n: 'LDAB', nm: 'LD', ms: 6 /* OPM.MOD */, md: 10 /* OPM.IMPL_R */, w: 0 /* TXS.B */, dr: 1 /* REG.AL */ },
            { n: 'DPE', md: 0 /* OPM.IMPL */ },
            { n: '!ill87', md: 0 /* OPM.IMPL */ },
            { n: 'LAAB', nm: 'LD', ms: 11 /* OPM.IMPL_R_DIR */, md: 10 /* OPM.IMPL_R */, w: 0 /* TXS.B */, sr: 0 /* REG.A */, dr: 1 /* REG.AL */ },
            { n: 'LABB', nm: 'LD', ms: 11 /* OPM.IMPL_R_DIR */, md: 10 /* OPM.IMPL_R */, w: 0 /* TXS.B */, sr: 2 /* REG.B */, dr: 1 /* REG.AL */ },
            { n: 'LAXB', nm: 'LD', ms: 11 /* OPM.IMPL_R_DIR */, md: 10 /* OPM.IMPL_R */, w: 0 /* TXS.B */, sr: 4 /* REG.X */, dr: 1 /* REG.AL */ },
            { n: 'LAYB', nm: 'LD', ms: 11 /* OPM.IMPL_R_DIR */, md: 10 /* OPM.IMPL_R */, w: 0 /* TXS.B */, sr: 6 /* REG.Y */, dr: 1 /* REG.AL */ },
            { n: 'LAZB', nm: 'LD', ms: 11 /* OPM.IMPL_R_DIR */, md: 10 /* OPM.IMPL_R */, w: 0 /* TXS.B */, sr: 8 /* REG.Z */, dr: 1 /* REG.AL */ },
            { n: 'LASB', nm: 'LD', ms: 11 /* OPM.IMPL_R_DIR */, md: 10 /* OPM.IMPL_R */, w: 0 /* TXS.B */, sr: 10 /* REG.S */, dr: 1 /* REG.AL */ },
            { n: 'LACB', nm: 'LD', ms: 11 /* OPM.IMPL_R_DIR */, md: 10 /* OPM.IMPL_R */, w: 0 /* TXS.B */, sr: 12 /* REG.C */, dr: 1 /* REG.AL */ },
            { n: 'LAPB', nm: 'LD', ms: 11 /* OPM.IMPL_R_DIR */, md: 10 /* OPM.IMPL_R */, w: 0 /* TXS.B */, sr: 14 /* REG.PC */, dr: 1 /* REG.AL */ },
            // 0x9H
            { n: 'LDA', nm: 'LD', ms: 1 /* OPM.IMM */, md: 10 /* OPM.IMPL_R */, w: 1 /* TXS.W */, dr: 0 /* REG.A */ },
            { n: 'LDA', nm: 'LD', ms: 2 /* OPM.DIR */, md: 10 /* OPM.IMPL_R */, w: 1 /* TXS.W */, dr: 0 /* REG.A */ },
            { n: 'LDA', nm: 'LD', ms: 3 /* OPM.IND */, md: 10 /* OPM.IMPL_R */, w: 1 /* TXS.W */, dr: 0 /* REG.A */ },
            { n: 'LDA', nm: 'LD', ms: 4 /* OPM.PCO */, md: 10 /* OPM.IMPL_R */, w: 1 /* TXS.W */, dr: 0 /* REG.A */ },
            { n: 'LDA', nm: 'LD', ms: 5 /* OPM.IPO */, md: 10 /* OPM.IMPL_R */, w: 1 /* TXS.W */, dr: 0 /* REG.A */ },
            { n: 'LDA', nm: 'LD', ms: 6 /* OPM.MOD */, md: 10 /* OPM.IMPL_R */, w: 1 /* TXS.W */, dr: 0 /* REG.A */ },
            { n: 'SOP', md: 0 /* OPM.IMPL */ },
            { n: '!ill97', md: 0 /* OPM.IMPL */ },
            { n: 'LAA', nm: 'LD', ms: 11 /* OPM.IMPL_R_DIR */, md: 10 /* OPM.IMPL_R */, w: 1 /* TXS.W */, sr: 0 /* REG.A */, dr: 0 /* REG.A */ },
            { n: 'LAB', nm: 'LD', ms: 11 /* OPM.IMPL_R_DIR */, md: 10 /* OPM.IMPL_R */, w: 1 /* TXS.W */, sr: 2 /* REG.B */, dr: 0 /* REG.A */ },
            { n: 'LAX', nm: 'LD', ms: 11 /* OPM.IMPL_R_DIR */, md: 10 /* OPM.IMPL_R */, w: 1 /* TXS.W */, sr: 4 /* REG.X */, dr: 0 /* REG.A */ },
            { n: 'LAY', nm: 'LD', ms: 11 /* OPM.IMPL_R_DIR */, md: 10 /* OPM.IMPL_R */, w: 1 /* TXS.W */, sr: 6 /* REG.Y */, dr: 0 /* REG.A */ },
            { n: 'LAZ', nm: 'LD', ms: 11 /* OPM.IMPL_R_DIR */, md: 10 /* OPM.IMPL_R */, w: 1 /* TXS.W */, sr: 8 /* REG.Z */, dr: 0 /* REG.A */ },
            { n: 'LAS', nm: 'LD', ms: 11 /* OPM.IMPL_R_DIR */, md: 10 /* OPM.IMPL_R */, w: 1 /* TXS.W */, sr: 10 /* REG.S */, dr: 0 /* REG.A */ },
            { n: 'LAC', nm: 'LD', ms: 11 /* OPM.IMPL_R_DIR */, md: 10 /* OPM.IMPL_R */, w: 1 /* TXS.W */, sr: 12 /* REG.C */, dr: 0 /* REG.A */ },
            { n: 'LAP', nm: 'LD', ms: 11 /* OPM.IMPL_R_DIR */, md: 10 /* OPM.IMPL_R */, w: 1 /* TXS.W */, sr: 14 /* REG.PC */, dr: 0 /* REG.A */ },
            // 0xAH
            { n: 'STAB', nm: 'ST', ms: 10 /* OPM.IMPL_R */, md: 1 /* OPM.IMM */, w: 0 /* TXS.B */, sr: 1 /* REG.AL */ },
            { n: 'STAB', nm: 'ST', ms: 10 /* OPM.IMPL_R */, md: 2 /* OPM.DIR */, w: 0 /* TXS.B */, sr: 1 /* REG.AL */ },
            { n: 'STAB', nm: 'ST', ms: 10 /* OPM.IMPL_R */, md: 3 /* OPM.IND */, w: 0 /* TXS.B */, sr: 1 /* REG.AL */ },
            { n: 'STAB', nm: 'ST', ms: 10 /* OPM.IMPL_R */, md: 4 /* OPM.PCO */, w: 0 /* TXS.B */, sr: 1 /* REG.AL */ },
            { n: 'STAB', nm: 'ST', ms: 10 /* OPM.IMPL_R */, md: 5 /* OPM.IPO */, w: 0 /* TXS.B */, sr: 1 /* REG.AL */ },
            { n: 'STAB', nm: 'ST', ms: 10 /* OPM.IMPL_R */, md: 6 /* OPM.MOD */, w: 0 /* TXS.B */, sr: 1 /* REG.AL */ },
            { n: 'SEP', md: 0 /* OPM.IMPL */ },
            { n: '!illA7', md: 0 /* OPM.IMPL */ },
            { n: 'SAAB', nm: 'ST', ms: 10 /* OPM.IMPL_R */, md: 11 /* OPM.IMPL_R_DIR */, w: 0 /* TXS.B */, sr: 1 /* REG.AL */, dr: 0 /* REG.A */ },
            { n: 'SABB', nm: 'ST', ms: 10 /* OPM.IMPL_R */, md: 11 /* OPM.IMPL_R_DIR */, w: 0 /* TXS.B */, sr: 1 /* REG.AL */, dr: 2 /* REG.B */ },
            { n: 'SAXB', nm: 'ST', ms: 10 /* OPM.IMPL_R */, md: 11 /* OPM.IMPL_R_DIR */, w: 0 /* TXS.B */, sr: 1 /* REG.AL */, dr: 4 /* REG.X */ },
            { n: 'SAYB', nm: 'ST', ms: 10 /* OPM.IMPL_R */, md: 11 /* OPM.IMPL_R_DIR */, w: 0 /* TXS.B */, sr: 1 /* REG.AL */, dr: 6 /* REG.Y */ },
            { n: 'SAZB', nm: 'ST', ms: 10 /* OPM.IMPL_R */, md: 11 /* OPM.IMPL_R_DIR */, w: 0 /* TXS.B */, sr: 1 /* REG.AL */, dr: 8 /* REG.Z */ },
            { n: 'SASB', nm: 'ST', ms: 10 /* OPM.IMPL_R */, md: 11 /* OPM.IMPL_R_DIR */, w: 0 /* TXS.B */, sr: 1 /* REG.AL */, dr: 10 /* REG.S */ },
            { n: 'SACB', nm: 'ST', ms: 10 /* OPM.IMPL_R */, md: 11 /* OPM.IMPL_R_DIR */, w: 0 /* TXS.B */, sr: 1 /* REG.AL */, dr: 12 /* REG.C */ },
            { n: 'SAPB', nm: 'ST', ms: 10 /* OPM.IMPL_R */, md: 11 /* OPM.IMPL_R_DIR */, w: 0 /* TXS.B */, sr: 1 /* REG.AL */, dr: 14 /* REG.PC */ },
            // 0xBH
            { n: 'STA', nm: 'ST', ms: 10 /* OPM.IMPL_R */, md: 1 /* OPM.IMM */, w: 1 /* TXS.W */, sr: 0 /* REG.A */ },
            { n: 'STA', nm: 'ST', ms: 10 /* OPM.IMPL_R */, md: 2 /* OPM.DIR */, w: 1 /* TXS.W */, sr: 0 /* REG.A */ },
            { n: 'STA', nm: 'ST', ms: 10 /* OPM.IMPL_R */, md: 3 /* OPM.IND */, w: 1 /* TXS.W */, sr: 0 /* REG.A */ },
            { n: 'STA', nm: 'ST', ms: 10 /* OPM.IMPL_R */, md: 4 /* OPM.PCO */, w: 1 /* TXS.W */, sr: 0 /* REG.A */ },
            { n: 'STA', nm: 'ST', ms: 10 /* OPM.IMPL_R */, md: 5 /* OPM.IPO */, w: 1 /* TXS.W */, sr: 0 /* REG.A */ },
            { n: 'STA', nm: 'ST', ms: 10 /* OPM.IMPL_R */, md: 6 /* OPM.MOD */, w: 1 /* TXS.W */, sr: 0 /* REG.A */ },
            { n: 'ECK', md: 0 /* OPM.IMPL */ },
            { n: '!illB7', md: 0 /* OPM.IMPL */ },
            { n: 'SAA', nm: 'ST', ms: 10 /* OPM.IMPL_R */, md: 11 /* OPM.IMPL_R_DIR */, w: 1 /* TXS.W */, sr: 0 /* REG.A */, dr: 0 /* REG.A */ },
            { n: 'SAB', nm: 'ST', ms: 10 /* OPM.IMPL_R */, md: 11 /* OPM.IMPL_R_DIR */, w: 1 /* TXS.W */, sr: 0 /* REG.A */, dr: 2 /* REG.B */ },
            { n: 'SAX', nm: 'ST', ms: 10 /* OPM.IMPL_R */, md: 11 /* OPM.IMPL_R_DIR */, w: 1 /* TXS.W */, sr: 0 /* REG.A */, dr: 4 /* REG.X */ },
            { n: 'SAY', nm: 'ST', ms: 10 /* OPM.IMPL_R */, md: 11 /* OPM.IMPL_R_DIR */, w: 1 /* TXS.W */, sr: 0 /* REG.A */, dr: 6 /* REG.Y */ },
            { n: 'SAZ', nm: 'ST', ms: 10 /* OPM.IMPL_R */, md: 11 /* OPM.IMPL_R_DIR */, w: 1 /* TXS.W */, sr: 0 /* REG.A */, dr: 8 /* REG.Z */ },
            { n: 'SAS', nm: 'ST', ms: 10 /* OPM.IMPL_R */, md: 11 /* OPM.IMPL_R_DIR */, w: 1 /* TXS.W */, sr: 0 /* REG.A */, dr: 10 /* REG.S */ },
            { n: 'SAC', nm: 'ST', ms: 10 /* OPM.IMPL_R */, md: 11 /* OPM.IMPL_R_DIR */, w: 1 /* TXS.W */, sr: 0 /* REG.A */, dr: 12 /* REG.C */ },
            { n: 'SAP', nm: 'ST', ms: 10 /* OPM.IMPL_R */, md: 11 /* OPM.IMPL_R_DIR */, w: 1 /* TXS.W */, sr: 0 /* REG.A */, dr: 14 /* REG.PC */ },
            // 0xCH
            { n: 'LDBB', nm: 'LD', ms: 1 /* OPM.IMM */, md: 10 /* OPM.IMPL_R */, w: 0 /* TXS.B */, dr: 3 /* REG.BL */ },
            { n: 'LDBB', nm: 'LD', ms: 2 /* OPM.DIR */, md: 10 /* OPM.IMPL_R */, w: 0 /* TXS.B */, dr: 3 /* REG.BL */ },
            { n: 'LDBB', nm: 'LD', ms: 3 /* OPM.IND */, md: 10 /* OPM.IMPL_R */, w: 0 /* TXS.B */, dr: 3 /* REG.BL */ },
            { n: 'LDBB', nm: 'LD', ms: 4 /* OPM.PCO */, md: 10 /* OPM.IMPL_R */, w: 0 /* TXS.B */, dr: 3 /* REG.BL */ },
            { n: 'LDBB', nm: 'LD', ms: 5 /* OPM.IPO */, md: 10 /* OPM.IMPL_R */, w: 0 /* TXS.B */, dr: 3 /* REG.BL */ },
            { n: 'LDBB', nm: 'LD', ms: 6 /* OPM.MOD */, md: 10 /* OPM.IMPL_R */, w: 0 /* TXS.B */, dr: 3 /* REG.BL */ },
            { n: 'DCK', md: 0 /* OPM.IMPL */ },
            { n: '!illC7', md: 0 /* OPM.IMPL */ },
            { n: 'LBAB', nm: 'LD', ms: 11 /* OPM.IMPL_R_DIR */, md: 10 /* OPM.IMPL_R */, w: 0 /* TXS.B */, sr: 0 /* REG.A */, dr: 3 /* REG.BL */ },
            { n: 'LBBB', nm: 'LD', ms: 11 /* OPM.IMPL_R_DIR */, md: 10 /* OPM.IMPL_R */, w: 0 /* TXS.B */, sr: 2 /* REG.B */, dr: 3 /* REG.BL */ },
            { n: 'LBXB', nm: 'LD', ms: 11 /* OPM.IMPL_R_DIR */, md: 10 /* OPM.IMPL_R */, w: 0 /* TXS.B */, sr: 4 /* REG.X */, dr: 3 /* REG.BL */ },
            { n: 'LBYB', nm: 'LD', ms: 11 /* OPM.IMPL_R_DIR */, md: 10 /* OPM.IMPL_R */, w: 0 /* TXS.B */, sr: 6 /* REG.Y */, dr: 3 /* REG.BL */ },
            { n: 'LBZB', nm: 'LD', ms: 11 /* OPM.IMPL_R_DIR */, md: 10 /* OPM.IMPL_R */, w: 0 /* TXS.B */, sr: 8 /* REG.Z */, dr: 3 /* REG.BL */ },
            { n: 'LBSB', nm: 'LD', ms: 11 /* OPM.IMPL_R_DIR */, md: 10 /* OPM.IMPL_R */, w: 0 /* TXS.B */, sr: 10 /* REG.S */, dr: 3 /* REG.BL */ },
            { n: 'LBCB', nm: 'LD', ms: 11 /* OPM.IMPL_R_DIR */, md: 10 /* OPM.IMPL_R */, w: 0 /* TXS.B */, sr: 12 /* REG.C */, dr: 3 /* REG.BL */ },
            { n: 'LBPB', nm: 'LD', ms: 11 /* OPM.IMPL_R_DIR */, md: 10 /* OPM.IMPL_R */, w: 0 /* TXS.B */, sr: 14 /* REG.PC */, dr: 3 /* REG.BL */ },
            // 0xDH
            { n: 'LDB', nm: 'LD', ms: 1 /* OPM.IMM */, md: 10 /* OPM.IMPL_R */, w: 1 /* TXS.W */, dr: 2 /* REG.B */ },
            { n: 'LDB', nm: 'LD', ms: 2 /* OPM.DIR */, md: 10 /* OPM.IMPL_R */, w: 1 /* TXS.W */, dr: 2 /* REG.B */ },
            { n: 'LDB', nm: 'LD', ms: 3 /* OPM.IND */, md: 10 /* OPM.IMPL_R */, w: 1 /* TXS.W */, dr: 2 /* REG.B */ },
            { n: 'LDB', nm: 'LD', ms: 4 /* OPM.PCO */, md: 10 /* OPM.IMPL_R */, w: 1 /* TXS.W */, dr: 2 /* REG.B */ },
            { n: 'LDB', nm: 'LD', ms: 5 /* OPM.IPO */, md: 10 /* OPM.IMPL_R */, w: 1 /* TXS.W */, dr: 2 /* REG.B */ },
            { n: 'LDB', nm: 'LD', ms: 6 /* OPM.MOD */, md: 10 /* OPM.IMPL_R */, w: 1 /* TXS.W */, dr: 2 /* REG.B */ },
            { n: 'STR', md: 0 /* OPM.IMPL */ },
            { n: 'SAR', md: 0 /* OPM.IMPL */ },
            { n: 'LBA', nm: 'LD', ms: 11 /* OPM.IMPL_R_DIR */, md: 10 /* OPM.IMPL_R */, w: 1 /* TXS.W */, sr: 0 /* REG.A */, dr: 2 /* REG.B */ },
            { n: 'LBB', nm: 'LD', ms: 11 /* OPM.IMPL_R_DIR */, md: 10 /* OPM.IMPL_R */, w: 1 /* TXS.W */, sr: 2 /* REG.B */, dr: 2 /* REG.B */ },
            { n: 'LBX', nm: 'LD', ms: 11 /* OPM.IMPL_R_DIR */, md: 10 /* OPM.IMPL_R */, w: 1 /* TXS.W */, sr: 4 /* REG.X */, dr: 2 /* REG.B */ },
            { n: 'LBY', nm: 'LD', ms: 11 /* OPM.IMPL_R_DIR */, md: 10 /* OPM.IMPL_R */, w: 1 /* TXS.W */, sr: 6 /* REG.Y */, dr: 2 /* REG.B */ },
            { n: 'LBZ', nm: 'LD', ms: 11 /* OPM.IMPL_R_DIR */, md: 10 /* OPM.IMPL_R */, w: 1 /* TXS.W */, sr: 8 /* REG.Z */, dr: 2 /* REG.B */ },
            { n: 'LBS', nm: 'LD', ms: 11 /* OPM.IMPL_R_DIR */, md: 10 /* OPM.IMPL_R */, w: 1 /* TXS.W */, sr: 10 /* REG.S */, dr: 2 /* REG.B */ },
            { n: 'LBC', nm: 'LD', ms: 11 /* OPM.IMPL_R_DIR */, md: 10 /* OPM.IMPL_R */, w: 1 /* TXS.W */, sr: 12 /* REG.C */, dr: 2 /* REG.B */ },
            { n: 'LBP', nm: 'LD', ms: 11 /* OPM.IMPL_R_DIR */, md: 10 /* OPM.IMPL_R */, w: 1 /* TXS.W */, sr: 14 /* REG.PC */, dr: 2 /* REG.B */ },
            // 0xEH
            { n: 'STBB', nm: 'ST', ms: 10 /* OPM.IMPL_R */, md: 1 /* OPM.IMM */, w: 0 /* TXS.B */, sr: 3 /* REG.BL */ },
            { n: 'STBB', nm: 'ST', ms: 10 /* OPM.IMPL_R */, md: 2 /* OPM.DIR */, w: 0 /* TXS.B */, sr: 3 /* REG.BL */ },
            { n: 'STBB', nm: 'ST', ms: 10 /* OPM.IMPL_R */, md: 3 /* OPM.IND */, w: 0 /* TXS.B */, sr: 3 /* REG.BL */ },
            { n: 'STBB', nm: 'ST', ms: 10 /* OPM.IMPL_R */, md: 4 /* OPM.PCO */, w: 0 /* TXS.B */, sr: 3 /* REG.BL */ },
            { n: 'STBB', nm: 'ST', ms: 10 /* OPM.IMPL_R */, md: 5 /* OPM.IPO */, w: 0 /* TXS.B */, sr: 3 /* REG.BL */ },
            { n: 'STBB', nm: 'ST', ms: 10 /* OPM.IMPL_R */, md: 6 /* OPM.MOD */, w: 0 /* TXS.B */, sr: 3 /* REG.BL */ },
            { n: 'LAR', md: 0 /* OPM.IMPL */ },
            { n: '!illE7', md: 0 /* OPM.IMPL */ },
            { n: 'SBAB', nm: 'ST', ms: 10 /* OPM.IMPL_R */, md: 11 /* OPM.IMPL_R_DIR */, w: 0 /* TXS.B */, sr: 3 /* REG.BL */, dr: 0 /* REG.A */ },
            { n: 'SBBB', nm: 'ST', ms: 10 /* OPM.IMPL_R */, md: 11 /* OPM.IMPL_R_DIR */, w: 0 /* TXS.B */, sr: 3 /* REG.BL */, dr: 2 /* REG.B */ },
            { n: 'SBXB', nm: 'ST', ms: 10 /* OPM.IMPL_R */, md: 11 /* OPM.IMPL_R_DIR */, w: 0 /* TXS.B */, sr: 3 /* REG.BL */, dr: 4 /* REG.X */ },
            { n: 'SBYB', nm: 'ST', ms: 10 /* OPM.IMPL_R */, md: 11 /* OPM.IMPL_R_DIR */, w: 0 /* TXS.B */, sr: 3 /* REG.BL */, dr: 6 /* REG.Y */ },
            { n: 'SBZB', nm: 'ST', ms: 10 /* OPM.IMPL_R */, md: 11 /* OPM.IMPL_R_DIR */, w: 0 /* TXS.B */, sr: 3 /* REG.BL */, dr: 8 /* REG.Z */ },
            { n: 'SBSB', nm: 'ST', ms: 10 /* OPM.IMPL_R */, md: 11 /* OPM.IMPL_R_DIR */, w: 0 /* TXS.B */, sr: 3 /* REG.BL */, dr: 10 /* REG.S */ },
            { n: 'SBCB', nm: 'ST', ms: 10 /* OPM.IMPL_R */, md: 11 /* OPM.IMPL_R_DIR */, w: 0 /* TXS.B */, sr: 3 /* REG.BL */, dr: 12 /* REG.C */ },
            { n: 'SBPB', nm: 'ST', ms: 10 /* OPM.IMPL_R */, md: 11 /* OPM.IMPL_R_DIR */, w: 0 /* TXS.B */, sr: 3 /* REG.BL */, dr: 14 /* REG.PC */ },
            // 0xFH
            { n: 'STB', nm: 'ST', ms: 10 /* OPM.IMPL_R */, md: 1 /* OPM.IMM */, w: 1 /* TXS.W */, sr: 2 /* REG.B */ },
            { n: 'STB', nm: 'ST', ms: 10 /* OPM.IMPL_R */, md: 2 /* OPM.DIR */, w: 1 /* TXS.W */, sr: 2 /* REG.B */ },
            { n: 'STB', nm: 'ST', ms: 10 /* OPM.IMPL_R */, md: 3 /* OPM.IND */, w: 1 /* TXS.W */, sr: 2 /* REG.B */ },
            { n: 'STB', nm: 'ST', ms: 10 /* OPM.IMPL_R */, md: 4 /* OPM.PCO */, w: 1 /* TXS.W */, sr: 2 /* REG.B */ },
            { n: 'STB', nm: 'ST', ms: 10 /* OPM.IMPL_R */, md: 5 /* OPM.IPO */, w: 1 /* TXS.W */, sr: 2 /* REG.B */ },
            { n: 'STB', nm: 'ST', ms: 10 /* OPM.IMPL_R */, md: 6 /* OPM.MOD */, w: 1 /* TXS.W */, sr: 2 /* REG.B */ },
            { n: 'LIO/SIO', md: 0 /* OPM.IMPL */, l: 3 },
            { n: 'MVL', md: 0 /* OPM.IMPL */ },
            { n: 'SBA', nm: 'ST', ms: 10 /* OPM.IMPL_R */, md: 11 /* OPM.IMPL_R_DIR */, w: 1 /* TXS.W */, sr: 2 /* REG.B */, dr: 0 /* REG.A */ },
            { n: 'SBB', nm: 'ST', ms: 10 /* OPM.IMPL_R */, md: 11 /* OPM.IMPL_R_DIR */, w: 1 /* TXS.W */, sr: 2 /* REG.B */, dr: 2 /* REG.B */ },
            { n: 'SBX', nm: 'ST', ms: 10 /* OPM.IMPL_R */, md: 11 /* OPM.IMPL_R_DIR */, w: 1 /* TXS.W */, sr: 2 /* REG.B */, dr: 4 /* REG.X */ },
            { n: 'SBY', nm: 'ST', ms: 10 /* OPM.IMPL_R */, md: 11 /* OPM.IMPL_R_DIR */, w: 1 /* TXS.W */, sr: 2 /* REG.B */, dr: 6 /* REG.Y */ },
            { n: 'SBZ', nm: 'ST', ms: 10 /* OPM.IMPL_R */, md: 11 /* OPM.IMPL_R_DIR */, w: 1 /* TXS.W */, sr: 2 /* REG.B */, dr: 8 /* REG.Z */ },
            { n: 'SBS', nm: 'ST', ms: 10 /* OPM.IMPL_R */, md: 11 /* OPM.IMPL_R_DIR */, w: 1 /* TXS.W */, sr: 2 /* REG.B */, dr: 10 /* REG.S */ },
            { n: 'SBC', nm: 'ST', ms: 10 /* OPM.IMPL_R */, md: 11 /* OPM.IMPL_R_DIR */, w: 1 /* TXS.W */, sr: 2 /* REG.B */, dr: 12 /* REG.C */ },
            { n: 'SBP', nm: 'ST', ms: 10 /* OPM.IMPL_R */, md: 11 /* OPM.IMPL_R_DIR */, w: 1 /* TXS.W */, sr: 2 /* REG.B */, dr: 14 /* REG.PC */ },
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
                            parse.data = 'pstringhi';
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
            constructor(m) {
                // backing buffers
                this.register_buffer = new ArrayBuffer(256);
                this.page_buffer = new ArrayBuffer(256);
                // the system registers in various interrupt levels
                this.register_file = new DataView(this.register_buffer);
                // memory management
                this.page_file = new DataView(this.page_buffer);
                // global registers
                this.reg_s = 0;
                this.reg_p = 0x100;
                this.reg_c = 0; // context
                this.mem = m;
            }
            // load an instruction byte from the memory sub-system
            // TODO address routing, MMIO
            fetch(addr) {
                return this.mem.readbyte(addr);
            }
            disassembly(address) {
                const DREF_L = NAME_CONV == 1 ? '[' : '(';
                const DREF_R = NAME_CONV == 1 ? ']' : ')';
                const DDREF_L = DREF_L + DREF_L;
                const DDREF_R = DREF_R + DREF_R;
                let vpc = address;
                if (this.mem.is_mmio(vpc)) {
                    return { t: '??', l: 1 };
                }
                let op = this.fetch(vpc++);
                let dstr = '';
                let opcs = oplist[op];
                let anpre = '';
                let anstr = '';
                let opname = opcs.n;
                let anno_data = '';
                dstr += `${hex(op)}`;
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
                    let vasc = v & 0x7f;
                    let rcp;
                    if (vasc > 0x20 && vasc < 0x7f) {
                        rcp = String.fromCodePoint(vasc);
                    }
                    else if (vasc == 32) {
                        rcp = NB;
                    }
                    else if (vasc == 9) {
                        rcp = "\u2192";
                    }
                    else if (vasc == 10) {
                        rcp = "\u2193";
                    }
                    else if (vasc == 12) {
                        rcp = "\u21ca";
                    }
                    else if (vasc == 13) {
                        rcp = "\u21b5";
                    }
                    else {
                        rcp = "\u2588";
                    }
                    return rcp;
                }
                function addrrefw(a) {
                    if (mmwlist.has(a)) {
                        return `${hexlist(a, 4)} &lt;${mmwlist.get(a)}>`;
                    }
                    else {
                        let anno = annotation_data.get(a);
                        if (anno && anno.label && anno.label.length > 0) {
                            return `${hexlist(a, 4)} &lt;${anno.label[0]}>`;
                        }
                        return hexlist(a, 4);
                    }
                }
                function addrref(a) {
                    a &= 0xffff;
                    if (mmiolist.has(a)) {
                        return `${hexlist(a, 4)} &lt;${mmiolist.get(a)}>`;
                    }
                    else {
                        let anno = annotation_data.get(a);
                        if (anno && anno.label && anno.label.length > 0) {
                            return `${hexlist(a, 4)} &lt;${anno.label[0]}>`;
                        }
                        return hexlist(a, 4);
                    }
                }
                let astr = ascenc(op);
                let dfetch = () => {
                    check_anno(vpc);
                    let rv = this.fetch(vpc++);
                    dstr += ` ${hex(rv)}`;
                    astr += ascenc(rv);
                    return rv;
                };
                let psstr = '';
                let pstr = '';
                check_anno(address);
                if (anno_data == 'byte') {
                    dstr = `${dstr.padEnd(12, NB)}${astr.padEnd(4, NB)} .byte ${hexlist(op, 2)}`;
                    const ret = { t: dstr, l: vpc - address };
                    if (anpre.length > 0)
                        ret.pre = anpre;
                    if (anstr.length > 0)
                        ret.post = anstr;
                    return ret;
                }
                else if (anno_data == 'word') {
                    let vl = dfetch();
                    dstr = `${dstr.padEnd(12, NB)}${astr.padEnd(4, NB)} .word ${hexlist((op << 8) | vl, 4)}`;
                    const ret = { t: dstr, l: vpc - address };
                    if (anpre.length > 0)
                        ret.pre = anpre;
                    if (anstr.length > 0)
                        ret.post = anstr;
                    return ret;
                }
                let vstr = '';
                if (op == 0 && this.fetch(vpc) > 3) { // TODO does not cover long strings!
                    let vstart = vpc + 1;
                    let vpcs = vstart;
                    let pre = this.fetch(vpc);
                    //check_anno(vpc);
                    //check_anno(vpcs);
                    let f = this.fetch(vpcs++);
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
                            const ret = { t: `<span class="pstr">.npstringhi "${vstr}"</span>`, l: vpcs - address };
                            if (anpre.length > 0) {
                                ret.pre = anpre;
                            }
                            if (anstr.length > 0) {
                                ret.post = anstr;
                            }
                            return ret;
                        }
                        //check_anno(vpcs);
                        f = this.fetch(vpcs++);
                    }
                    slen = (vpcs - vpc);
                    if (pre == slen && slen >= 2 && nonspace) {
                        // pascal string
                        vpcs--;
                        const ret = { t: `<span class="pstr">.npstringhi "${vstr}"</span>`, l: vpcs - address };
                        if (anpre.length > 0) {
                            ret.pre = anpre;
                        }
                        if (anstr.length > 0) {
                            ret.post = anstr;
                        }
                        return ret;
                    }
                    if (!nonspace) {
                        vstr = '';
                    }
                }
                else if (is_hiascii(op)) {
                    let vpcs = vpc - 1;
                    let pre = (this.fetch(vpc - 3) << 8) | this.fetch(vpc - 2);
                    let f = this.fetch(vpcs++);
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
                            const ret = { t: `<span class="pstr">.pstringhi "${vstr}"</span>`, l: vpcs - address };
                            if (anpre.length > 0) {
                                ret.pre = anpre;
                            }
                            if (anstr.length > 0) {
                                ret.post = anstr;
                            }
                            return ret;
                        }
                        //check_anno(vpcs);
                        f = this.fetch(vpcs++);
                    }
                    slen = (vpcs - vpc);
                    if (pre == slen && slen >= 2 && nonspace) {
                        // pascal string
                        vpcs--;
                        const ret = { t: `<span class="pstr">.pstringhi "${vstr}"</span>`, l: vpcs - address };
                        if (anpre.length > 0) {
                            ret.pre = anpre;
                        }
                        if (anstr.length > 0) {
                            ret.post = anstr;
                        }
                        return ret;
                    }
                    else if (f == 0 && slen > 3 && nonspace) {
                        // zstring/cstring
                        const ret = { t: `<span class="zstr">.zstringhi "${vstr}"</span>`, l: vpcs - address };
                        if (anpre.length > 0) {
                            ret.pre = anpre;
                        }
                        if (anstr.length > 0) {
                            ret.post = anstr;
                        }
                        return ret;
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
                            return (is_write ? '>#' : '#') + '&lt;invalid&gt;';
                        case 2 /* OPM.DIR */:
                            advh = dfetch();
                            advl = dfetch();
                            adr = (advh << 8) | advl;
                            switch (opcs.w) {
                                case 2 /* TXS.F */: return `:${addrref(adr)}`;
                                case 0 /* TXS.B */: return `${DREF_L}${addrref(adr)}${DREF_R}`;
                                case 1 /* TXS.W */: return `${DREF_L}${addrrefw(adr)}${DREF_R}`;
                            }
                            return '#&lt;invalid&gt;';
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
                                return 'PC' + (disp < 0 ? '' : '+') + hexlist(disp) + ' \u21d2 ' + addrrefw(vpc + disp);
                            }
                            else if (opcs.w == 1 /* TXS.W */) {
                                return DREF_L + 'PC' + (disp < 0 ? '' : '+') + hexlist(disp) + ' \u21d2 ' + addrrefw(vpc + disp) + DREF_R;
                            }
                            return DREF_L + 'PC' + (disp < 0 ? '' : '+') + hexlist(disp) + ' \u21d2 ' + addrref(vpc + disp) + DREF_R;
                        case 5 /* OPM.IPO */:
                            disp = sbyte(dfetch());
                            if (opcs.w == 2 /* TXS.F */) {
                                return 'PC' + (disp < 0 ? '' : '+') + hexlist(disp) + ' \u21d2 ' + DREF_L + addrrefw(vpc + disp) + DREF_R;
                            }
                            else if (opcs.w == 1 /* TXS.W */) {
                                return DREF_L + ' PC' + (disp < 0 ? '' : '+') + hexlist(disp) + ' \u21d2 ' + DREF_L + addrrefw(vpc + disp) + DREF_R + ' ' + DREF_R;
                            }
                            return DREF_L + ' PC' + (disp < 0 ? '' : '+') + hexlist(disp) + ' \u21d2 ' + DREF_L + addrref(vpc + disp) + DREF_R + ' ' + DREF_R;
                        case 6 /* OPM.MOD */:
                            rvc = dfetch();
                            let modv = rvc & 15;
                            disp = 0;
                            if ((modv & 8) > 0) {
                                disp = sbyte(dfetch());
                            }
                            let res = regname[16 + (rvc >> 4)];
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
                        case 7 /* OPM.RR */:
                        case 9 /* OPM.RRX */:
                        case 8 /* OPM.RC */:
                            if (!is_write)
                                throw new Error('RR/RC in source operand, should be in dest');
                            rvc = dfetch();
                            let regdst = (rvc >> 4);
                            let regsrc = (rvc & 15);
                            let rrxmode = ((regdst & 1) << 1) | (regsrc & 1);
                            if (opcs.md == 9 /* OPM.RRX */ && rrxmode > 0) {
                                // nibbles mismatch
                                advh = dfetch();
                                advl = dfetch();
                                adr = (advh << 8) | advl;
                                if (rrxmode == 1) {
                                    // MSN even
                                    return regname[rsh + regdst] + `:&lt;${regname[rsh + regsrc]}> + ${DREF_L}${addrref(adr)}${DREF_R}`;
                                }
                                else if (rrxmode == 2) {
                                    // MSN odd
                                    return regname[rsh + regdst] + `:&lt;${regname[rsh + regsrc]}> + ${hexlist(adr, 4)}`;
                                }
                                else {
                                    return regname[rsh + regdst] + `:${DREF_L}&lt;${regname[rsh + regsrc]}> + ${addrref(adr)}${DREF_R}`;
                                }
                            }
                            else if (opcs.md == 7 /* OPM.RR */ || opcs.md == 9 /* OPM.RRX */) {
                                return regname[rsh + regdst] + ',' + regname[rsh + regsrc];
                            }
                            else if (opcs.i != undefined) {
                                return regname[rsh + regdst] + ',' + hexlist(regsrc + opcs.i, 1);
                            }
                            else {
                                return regname[rsh + regdst] + ',' + hexlist(regsrc, 1);
                            }
                        case 10 /* OPM.IMPL_R */:
                            if (NAME_CONV != 1) {
                                return '';
                            }
                            if (regm != undefined) {
                                return regname[rsh + regm];
                            }
                            else {
                                return '!R';
                            }
                        case 11 /* OPM.IMPL_R_DIR */:
                            if (NAME_CONV != 1) {
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
                if (opcs.ms != null) {
                    psstr = decode_mode(opcs.ms, false, opcs.sr);
                }
                pstr = decode_mode(opcs.md, true, opcs.dr);
                let rvc;
                switch (opcs.x) {
                    case undefined:
                        break;
                    case 0 /* OPL_EXT.MPUSH */:
                    case 1 /* OPL_EXT.MPOP */:
                        rvc = dfetch();
                        {
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
                        }
                        break;
                    case 2 /* OPL_EXT.PAGE */: {
                        rvc = dfetch();
                        let mod1 = (rvc >> 2) & 3;
                        let mod2 = rvc & 3;
                        let sel = (rvc >> 4);
                        switch (sel) {
                            case 0:
                                opname = "WPF";
                                break;
                            case 1:
                                opname = "RPF";
                                break;
                            case 2:
                                opname = "WPF1";
                                break;
                            case 3:
                                opname = "RPF1";
                                break;
                            case 4:
                                opname = "WPFH";
                                break;
                            case 5:
                                opname = "RPFH";
                                break;
                        }
                        break;
                    }
                    case 3 /* OPL_EXT.DMA */: {
                        rvc = dfetch();
                        let reg = (rvc >> 4);
                        let sel = (rvc & 15);
                        switch (sel) {
                            case 0:
                                opname = (NAME_CONV == 1) ? opname + 'LD.A' : 'LDDMAA';
                                pstr = regname[16 + reg];
                                break;
                            case 1:
                                opname = (NAME_CONV == 1) ? opname + 'ST.A' : 'STDMAA';
                                psstr = regname[16 + reg];
                                break;
                            case 2:
                                opname = (NAME_CONV == 1) ? opname + 'LD.C' : 'LDDMAC';
                                pstr = regname[16 + reg];
                                break;
                            case 3:
                                opname = (NAME_CONV == 1) ? opname + 'ST.C' : 'STDMAC';
                                psstr = regname[16 + reg];
                                break;
                            case 4:
                                opname = (NAME_CONV == 1) ? opname + 'LD.M' : 'SETDMAM';
                                psstr = `#${hexlist(reg, 1)}`;
                                break;
                            case 5:
                                opname = (NAME_CONV == 1) ? opname + 'LD.M' : 'SETDMAMR';
                                psstr = regname[16 + reg];
                                break;
                            case 6:
                                opname = (NAME_CONV == 1) ? opname + 'EN' : 'EDMA';
                                break;
                            case 7:
                                opname = (NAME_CONV == 1) ? opname + 'DIS' : 'DDMA';
                                break;
                            case 8:
                                opname = (NAME_CONV == 1) ? opname + 'LD.S' : 'LDISR';
                                psstr = regname[16 + reg];
                                break;
                            case 9:
                                opname = (NAME_CONV == 1) ? opname + 'ST.S' : 'STISR';
                                pstr = regname[16 + reg];
                                break;
                            default:
                                opname += hex(sel, 1);
                        }
                        break;
                    }
                }
                if (NAME_CONV == 1 && opcs.nm !== undefined) {
                    opname = opcs.nm;
                }
                if (pstr.length > 0 && psstr.length > 0) {
                    pstr += ', ';
                }
                dstr = `${dstr.padEnd(12, NB)}${astr.padEnd(4, NB)} ${opname} ${pstr}${psstr}`;
                if (vstr.length > 5) {
                    dstr += ` ;; "${vstr}"`;
                }
                const ret = { t: dstr, l: vpc - address };
                if (anpre.length > 0) {
                    ret.pre = anpre;
                }
                if (anstr.length > 0) {
                    ret.post = anstr;
                }
                return ret;
            }
            // emulation of instructions at a high level
            softstep() {
                let op = this.fetch(this.reg_p);
            }
        }
        const diag1 = new ROM2k();
        const diag2 = new ROM2k();
        const diag3 = new ROM2k();
        const diag4 = new ROM2k();
        diag1.loadbin(diag.f1);
        diag2.loadbin(diag.f2);
        diag3.loadbin(diag.f3);
        diag4.loadbin(diag.f4);
        const mmio_mux = new MMIOMux();
        const mem = [
            new SysMem(), new SysMem(),
            new SysMem(), new SysMem(),
            new SysMem(), new SysMem(),
            new SysMem(), new SysMem(),
        ];
        bpl.configmemory(0x3fc00, new ROM512({
            bin: bpl_rom, addr: { invert: true, remap: [0, 1, 2, 3, 4, 8, 5, 6, 7] },
        }), 512);
        bpl.configmemory(0x3f200, mmio_mux, 256);
        cx_crt0.mux = mmio_mux.muxports[0];
        const dsk2_0 = new DSK2();
        run_hw.push(dsk2_0);
        bpl.configio(0, mmio_mux);
        bpl.configio(1, dsk2_0);
        const mmio_0 = new MMIOMulti();
        const mmio_1 = new MMIOMulti();
        const mmio_8 = new MMIOMulti();
        bpl.configmemory(0x3f000, mmio_0, 256);
        bpl.configmemory(0x3f100, mmio_1, 256);
        bpl.configmemory(0x3f800, mmio_8, 256);
        mmio_1.adddev(0, 0x11, cx_diag0);
        mmio_1.adddev(0x40, 0x10, dsk2_0);
        const mmio_t = new MMIOTrace();
        //@ts-ignore
        window.p = mmio_t;
        const test_cmd = new TestCMD();
        mmio_8.adddev(0x08, 2, test_cmd);
        const prt_0 = new MockPrinter();
        mmio_0.adddev(0xe0, 0x10, prt_0);
        function setupmemory() {
            for (let q = 0; q < 8; q++) {
                bpl.configmemory(q * 0x4000, mem[q], 0x4000);
            }
            if (in_diagins.checked) {
                bpl.clearmemory(0x8000, 0x4000);
                bpl.configmemory(0x8000, diag1, 2048);
                bpl.configmemory(0x8800, diag2, 2048);
                bpl.configmemory(0x9000, diag3, 2048);
                bpl.configmemory(0x9800, diag4, 2048);
                bpl.configmemory(0xb800, new RAM2k(), 2048);
            }
        }
        setupmemory();
        update_microlist();
        mcsim.step(true);
        mcsim.showstate(true);
        const cpu = new CPU6(bpl);
        mem[0].loadhex(program_rotr, 0x100);
        //mem.loadbin(wipl_dump);
        function show_disasm() {
            let vpc = dis_vpc;
            for (let i = 0; i < listmax; i++) {
                try {
                    let res = cpu.disassembly(vpc);
                    listing[i].innerHTML = `${res.pre ? res.pre : ''}<div class="line"><span>${hex(vpc, 5)}: ${res.t}</span><div>${res.post ? res.post : ''}</div></div>`;
                    vpc = (vpc + res.l) & 0x3ffff;
                }
                catch (e) {
                    listing[i].innerHTML = `<div class="line"><span>${hex(vpc, 5)}: {{ERROR}}</span></div>`;
                    vpc += 1;
                }
            }
            dis_vpc_end = vpc;
        }
        in_dbgcmd.addEventListener('input', function (ev) {
            if (this.value.search(/^[0-9a-fA-F]{1,5}$/) > -1) {
                dis_vpc = parseInt(this.value, 16) & 0x3ffff;
                show_disasm();
            }
        });
        in_dbgcmd.addEventListener('keypress', function (ev) {
            if (ev.code == 'Enter' || ev.code == 'NumpadEnter') {
            }
        });
        in_diagins.addEventListener('change', function (ev) {
            setupmemory();
        });
        // sense_switch
        function update_sense() {
            style_if(btn_ss1, 'active', (sense_switch & 1) > 0);
            style_if(btn_ss2, 'active', (sense_switch & 2) > 0);
            style_if(btn_ss3, 'active', (sense_switch & 4) > 0);
            style_if(btn_ss4, 'active', (sense_switch & 8) > 0);
            style_if(btn_ssR, 'active', (dswitch & 8) > 0);
            style_if(btn_ssH, 'active', (dswitch & 4) > 0);
            style_if(btn_ssI, 'active', (dswitch & 2) > 0);
        }
        function update_diagsw() {
            style_if(btn_dt1, 'active', (cx_dip & 1) > 0);
            style_if(btn_dt2, 'active', (cx_dip & 2) > 0);
            style_if(btn_dt4, 'active', (cx_dip & 4) > 0);
            style_if(btn_dt8, 'active', (cx_dip & 8) > 0);
        }
        update_sense();
        update_diagsw();
        btn_ss1.addEventListener('click', function (ev) {
            sense_switch ^= 1;
            update_sense();
        });
        btn_ss2.addEventListener('click', function (ev) {
            sense_switch ^= 2;
            update_sense();
        });
        btn_ss3.addEventListener('click', function (ev) {
            sense_switch ^= 4;
            update_sense();
        });
        btn_ss4.addEventListener('click', function (ev) {
            sense_switch ^= 8;
            update_sense();
        });
        btn_ssR.addEventListener('click', function (ev) {
            dswitch ^= 8;
            update_sense();
        });
        btn_ssH.addEventListener('click', function (ev) {
            dswitch ^= 4;
            update_sense();
        });
        btn_ssI.addEventListener('click', function (ev) {
            dswitch ^= 2;
            update_sense();
        });
        btn_dt1.addEventListener('click', function (ev) {
            cx_dip ^= 1;
            update_diagsw();
        });
        btn_dt2.addEventListener('click', function (ev) {
            cx_dip ^= 2;
            update_diagsw();
        });
        btn_dt4.addEventListener('click', function (ev) {
            cx_dip ^= 4;
            update_diagsw();
        });
        btn_dt8.addEventListener('click', function (ev) {
            cx_dip ^= 8;
            update_diagsw();
        });
        btn_dtrun.addEventListener('click', function (ev) {
            cx_diag0.dip = cx_dip;
        });
        reset_button.addEventListener('click', function (ev) {
            mcsim.reset();
        });
        fp_rf.addEventListener('click', function (ev) {
            sense_switch ^= 8;
            update_sense();
        });
        fp_load.addEventListener('click', function (ev) {
            sense_switch |= 2;
            update_sense();
            mcsim.reset();
        });
        fp_select.addEventListener('click', function (ev) {
            sense_switch &= ~2;
            update_sense();
            mcsim.reset();
        });
        micro_button.addEventListener('click', function (ev) {
            if (win_micro.style.display == 'none') {
                win_micro.style.display = '';
            }
            else {
                win_micro.style.display = 'none';
            }
        });
        run_button.addEventListener('click', function (ev) {
            run_control(run_ctl == 0);
        });
        function update_runrate(new_rate) {
            run_rate = new_rate;
            style_if(run_rate1, 'active', run_rate == 1);
            style_if(run_rate2, 'active', run_rate == 10);
            style_if(run_rate3, 'active', run_rate == 100);
            style_if(run_rate4, 'active', run_rate == 1000);
            style_if(run_rate5, 'active', run_rate == 10000);
            style_if(run_rate6, 'active', run_rate == 50000);
            style_if(run_rate7, 'active', run_rate == 100000);
            style_if(run_rate8, 'active', run_rate == 150000);
        }
// Function to download data to a file
function download(data, filename, type) {
    var file = new Blob([data], {type: type});
    if (window.navigator.msSaveOrOpenBlob) // IE10+
        window.navigator.msSaveOrOpenBlob(file, filename);
    else { // Others
        var a = document.createElement("a"),
                url = URL.createObjectURL(file);
        a.href = url;
        a.download = filename;
        document.body.appendChild(a);
        a.click();
        setTimeout(function() {
            document.body.removeChild(a);
            window.URL.revokeObjectURL(url);
        }, 0);
    }
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
            run_stop = function () {
                dis_vpc = mcsim.physaddr() & 0x3ffff;
                show_disasm();
            };
            run_control(true);
        });
        microstep_button.addEventListener('click', function (ev) {
            run_once = true;
            mcsim.step(false);
            mcsim.step(true);
            mcsim.showstate(true);
            if (dis_after) {
                show_disasm();
            }
        });
        btn_settings.addEventListener('click', function (ev) {
            if (win_settings.style.display == 'none') {
                win_settings.style.display = '';
            }
            else {
                win_settings.style.display = 'none';
            }
        });
        btnSaveFixed.addEventListener('click', function (ev) {
          download(disk_images.fixed, dskui[1].sta.innerText, 'application/octet-stream');
        });
        btnSaveRemovable.addEventListener('click', function (ev) {
          download(disk_images.main, dskui[0].sta.innerText, 'application/octet-stream');
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
        if (document.getElementById('conv_ee').checked) {
            NAME_CONV = 0;
        }
        if (document.getElementById('conv_mei').checked) {
            NAME_CONV = 1;
        }
        if (document.getElementById('conv_uew').checked) {
            NAME_CONV = 2;
        }
        HEX_CONV = document.getElementById('conv_hex').checked;
        document.getElementById('conv_ee').addEventListener('change', function (ev) {
            NAME_CONV = 0;
            show_disasm();
        });
        document.getElementById('conv_mei').addEventListener('change', function (ev) {
            NAME_CONV = 1;
            show_disasm();
        });
        document.getElementById('conv_uew').addEventListener('change', function (ev) {
            NAME_CONV = 2;
            show_disasm();
        });
        document.getElementById('conv_hex').addEventListener('change', function (ev) {
            HEX_CONV = this.checked;
            show_disasm();
        });
        const inp_crtsize = document.getElementById('crtsize');
        function update_crt_tall() {
            style_if(cv_term0, 'tall', inp_crtsize.checked);
        }
        inp_crtsize.addEventListener('change', update_crt_tall);
        update_crt_tall();
        const inp_crtwide = document.getElementById('crtwide');
        function update_crt_wide() {
            style_if(cv_term0, 'wide', inp_crtwide.checked);
        }
        inp_crtwide.addEventListener('change', update_crt_wide);
        update_crt_wide();
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
        document.body.addEventListener('drop', function (ev) {
            const dt = ev.dataTransfer;
            if (dt == null || dt.files.length < 1) {
                ev.preventDefault();
                return;
            }
            let file = dt.files[0];
            let accept = false;
            if (file.name.match(/\.img$/i) != null) {
                file.arrayBuffer().then(function (buf) {
                    if (disk_images.fixed == null) {
                        disk_images.fixed = buf;
                        disk_images.fixed_view = new DataView(buf);
                        dskui[1].sta.innerText = file.name;
                        console.log('loaded disk image as fixed');
                    }
                    else {
                        disk_images.main = buf;
                        disk_images.main_view = new DataView(buf);
                        dskui[0].sta.innerText = file.name;
                        console.log('loaded disk image as removable');
                    }
                });
                accept = true;
            }
            if (!accept && (file.name.match(/\.bin$/i) != null ||
                file.type === '' ||
                file.type == 'application/octet-stream')) {
                win_load.file_name.innerText = file.name;
                win_load.file_type.innerText = file.type;
                win_load.file_size.innerText = `${file.size} (0x${hex(file.size, 1)}) bytes`;
                win_load.show().then(function (res) {
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
            ev.preventDefault();
        });
        show_disasm();
    });
});
