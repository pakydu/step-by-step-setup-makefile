#get the all base root dir:

export ROOT :=$(shell pwd)

include $(ROOT)/mkEnv.mk



#append your new project into the below list: ------------
PROJECTS := libCom \
	test1


#map the project and its folder:
project_libCom      :=$(ROOT)/libCom
project_test1       :=$(ROOT)/test-program


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
	@echo  "\n-------------- projects list end"
	@echo  "-- make all"
	@echo  "-- make clean"
	@echo  "-- make [project name]"
	@echo  "-- make [project name]_clean"


build: $(build-all-list)
	$(call endtimer, $@)


clean: $(clean-all-list)
	@rm -rf $(PROGRAM_PATH)
	@rm -rf $(LIB_SHARE_PATH)
	@rm -rf $(MAP_FILE_PATH)


clean_all: clean
	@echo "remove all of the projects files."



$(build-all-list):
	#$(call starttimer,$@)
	$(call build_depend)
	#$(call print_build_info,$@)
	$(MAKE) -C $(call getFolder,$(patsubst %,%,$@)) -f $(call getMakefile,$(patsubst %,%,$@)) all $($(patsubst %,%,$@)_params)
	#$(call endtimer,$@)


$(clean-all-list):
	@echo $(clean-all-list)
	$(call clean_depend)
	#$(call print_clean_info,$@)
	@$(MAKE) -C $(call getFolder,$(patsubst %_clean,%,$@)) -f $(call getMakefile,$(patsubst %_clean,%,$@)) clean $($(patsubst %_clean,%,$@)_params)


.PHONY: all help build clean $(all-build-list)



#To build the dependency of project.
build_depend = $(OUTPUT_FILE) \
	if [ "$(MAKECMDGOALS)" = "$@" ]; then \
		echo "Build the $@";  \
		$(foreach dep,$(depend_$(notdir $(patsubst %,%,$@))), \
		$(shell $(MAKE) -C $(call getFolder,$(patsubst %,%,$(dep))) -f $(call getMakefile,$(patsubst %,%,$(dep))) all $($(patsubst %,%,$(dep))_params);); \
		if [ $$? -ne 0 ]; then echo -e "\t$(COLOR_RED)Dependency project:$(dep) Build Failed!!!!$(COLOR_END)\n"; exit 1;fi;) \
	fi
#To clean the dependency of project.
clean_depend = $(OUTPUT_FILE) \
	if [ "$(MAKECMDGOALS)" = "$@" ]; then\
		echo "clean the $@"; \
		$(foreach dep,$(depend_$(notdir $(patsubst %_clean,%,$@))), \
		$(MAKE) -C $(call getFolder,$(patsubst %_clean,%,$(dep))) -f $(call getMakefile,$(patsubst %_clean,%,$(dep))) clean $($(patsubst %_clean,%,$(dep))_params); \
		if [ $$? -ne 0 ]; then echo -e "\t$(COLOR_RED)Dependency project:$(dep) Clean Failed!!!!$(COLOR_END)\n"; fi;) \
	fi;

#To build the build information of project to console and log file.
# print_build_info = \
# 	@echo  "********************************************************************"; \
# 	@echo "** Build $1 : $(shell date -R)$(COLOR_END)"; \
# 	@echo "********************************************************************"; \
# 	@echo "*-----------------------------------------------------------">>$(LOG_FILE); \
# 	@echo "* Build $1:$(shell date -R)"                             >>$(LOG_FILE); \
# 	@echo "*-----------------------------------------------------------">>$(LOG_FILE)

# #To build the clean information of project to console and log file.
# print_clean_info = \
# 	echo -e "$(COLOR_RED)---------------------------- $(1) ----------------------------$(COLOR_END)"; \
# 	echo -e "$---------------------------- $(1) ----------------------------">>$(LOG_FILE)

# #To record the start time of compile.
# starttimer = @ echo $(shell date +%s.%N) > $(BUILD_TMP_FOLDER)/$1.tmstmp

# #To end the timer; Compute the time of compile and write to the console the file.
# endtimer = $(OUTPUT_FILE) \
# 	srt=`cat $(BUILD_TMP_FOLDER)/$1.tmstmp`; \
# 	end=`date +%s.%N`; \
# 	echo -e "\n$(COLOR_LIGHT_GREEN)@@@@@@ Build $1 Finished (took \
# 	$$[1000*$$[$$(echo $$end|cut -d '.' -f 1)-$$(echo $$srt|cut -d '.' -f 1)] \
# 	+ $$[10\#$$(echo $$end|cut -d '.' -f 2)-10\#$$(echo $$srt|cut -d '.' -f 2)]/1000000] \
# 	ms) @@@@@@@@$(COLOR_END)\n">&2
