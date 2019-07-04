comma := ,
empty :=
space := $(empty) $(empty)

#DATASETSbig := Zhengmix4eq Zhengmix4uneq Zhengmix8eq
DATASETSbig := $(empty)
#DATASETSsmall := Kumar Trapnell Koh SimKumar4easy SimKumar4hard SimKumar8hard KohTCC TrapnellT#CC KumarTCC
DATASETSsmall := Koh Kumar
DATASETS := $(DATASETSbig) $(DATASETSsmall)

DATASETSbigc := $(subst $(space),$(comma),$(DATASETSbig))
DATASETSsmallc := $(subst $(space),$(comma),$(DATASETSsmall))
DATASETSc := $(subst $(space),$(comma),$(DATASETS))

DATASET_FOR_SCALABILITY := Koh
DATASET_FOR_PARAM_RANGES := Koh
