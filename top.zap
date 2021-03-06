
	.SEGMENT "0"


	.FUNCT	MORE-SPECIFIC:ANY:0:0
	SET	'CLOCK-WAIT,TRUE-VALUE
	PRINTR	"[Please be more specific.]"


	.FUNCT	VERB-ALL-TEST:ANY:2:2,O,I,L
	LOC	O >L
	EQUAL?	PRSA,V?DROP,V?GIVE \?CCL3
	EQUAL?	L,WINNER \FALSE
	FSET?	L,WEARBIT /FALSE
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?PUT \?CCL10
	EQUAL?	O,I /FALSE
	IN?	O,I /FALSE
	RTRUE	
?CCL10:	EQUAL?	PRSA,V?TAKE \?CCL17
	FSET?	O,DONT-ALL /FALSE
	FSET?	O,WEARBIT /FALSE
	FSET?	O,TAKEBIT /?CND18
	FSET?	O,TRYTAKEBIT \FALSE
?CND18:	ZERO?	I /?CCL28
	EQUAL?	L,I /?CND26
	RFALSE	
?CCL28:	EQUAL?	L,HERE /TRUE
?CND26:	FSET?	L,PERSONBIT /TRUE
	FSET?	L,SURFACEBIT /TRUE
	FSET?	L,CONTBIT \FALSE
	FSET?	L,OPENBIT /TRUE
	RFALSE	
?CCL17:	EQUAL?	PRSA,V?WEAR \?CCL42
	FSET?	O,WEARABLE \FALSE
?CCL42:	ZERO?	I /TRUE
	EQUAL?	O,I /FALSE
	RTRUE	


	.FUNCT	FIX-HIM-HER-IT:ANY:2:2,PRON,OBJ
	ZERO?	OBJ \?CCL3
	ICALL1	MORE-SPECIFIC
	RFALSE	
?CCL3:	CALL2	ACCESSIBLE?,OBJ
	ZERO?	STACK \?CCL5
	EQUAL?	PRON,PRSO \?PRD9
	CALL2	EVERYWHERE-VERB?,1
	ZERO?	STACK /?CTR4
?PRD9:	EQUAL?	PRON,PRSI \?CCL5
	CALL2	EVERYWHERE-VERB?,2
	ZERO?	STACK \?CCL5
?CTR4:	ICALL2	NOT-HERE,OBJ
	RFALSE	
?CCL5:	EQUAL?	PRSO,PRON \?CND14
	SET	'PRSO,OBJ
	ICALL	TELL-PRONOUN,OBJ,PRON
?CND14:	EQUAL?	PRSI,PRON \?CND16
	SET	'PRSI,OBJ
	ICALL	TELL-PRONOUN,OBJ,PRON
