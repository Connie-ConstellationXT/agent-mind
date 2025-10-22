v {xschem version=3.4.5 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N -580 -300 -580 -260 {
lab=current_program_text}
N -580 -220 -580 -180 {
lab=global_goal}
N -580 -140 -580 -100 {
lab=global_domain}
N -180 -260 -140 -260 {
lab=next_character_out}
N -180 -220 -140 -220 {
lab=program_complete_out}
N -380 -340 -380 -300 {
lab=vdd}
N -380 -120 -380 -80 {
lab=vss}
N -580 -60 -580 -20 {
lab=anc_feedback}
N -580 20 -580 60 {
lab=chd_feedback}
N -580 100 -580 140 {
lab=self_feedback}
N -180 -180 -140 -180 {
lab=anc_status_out}
N -180 -140 -140 -140 {
lab=chd_command_out}
N -180 -100 -140 -100 {
lab=self_status_out}
C {vsource.sym} -680 -280 0 0 {name=V_current_text value=0 savecurrent=false}
C {vsource.sym} -680 -200 0 0 {name=V_global_goal value=3.0 savecurrent=false}
C {vsource.sym} -680 -120 0 0 {name=V_global_domain value=2.8 savecurrent=false}
C {vsource.sym} -680 -40 0 0 {name=Vdd value=3.3 savecurrent=false}
C {vsource.sym} -680 40 0 0 {name=Vss value=0 savecurrent=false}
C {gnd.sym} -680 -250 0 0 {name=l1 lab=GND}
C {gnd.sym} -680 -170 0 0 {name=l2 lab=GND}
C {gnd.sym} -680 -90 0 0 {name=l3 lab=GND}
C {gnd.sym} -680 -10 0 0 {name=l4 lab=GND}
C {gnd.sym} -680 70 0 0 {name=l5 lab=GND}
C {lab_pin.sym} -580 -280 0 0 {name=p1 sig_type=std_logic lab=current_program_text}
C {lab_pin.sym} -580 -200 0 0 {name=p2 sig_type=std_logic lab=global_goal}
C {lab_pin.sym} -580 -120 0 0 {name=p3 sig_type=std_logic lab=global_domain}
C {lab_pin.sym} -380 -340 1 0 {name=p4 sig_type=std_logic lab=vdd}
C {lab_pin.sym} -380 -80 3 0 {name=p5 sig_type=std_logic lab=vss}
C {lab_pin.sym} -140 -260 2 0 {name=p6 sig_type=std_logic lab=next_character_out}
C {lab_pin.sym} -140 -220 2 0 {name=p7 sig_type=std_logic lab=program_complete_out}
C {lab_pin.sym} -580 -40 0 0 {name=p8 sig_type=std_logic lab=anc_feedback}
C {lab_pin.sym} -580 40 0 0 {name=p9 sig_type=std_logic lab=chd_feedback}
C {lab_pin.sym} -580 120 0 0 {name=p10 sig_type=std_logic lab=self_feedback}
C {lab_pin.sym} -140 -180 2 0 {name=p11 sig_type=std_logic lab=anc_status_out}
C {lab_pin.sym} -140 -140 2 0 {name=p12 sig_type=std_logic lab=chd_command_out}
C {lab_pin.sym} -140 -100 2 0 {name=p13 sig_type=std_logic lab=self_status_out}
C {res.sym} -520 -40 1 0 {name=R1 value=1k m=1}
C {res.sym} -520 40 1 0 {name=R2 value=1k m=1}
C {res.sym} -520 120 1 0 {name=R3 value=1k m=1}
C {raln_root.sym} -380 -180 0 0 {name=X_ROOT_PROCESSOR}
C {title.sym} -160 260 0 0 {name=l6 author="RALN Architecture" rev=1.0 lock=false}
C {launcher.sym} 20 -200 0 0 {name=h5
descr="Annotate OP" 
tclcommand="set show_hidden_texts 1; xschem annotate_op"
}
C {launcher.sym} 20 -160 0 0 {name=h1 
descr="Show netlist" 
tclcommand="puts [info commands]; set schematic [file rootname [file tail [xschem get current_name]]]; puts $schematic; xschem netlist $schematic.sch"
}
C {launcher.sym} 20 -120 0 0 {name=h2
descr="Simulate" 
tclcommand="xschem netlist; xschem simulate"
}
C {code_shown.sym} 200 -200 0 0 {name=STIMULI only_toplevel=false value="
* RALN Python Hello World Generator
* Hierarchical stateless architecture
.temp 25
.save all
.tran 0.1u 500u
.control
  run
  plot v(next_character_out)
  plot v(program_complete_out)  
  plot v(current_program_text)
.endc
"}
C {code_shown.sym} 200 0 0 0 {name=HIERARCHY_INFO only_toplevel=false value="
* RALN Hierarchy:
* Level 0: ROOT RALN (this level)
* Level 1: Parse State, Next Token, Token Gen
* Level 2: Keyword Gen, Punct Gen, String Gen  
* Level 3: Content Gen, Quote Handler
* Level 4: Char Sequence, Position Tracker
*
* Input: current_program_text (world state)
* Output: next_character_out (what to append)
* 
* Stateless & Resumable like Apollo AGC
"}