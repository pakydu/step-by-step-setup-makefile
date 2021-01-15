#get the all BASE BASE dir:

export BASE :=$(shell pwd)

include $(BASE)/mkEnv.mk



#append your new project into the below list: ------------
PROJECTS := libCom \
			test1 
	


#map the project and its folder:
project_libCom      :=$(BASE)/library-prjs/libCom
project_test1       :=$(BASE)/bin-prjs/test-program


#projects depends list:
depend = $(depend_$(1)) $(1)
depend_libCom      :=
depend_test1       :=$(call depend,libCom)

#参数的间隔的逗号后面不能有空格！！！
getFolder = $(patsubst file,$(project_$(notdir $(1))),$(patsubst undefined,$(notdir $(1)),$(origin project_$(notdir $(1)))))
getMakefile = $(patsubst file,$($(notdir $(1))_makefile),$(patsubst undefined,Makefile,$(origin $(notdir $(1))_makefile)))


TARGET_PROJECTS := $(foreach item, $(PROJECTS), $(shell if [ -e $(call getFolder, $(item))/$(call getMakefile, $(item)) ]; then echo $(item); fi))


build-all-list := $(TARGET_PROJECTS)   #$(patsubst %,%,$(TARGET_PROJECTS))
clean-all-list :=$(patsubst %,%_clean,$(TARGET_PROJECTS))

all:help


help:
	@echo  "-----------------------------------------------"
	@j=0; for i in $(PROJECTS); do  printf %-30s $$i; done
	@echo  "-------------- projects list end --------------"
	@echo  "-- make all"
	@echo  "-- make clean"
	@echo  "-- make [project name]"
	@echo  "-- make [project name]_clean"


build: dummy $(build-all-list)
	$(call endtimer, $@)

#create the install folder.
dummy: 
	$(shell mkdir -p $(BASE)/bin/)
	$(shell mkdir -p $(BASE)/lib/)
	$(shell mkdir -p $(BASE)/maps/)


clean: $(clean-all-list)
	@rm -rf $(PROGRAM_PATH)
	@rm -rf $(LIB_SHARE_PATH)
	@rm -rf $(MAP_FILE_PATH)


clean_all: clean
	@echo "remove all of the projects files."



$(build-all-list):
	@echo $(build-all-list)
	@echo "$(build_depend)"
	@echo "-------------------111"
	$(call build_depend)
	@echo "-------------------22"
	$(MAKE) -C $(call getFolder,$(patsubst %,%,$@)) -f $(call getMakefile,$(patsubst %,%,$@)) all $($(patsubst %,%,$@)_params)


$(clean-all-list):
	@echo $(clean-all-list)
	$(call clean_depend)
	$(MAKE) -C $(call getFolder,$(patsubst %_clean,%,$@)) -f $(call getMakefile,$(patsubst %_clean,%,$@)) clean $($(patsubst %_clean,%,$@)_params)


.PHONY: all help build clean $(all-build-list) dummy



#To build the dependency of project.
#$(MAKECMDGOALS): this is End Goal List. It will help us to handle loop case.
#For make build: it will follow the project list order. The depend rule will not be called.
#for make [projec_name]: it will use the depend rule.
build_depend =  \
	if [ "$(MAKECMDGOALS)" = "$@" ]; then \
		echo "try to build the $@";  \
		$(foreach dep,$(depend_$(notdir $(patsubst %,%,$@))), \
		$(MAKE) -C $(call getFolder,$(patsubst %,%,$(dep))) -f $(call getMakefile,$(patsubst %,%,$(dep))) all $($(patsubst %,%,$(dep))_params); \
		if [ $$? -ne 0 ]; then echo "Dependency project:$(dep) Build Failed!!!!"; exit 1;fi;) \
	fi;
#To clean the dependency of project.
clean_depend = $(OUTPUT_FILE) \
	if [ "$(MAKECMDGOALS)" = "$@" ]; then\
		echo "clean the $@"; \
		$(foreach dep,$(depend_$(notdir $(patsubst %_clean,%,$@))), \
		$(MAKE) -C $(call getFolder,$(patsubst %_clean,%,$(dep))) -f $(call getMakefile,$(patsubst %_clean,%,$(dep))) clean $($(patsubst %_clean,%,$(dep))_params); \
		if [ $$? -ne 0 ]; then echo -e "\t$(COLOR_RED)Dependency project:$(dep) Clean Failed!!!!$(COLOR_END)\n"; fi;) \
	fi;