?CND16:	EQUAL?	PRSS,PRON \TRUE
	SET	'PRSS,OBJ
	ICALL	TELL-PRONOUN,OBJ,PRON
	RTRUE	


	.FUNCT	TELL-PRONOUN:ANY:2:2,OBJ,PRON
	FSET?	PRON,TOUCHBIT /FALSE
	EQUAL?	OPRSO,OBJ /FALSE
	EQUAL?	PRSA,V?DO? /FALSE
	PRINTI	"["""
	ICALL2	DPRINT,PRON
	PRINTI	""" meaning "
	ICALL2	THE-PRINT,OBJ
	PRINTR	"]"


	.FUNCT	NO-M-WINNER-VERB?:ANY:0:0
	GET	NO-M-WINNER-VERB-TABLE,0
	INTBL?	PRSA,NO-M-WINNER-VERB-TABLE+2,STACK /TRUE
	RFALSE	


	.FUNCT	FIND-A-WINNER:ANY:0:1,RM,OTHER,WHO,N
	ASSIGNED?	'RM /?CND1
	SET	'RM,HERE
?CND1:	ZERO?	QCONTEXT /?CCL5
	IN?	QCONTEXT,RM \?CCL5
	RETURN	QCONTEXT
?CCL5:	FIRST?	RM >OTHER /?BOGUS8
?BOGUS8:	SET	'WHO,FALSE-VALUE
?PRG9:	ZERO?	OTHER \?CCL13
	RETURN	WHO
?CCL13:	FSET?	OTHER,PERSONBIT \?CND11
	FSET?	OTHER,INVISIBLE /?CND11
	EQUAL?	OTHER,PLAYER /?CND11
	IGRTR?	'N,1 /FALSE
	SET	'WHO,OTHER
?CND11:	NEXT?	OTHER >OTHER /?PRG9
	JUMP	?PRG9


	.FUNCT	TELL-SAID-TO:ANY:1:1,PER
	PRINTI	"[said to "
	ICALL2	DPRINT,PER
	PRINTR	"]"


	.FUNCT	QCONTEXT-GOOD?:ANY:0:0
	ZERO?	QCONTEXT /FALSE
	FSET?	QCONTEXT,PERSONBIT \FALSE
	CALL2	META-LOC,QCONTEXT
	EQUAL?	HERE,STACK \FALSE
	RETURN	QCONTEXT


	.FUNCT	META-LOC:ANY:1:2,OBJ,INV,L
	LOC	OBJ >L
?PRG1:	EQUAL?	FALSE-VALUE,OBJ,L /FALSE
	EQUAL?	L,LOCAL-GLOBALS,GLOBAL-OBJECTS,GENERIC-OBJECTS \?CCL7
	RETURN	L
?CCL7:	IN?	OBJ,ROOMS \?CCL9
	RETURN	OBJ
?CCL9:	ZERO?	INV /?CND10
	FSET?	OBJ,INVISIBLE /FALSE
?CND10:	SET	'OBJ,L
	LOC	OBJ >L
	JUMP	?PRG1


	.FUNCT	CANT-UNDO:ANY:0:0
	PRINTR	"[I can't undo that now.]"


	.FUNCT	SEE-VERB?:ANY:0:0
	EQUAL?	PRSA,V?SEARCH,V?READ /TRUE
	EQUAL?	PRSA,V?LOOK-UP,V?LOOK-UNDER,V?LOOK-INSIDE /TRUE
	EQUAL?	PRSA,V?LOOK-DOWN,V?LOOK-BEHIND,V?LOOK /TRUE
	EQUAL?	PRSA,V?FIND,V?EXAMINE,V?CHASTISE /TRUE
	RFALSE	


	.FUNCT	PERFORM:ANY:1:3,PA,PO,PI,V,OA,OO,OI,OQ,OS,X,?TMP1,?TMP2
	SET	'OA,PRSA
	SET	'OO,PRSO
	SET	'OI,PRSI
	ZERO?	OO /?CCL3
	EQUAL?	OO,PI \?CCL3
	SET	'OBJ-SWAP,TRUE-VALUE
	JUMP	?CND1
?CCL3:	ZERO?	OI /?CCL7
	EQUAL?	OI,PO \?CCL7
	SET	'OBJ-SWAP,TRUE-VALUE
	JUMP	?CND1
?CCL7:	SET	'OBJ-SWAP,FALSE-VALUE
?CND1:	SET	'PRSA,PA
	SET	'PRSI,PI
	SET	'PRSO,PO
	SET	'V,FALSE-VALUE
	ZERO?	PRSS /?CND10
	ICALL2	THIS-IS-IT,PRSS
?CND10:	ZERO?	PRSI /?CND12
	ICALL2	THIS-IS-IT,PRSI
?CND12:	ZERO?	PRSO /?CND14
	EQUAL?	PRSA,V?TELL /?CND14
	EQUAL?	PRSA,V?WALK /?CND14
	ICALL2	THIS-IS-IT,PRSO
?CND14:	EQUAL?	WINNER,PLAYER /?CND19
	ICALL2	THIS-IS-IT,WINNER
?CND19:	SET	'PO,PRSO
	SET	'PI,PRSI
	CALL1	NO-M-WINNER-VERB?
	ZERO?	STACK \?CND21
	GETP	WINNER,P?ACTION
	CALL	STACK,M-WINNER >V
?CND21:	ZERO?	PRSS /?CND24
	ZERO?	V \?CND26
	GETP	PRSS,P?ACTION
	CALL	STACK,M-SUBJ >V
?CND26:	ZERO?	V \?CND28
	ZERO?	PRSQ /?CND28
	GET	ACTIONS,PA >?TMP2
	ADD	QACTIONS,2 >?TMP1
	GET	QACTIONS,0
	INTBL?	?TMP2,?TMP1,STACK >X \?CND28
	GET	X,2
	CALL	STACK >V
?CND28:	ZERO?	V \?CND34
	ZERO?	PRSQ /?CCL38
	GET	ACTIONS,PA >?TMP2
	ADD	QACTIONS,2 >?TMP1
	GET	QACTIONS,0
	INTBL?	?TMP2,?TMP1,STACK >X \?CND39
	GET	X,1 >X
	ZERO?	X /?CND39
	CALL	X >V
?CND39:	ZERO?	V \?CND34
	GET	ACTIONS,PRSQ
	CALL	STACK >V
	JUMP	?CND34
?CCL38:	ICALL	V-STATEMENT
?CND34:	EQUAL?	M-FATAL,V \?CND45
	SET	'P-CONT,-1
?CND45:	SET	'PRSA,OA
	SET	'PRSO,OO
	SET	'PRSI,OI
	RETURN	V
?CND24:	ZERO?	V \?CND47
	LOC	WINNER
	IN?	STACK,ROOMS /?CND47
	LOC	WINNER
	GETP	STACK,P?ACTION
	CALL	STACK,M-BEG >V
?CND47:	ZERO?	V \?CND51
	GETP	HERE,P?ACTION
	CALL	STACK,M-BEG >V
?CND51:	ZERO?	V \?CND53
	GET	PREACTIONS,PA
	CALL	STACK >V
?CND53:	SET	'NOW-PRSI,1
	ZERO?	V \?CND55
	ZERO?	PI /?CND55
	EQUAL?	PRSA,V?WALK /?CND55
	LOC	PI
	ZERO?	STACK /?CND55
	LOC	PI
	GETP	STACK,P?CONTFCN >V
	ZERO?	V /?CND55
	CALL	V,M-CONTAINER >V
?CND55:	ZERO?	V \?CND63
	ZERO?	PI /?CND63
	EQUAL?	PI,GLOBAL-HERE \?CND67
	GETP	HERE,P?ACTION
	CALL	STACK >V
?CND67:	ZERO?	V \?CND63
	GETP	PI,P?ACTION
	CALL	STACK >V
?CND63:	SET	'NOW-PRSI,0
	ZERO?	V \?CND71
	ZERO?	PO /?CND71
	EQUAL?	PRSA,V?WALK /?CND71
	LOC	PO
	ZERO?	STACK /?CND71
	LOC	PO
	GETP	STACK,P?CONTFCN >V
	ZERO?	V /?CND71
	CALL	V,M-CONTAINER >V
?CND71:	ZERO?	V \?CND79
	ZERO?	PO /?CND79
	EQUAL?	PRSA,V?WALK /?CND79
	EQUAL?	PO,GLOBAL-HERE \?CND84
	GETP	HERE,P?ACTION
	CALL	STACK >V
?CND84:	ZERO?	V \?CND79
	GETP	PO,P?ACTION
	CALL	STACK >V
?CND79:	ZERO?	V \?CND88
	GET	ACTIONS,PA
	CALL	STACK >V
?CND88:	EQUAL?	M-FATAL,V \?CND91
	SET	'P-CONT,-1
?CND91:	SET	'PRSA,OA
	SET	'PRSO,OO
	SET	'PRSI,OI
	RETURN	V


	.FUNCT	TELL-TOO-DARK:ANY:0:0
	PRINT	TOO-DARK
	RETURN	M-FATAL


	.FUNCT	ITAKE-CHECK:ANY:2:2,OBJ,BITS,TAKEN
	EQUAL?	OBJ,IT \?CCL3
	SET	'OBJ,P-IT-OBJECT
	JUMP	?CND1
?CCL3:	EQUAL?	OBJ,THEM \?CND1
	SET	'OBJ,P-THEM-OBJECT
?CND1:	CALL	HELD?,OBJ,WINNER
	ZERO?	STACK \FALSE
	EQUAL?	OBJ,HANDS,ROOMS /FALSE
	FSET?	OBJ,TRYTAKEBIT /?CND10
	EQUAL?	WINNER,PLAYER /?CCL14
	SET	'TAKEN,TRUE-VALUE
	JUMP	?CND10
?CCL14:	BTST	BITS,32 \?CND10
	CALL	ITAKE,FALSE-VALUE,OBJ
	EQUAL?	STACK,TRUE-VALUE \?CND10
	SET	'TAKEN,TRUE-VALUE
?CND10:	ZERO?	TAKEN \FALSE
	BTST	BITS,64 \FALSE
	BTST	BITS,128 /FALSE
	PRINTC	91
	EQUAL?	WINNER,PLAYER \?CCL26
	PRINTI	"You are"
	JUMP	?CND24
?CCL26:	ICALL2	CTHE-PRINT,WINNER
	PRINTI	" is"
?CND24:	PRINTI	"n't holding "
	ICALL2	THE-PRINT,OBJ
	ICALL2	THIS-IS-IT,OBJ
	PRINTR	"!]"


	.FUNCT	CAPITAL-NOUN?:ANY:1:1,WD
	EQUAL?	WD,W?ACHIKO,W?AKABO,W?ALVITO /TRUE
	EQUAL?	WD,W?BACCUS,W?BLACKTHORNE,W?BROWN /TRUE
	EQUAL?	WD,W?BROWNS,W?BUNTARO,W?CAPTAIN /TRUE
	EQUAL?	WD,W?CAPTAIN-GENERAL,W?CHIMMOKO,W?CROOCQ /TRUE
	EQUAL?	WD,W?DANZENJI,W?DOMINGO,W?ENGLAND /TRUE
	EQUAL?	WD,W?ERASMUS,W?ETSU,W?GINSEL /TRUE
	EQUAL?	WD,W?GONZALEZ,W?GORODA,W?GRAY /TRUE
	EQUAL?	WD,W?GRAYS,W?GYOKO,W?HENDRIK /TRUE
	EQUAL?	WD,W?HIRO-MATSU,W?HOLLAND,W?I /TRUE
	EQUAL?	WD,W?ISHIDO,W?JAN,W?JOHANN /TRUE
	EQUAL?	WD,W?JOHN,W?KASIGI,W?KAZUNARI /TRUE
	EQUAL?	WD,W?KIKU,W?KIRI,W?KIRITSUBO /TRUE
	EQUAL?	WD,W?KIYAMA,W?KOJIMA,W?KWAMPAKU /TRUE
	EQUAL?	WD,W?MAETSUKKER,W?MARIKO,W?MARTIN /TRUE
	EQUAL?	WD,W?MAXIMILIAN,W?MURA,W?NAKAMURA /TRUE
	EQUAL?	WD,W?NEKK,W?OCHIBA,W?OMI /TRUE
	EQUAL?	WD,W?ONNA,W?PAULUS,W?PIETERZOON /TRUE
	EQUAL?	WD,W?POPE,W?RODRIGUES,W?ROPER /TRUE
	EQUAL?	WD,W?SAIGAWA,W?SALAMON,W?SAZUKO /TRUE
	EQUAL?	WD,W?SEBASTIO,W?SHOGUN,W?SONK /TRUE
	EQUAL?	WD,W?SPECZ,W?SPILLBERGEN,W?SUMIYORI /TRUE
	EQUAL?	WD,W?TAIKO,W?TODA,W?TORANAGA /TRUE
	EQUAL?	WD,W?VASCO,W?VINCK,W?YABU /TRUE
	EQUAL?	WD,W?YAEMON,W?YAMAZAKI,W?YOSHI /TRUE
	EQUAL?	WD,W?YOSHINAKA,W?ZATAKI /TRUE
	RFALSE	


	.FUNCT	NOT-HERE:ANY:1:2,OBJ,CLOCK
	ZERO?	CLOCK \?CND1
	SET	'CLOCK-WAIT,TRUE-VALUE
	PRINTI	"[But"
?CND1:	PRINTC	32
	ICALL2	THE-PRINT,OBJ
	ICALL2	PRINT-IS/ARE,OBJ
	PRINTI	"n't "
	CALL2	VISIBLE?,OBJ
	ZERO?	STACK /?CCL5
	PRINTI	"close enough"
	CALL1	SPEAKING-VERB?
	ZERO?	STACK /?CND6
	PRINTI	" to hear you"
?CND6:	PRINTC	46
	JUMP	?CND3
?CCL5:	PRINTI	"here!"
?CND3:	ICALL2	THIS-IS-IT,OBJ
	ZERO?	CLOCK \?CND8
	PRINTC	93
?CND8:	CRLF	
	RTRUE	


	.FUNCT	SPEAKING-VERB?:ANY:0:1,A
	ASSIGNED?	'A /?CND1
	SET	'A,PRSA
?CND1:	EQUAL?	A,V?ANSWER,V?ASK-ABOUT,V?ASK-FOR /TRUE
	EQUAL?	A,V?CURSE,V?HELLO,V?NO /TRUE
	EQUAL?	A,V?REPLY,V?SAY,V?SPEAK /TRUE
	EQUAL?	A,V?TELL,V?TELL-ABOUT,V?THANK /TRUE
	EQUAL?	A,V?THOU,V?YELL,V?YELL-AT /TRUE
	EQUAL?	A,V?YES /TRUE
	RFALSE	


	.FUNCT	GET-OWNER:ANY:1:1,OBJ,TMP,NP
	CALL2	GET-NP,OBJ >NP
	ZERO?	NP /FALSE
	GET	NP,4 >TMP
	ZERO?	TMP \?CTR5
	GET	NP,1 >TMP
	ZERO?	TMP /?CCL6
	GET	TMP,2 >TMP
	ZERO?	TMP /?CCL6
?CTR5:	LESS?	0,TMP \FALSE
	GRTR?	TMP,LAST-OBJECT /FALSE
	RETURN	TMP
?CCL6:	GETP	OBJ,P?OWNER >TMP
	ZERO?	TMP /FALSE
	LESS?	0,TMP \?CCL17
	GRTR?	TMP,LAST-OBJECT \FALSE
?CCL17:	RETURN	PLAYER


	.FUNCT	GET-NP:ANY:0:1,OBJ,PRSI?
	SET	'PRSI?,NOW-PRSI
	EQUAL?	OBJ,FALSE-VALUE,PRSO,PRSI \FALSE
	ZERO?	OBJ /?CND1
	EQUAL?	OBJ,PRSO \?CCL7
	SET	'PRSI?,FALSE-VALUE
	JUMP	?CND1
?CCL7:	SET	'PRSI?,TRUE-VALUE
?CND1:	ZERO?	OBJ-SWAP /?CCL10
	ZERO?	PRSI? /?CCL13
	RETURN	PRSO-NP
?CCL13:	RETURN	PRSI-NP
?CCL10:	ZERO?	PRSI? /?CCL15
	RETURN	PRSI-NP
?CCL15:	RETURN	PRSO-NP


	.FUNCT	NOUN-USED?:ANY:1:4,OBJ,WD1,WD2,WD3,X
	CALL2	GET-NP,OBJ >X
	ZERO?	X /FALSE
	GET	X,2 >X
	ZERO?	X /FALSE
	ZERO?	WD1 \?CCL8
	RETURN	X
?CCL8:	EQUAL?	X,WD1,WD2,WD3 /TRUE
	RFALSE	


	.FUNCT	ADJ-USED?:ANY:2:4,OBJ,WD1,WD2,WD3,NP,CT
	CALL2	GET-NP,OBJ >NP
	GET	NP,1 >NP
	ZERO?	NP /?CCL3
	GET	NP,2
	EQUAL?	PLAYER,STACK \?CCL6
	EQUAL?	W?MY,WD1,WD2,WD3 \?CCL6
	RETURN	W?MY
?CCL6:	GET	NP,4 >CT
	GRTR?	CT,0 \?CCL10
	ADD	NP,10 >NP
	INTBL?	WD1,NP,CT \?CCL13
	RETURN	WD1
?CCL13:	ZERO?	WD2 /FALSE
	INTBL?	WD2,NP,CT \?CCL18
	RETURN	WD2
?CCL18:	ZERO?	WD3 /FALSE
	INTBL?	WD3,NP,CT \FALSE
	RETURN	WD3
?CCL10:	EQUAL?	WD1,FALSE-VALUE /TRUE
	RFALSE	
?CCL3:	EQUAL?	WD1,FALSE-VALUE /TRUE
	RFALSE	

	.ENDSEG

	.ENDI
