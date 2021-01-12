#********************************************************************************
#**|                                                                          |**
#**|                    Top Makefile                                          |**
#**|                                                                          |**
#********************************************************************************
export BASE :=$(shell pwd)

include $(BASE)/rule.make


ignore := $(shell rm -f source/libARM/libarm.o)

##############################################################
#               The projects info.                           #
##############################################################
PROJS:=libJsonObjects \
	libSStimer \
	libMarkupSTL \
	libPlatform \
	libAdvServices \
	libG4 \
	libsslogd \
	libXalg \
	libWatchdog \
	$(LIBPLATDIR) \
	libG4AppUtilities \
	libADF \
	WebSrvCfgMgr \
	libBACnetStack \
	libSerialManager \
	libBackRest \
	libUIBE \
	libPersistentStore \
	libMonitoring \
	dataserver \
	G4AppLib \
	OnBoardIO_Manager \
	CANBus_Manager \
	AdvisoryServices \
	Monitoring \
	ApplicationServices \
	G4Logger \
	G4MessageRelay \
	SSlogService \
	WatchdogProcess \
	UIBE_MsgGateway \
	LPolling_Service \
	DownloadGateway \
	Upload_CGI \
	WebSocket_service \
	libSessManager \
	libRCIMessage \
 	libVisibility \
 	RemComm \
	imtool \
	usb_port_reset \
	BackRestProcess \
	AppDataConvert \
	UnitNumUtil \
	SerialManagerProcess \
	CredentialServices \
	WebSrvCfgGen \
    TM_CGI \
	libPAL \
	libSoap \
	SoapCgi \
	libRest \
	RestCgi \
	TraceServ


#The Makefile path of project.
proj_libJsonObjects         :=$(BASE)/3rd_party_sw/libJsonObjects
proj_libMarkupSTL           :=$(BASE)/3rd_party_sw/libMarkupSTL
proj_libPlatform            :=$(BASE)/source/libPlatform
proj_$(LIBPLATDIR)          :=$(BASE)/source/$(LIBPLATDIR)
proj_libAdvServices         :=$(BASE)/source/libAdvServices
proj_libG4                  :=$(BASE)/source/common/LibG4
proj_libsslogd              :=$(BASE)/source/Libsslogd
proj_libXalg                :=$(BASE)/G4_app_small/xalg
proj_libWatchdog            :=$(BASE)/source/LibWatchdog
proj_libUIBE                :=$(BASE)/source/UI_backend/LibUIBE
proj_libG4AppUtilities      :=$(BASE)/G4_app_small/AppUtilities
proj_libPersistentStore     :=$(BASE)/source/libPersistentStore
proj_libMonitoring          :=$(BASE)/source/libMonitoring
proj_libBACnetStack         :=$(BASE)/3rd_party_sw/libBACnetStack
proj_libSerialManager       :=$(BASE)/source/libSerialManager
proj_libSStimer             :=$(BASE)/source/SS_local_time/libSStimer
proj_dataserver             :=$(BASE)/source/common/dataserver
proj_G4AppLib               :=$(BASE)/G4_app_small/G4AppLib
proj_OnBoardIO_Manager      :=$(BASE)/source/OnBoardIO_Manager
proj_CANBus_Manager         :=$(BASE)/source/CANBus_Manager
proj_AdvisoryServices       :=$(BASE)/AdvisoryServices
proj_Monitoring             :=$(BASE)/Monitoring
proj_ApplicationServices    :=$(BASE)/G4_app_small/ApplicationServices
proj_G4Logger               :=$(BASE)/G4Logger
proj_G4MessageRelay         :=$(BASE)/G4MessageRelay
proj_SSlogService           :=$(BASE)/source/sslogd
proj_WatchdogProcess        :=$(BASE)/source/WatchdogProcess
proj_UIBE_MsgGateway        :=$(BASE)/source/UI_backend/MessagingGateway
proj_LPolling_Service       :=$(BASE)/source/UI_backend/LongPolling
proj_DownloadGateway        :=$(BASE)/source/UI_backend/DownloadGateway
proj_Upload_CGI             :=$(BASE)/source/UI_backend/Updater
proj_WebSocket_service      :=$(BASE)/source/UI_backend/StreamSrv
proj_libSessManager         :=$(BASE)/source/RemComm/src/cpp/libSessManager
proj_libRCIMessage          :=$(BASE)/source/RemComm/src/cpp/libRCIMessage
proj_RemComm                :=$(BASE)/source/RemComm/src/cpp/rci
proj_libVisibility          :=$(BASE)/source/libVisibility
proj_imtool                 :=$(BASE)/source/utils/imtool
proj_usb_port_reset         :=$(BASE)/source/utils/usb_port_reset
proj_libBackRest            :=$(BASE)/source/LibBackRest
proj_BackRestProcess        :=$(BASE)/source/BackRestProcess
proj_libADF                 :=$(BASE)/source/LibADF
proj_AppDataConvert         :=$(BASE)/source/AppDataConvert
proj_UnitNumUtil            :=$(BASE)/source/utils/UnitNumUtil
proj_SerialManagerProcess   :=$(BASE)/source/SerialManagerProcess
proj_WebSrvCfgMgr           :=$(BASE)/source/WebSrvCfgMgr
proj_CredentialServices     :=$(BASE)/source/CredentialServicesProcess
proj_WebSrvCfgGen           :=$(BASE)/source/WebSrvCfgGen
proj_TM_CGI                 :=$(BASE)/source/UI_backend/TerminalGateway
proj_libPAL                 :=$(BASE)/source/ProtocolAbstractLayer/libPAL
proj_paltest                :=$(BASE)/source/ProtocolAbstractLayer/paltest
proj_libSoap                :=$(BASE)/source/soap/LibSoap
proj_SoapCgi                :=$(BASE)/source/UI_backend/SoapCgi
proj_libRest                :=$(BASE)/source/rest/LibRest
proj_RestCgi                :=$(BASE)/source/UI_backend/RestCgi
proj_TraceServ              :=$(BASE)/source/TraceServ


depend = $(depend_$(1)) $(1)
#The dependency of project.
#Warnning: If project call the fucntion of depend, it depend the project which is the prarmter of the function and the
#dependency of the the project.
depend_libJsonObjects       :=
depend_libMarkupSTL         :=
depend_$(LIBPLATDIR)        :=libG4 libsslogd libwatchdog
depend_libPlatform          :=libJsonObjects $(LIBPLATEXT)
depend_libAdvServices       :=libJsonObjects
depend_libG4                :=libJsonObjects libAdvServices libPlatform
depend_libsslogd            :=$(call depend,libG4)
depend_libXalg              :=
depend_libWatchdog          :=$(call depend,libG4) libsslogd libSStimer
depend_libG4AppUtilities    :=$(call depend,libWatchdog)
depend_libUIBE              :=$(call depend,libG4AppUtilities) libBackRest libBACnetStack libSerialManager libADF
depend_libPersistentStore   :=$(call depend,libG4AppUtilities)
depend_libMonitoring        :=$(call depend,libG4AppUtilities)
depend_libBACnetStack       :=
depend_libSerialManager     :=libG4 libsslogd libSStimer libBACnetStack libG4AppUtilities
depend_dataserver           :=$(call depend,libWatchdog)
depend_G4AppLib             :=$(call depend,libG4AppUtilities) libXalg
depend_OnBoardIO_Manager    :=$(call depend,dataserver)
depend_CANBus_Manager       :=$(call depend,dataserver)
depend_AdvisoryServices     :=$(call depend,libG4AppUtilities) libPersistentStore
depend_Monitoring           :=$(call depend,libG4AppUtilities) libMonitoring libPersistentStore libMarkupSTL
depend_ApplicationServices  :=$(call depend,libG4AppUtilities) libXalg G4AppLib libMonitoring libPersistentStore libMarkupSTL libBACnetStack libSerialManager libADF WebSrvCfgMgr libPlatform libUIBE
depend_G4Logger             :=$(call depend,libG4AppUtilities)
depend_G4MessageRelay       :=$(call depend,libG4AppUtilities)
depend_SSlogService         :=$(call depend,libG4) libsslogd
depend_WatchdogProcess      :=$(call depend,libG4) libWatchdog
depend_UIBE_MsgGateway      :=$(call depend,libUIBE)
depend_LPolling_Service     :=libJsonObjects libAdvServices
depend_DownloadGateway      :=$(call depend,libUIBE)
depend_Upload_CGI           :=$(call depend,libUIBE) libG4AppUtilities libADF
depend_WebSocket_service    :=$(call depend,libUIBE)
depend_libSessManager       :=$(call depend,libG4)
depend_libRCIMessage        :=$(call depend,libSessManager) libVisibility libADF
depend_RemComm              :=$(call depend,libUIBE) libSessManager libRCIMessage libVisibility
depend_libVisibility        :=$(call depend,libJsonObjects) 
depend_imtool               :=
depend_usb_port_reset       :=
depend_libBackRest          :=$(call depend,libsslogd)
depend_BackRestProcess      :=$(call depend,libBackRest)
depend_libADF               :=libJsonObjects libWatchdog libG4AppUtilities libG4
depend_AppDataConvert       :=libADF libWatchdog libG4AppUtilities libG4
depend_UnitNumUtil          :=$(call depend,libG4AppUtilities)
depend_SerialManagerProcess :=$(call depend,libSerialManager) libWatchdog
depend_libSStimer           :=$(call depend,libsslogd)
depend_WebSrvCfgMgr         :=libJsonObjects libG4 libWatchdog
depend_WebSrvCfgGen         :=WebSrvCfgMgr 
depend_TM_CGI               :=$(call depend,libUIBE)
depend_libPAL               :=$(call depend,libG4) libWatchdog libG4AppUtilities libBACnetStack libSerialManager libSessManager libVisibility WebSrvCfgMgr
depend_paltest		    :=libPAL
depend_libSoap              :=libG4 libPAL libMarkupSTL
depend_wsExt                :=$(call depend,libPAL) libSoap libJsonObjects
depend_libRest              :=libG4 libPAL libMarkupSTL
depend_RestCgi              :=$(call depend,libPAL) libRest libJsonObjects
depend_TraceServ            :=

##############################################################
#               End of the projects info.                    #
##############################################################

gethome = $(patsubst file,$(proj_$(notdir $(1))),$(patsubst undefined,$(notdir $(1)),$(origin proj_$(notdir $(1)))))
getmake = $(patsubst file,$($(notdir $(1))_makefile),$(patsubst undefined,Makefile,$(origin $(notdir $(1))_makefile)))

IMAGE_PROJS :=$(foreach comp,$(PROJS),$(shell if [ -e $(call gethome,$(comp))/$(call getmake,$(comp)) ]; then echo $(comp); fi))
image-build-list :=$(patsubst %,%,$(IMAGE_PROJS))
image-clean-list :=$(patsubst %,%_clean,$(IMAGE_PROJS))

all-build-list :=$(image-build-list)
all-clean-list :=$(image-clean-list) 

all:help
#build the project by make
buildless: dummy envcheck fsbuilder $(image-build-list)

build: dummy envcheck fsbuilder $(image-build-list) image
	$(call endtimer,$@)

clean: dummy fsclean $(image-clean-list)
	@ rm -rf $(BUILD_TMP_FOLDER)
ifneq (/dev/null, $(LOG_FILE))
	@ rm -rf $(LOG_FILE)
endif

clean_all: clean
	@ls -a1F | grep "^\." | grep rootfs | xargs rm -rf
	@ls -1F | grep / | grep rootfs | xargs rm -rf
	@rm -rf ./G4web/release

#To check the environment.
envcheck: dummy
	@ echo > $(LOG_FILE)
	$(call starttimer,build)

fsbuilder: dummy
	$(call init_log)
	$(call starttimer,$@)
	@$(MAKE) -C $(BASE)/G4_Builder/scripts fs
	$(call endtimer,$@)

fsclean:
	@ $(MAKE) -C G4_Builder/scripts clean

#To build the image.
image: dummy
	$(call init_log)
	$(call starttimer,$@)
	$(MAKE) -C G4_Builder/scripts image
	$(call endtimer,$@)

$(all-build-list) : dummy
	$(call init_log)
	$(call starttimer,$@)
	$(call build_dep)
	@ $(call print_build_info,$@)
	$(OUTPUT_FILE)$(MAKE) -C $(call gethome,$(patsubst %,%,$@)) -f $(call getmake,$(patsubst %,%,$@)) all $($(patsubst %,%,$@)_params)
	$(call endtimer,$@)

$(all-clean-list) : dummy
	$(call clean_dep)
	@$(call print_clean_info,$@)
	@$(MAKE) -C $(call gethome,$(patsubst %_clean,%,$@)) -f $(call getmake,$(patsubst %_clean,%,$@)) clean $($(patsubst %_clean,%,$@)_params)

#paky: don't research the G4web, we need to keep them for the md5sum comparing!!!
dummy:
	@fakeroot find ./ \( -path './G4web/www/node_modules' -o -path './rootfs_*' \)  -prune -o  \( -name "*.make" -o -name Makefile -o -name "*.mk" -o -name "*.sh" -o -name makeprdk \) -exec chmod -fR +x '{}' \;
	@mkdir -p $(BUILD_TMP_FOLDER)/utils

.PHONY: all help build clean dummy $(image-all-list) $(image-build-list) envcheck fsbuilder image


##########################################################################################
#         DO NOT modify these settings below, unless you know what you are doing!        #
##########################################################################################
help:
	@echo -e "--------------------------------------------------------------"
	@echo -e "$(COLOR_GREEN)Image Projects List:$(COLOR_END)"
	@j=0; for i in $(PROJS); do echo -ne " ???  $(COLOR_GREEN)"; printf %-30s $$i; echo -ne "$(COLOR_END)"; j=`expr $$j + 1`; if test `expr $$j % 2` == 0;then echo -ne "\n";else echo -ne "\t";fi done
	@echo -e "\n\n$(COLOR_CYAN)Utils Projects List:$(COLOR_END)"
	@echo -e "\e[0;36;7mNOTE\e[27m: Add \"\e[1mutils\e[0;36m/\" in front of project name, when you build/clean utils project.\n\t(eg. \e[1mmake utils/<UtilPrjName>\e[0;36m or \e[1mmake utils/<UtilPrjName>_clean\e[0;36m )$(COLOR_END)\n"
	@j=0; for i in $(UTILS); do echo -ne " ???  $(COLOR_CYAN)"; printf %-30s $$i; echo -ne "$(COLOR_END)"; j=`expr $$j + 1`; if test `expr $$j % 2` == 0;then echo -ne "\n";else echo -ne "\t";fi done
	@echo -e "\n----------------------Projects List END-----------------------"
	@echo -e "$(COLOR_RED)Help:$(COLOR_END)"
	@echo -e " -- $(COLOR_RED)make build $(COLOR_END)to build image from source code"
	@echo -e " -- $(COLOR_RED)make clean $(COLOR_END)to clean all"
	@echo -e " -- $(COLOR_RED)make image $(COLOR_END)just packing image file"
	@echo -e " -- $(COLOR_RED)make [project name] $(COLOR_END)build one specific project"
	@echo -e " -- $(COLOR_RED)make [project name]_clean $(COLOR_END)clean one specific project"

#build the project by Eclipse
ifeq ("$(shell echo $$ECLIPSE)","yes")
eclipse_build:
	@ chmod +x $(BASE)/G4_Builder/scripts/*
	@ $(MAKE) -C $(BASE)/G4_Builder/scripts fs
	@ $(MAKE) -C $(proj_usb_port_reset) all
	@ $(MAKE) -C $(proj_imtool) all

eclipse_clean:
	@ $(MAKE) -C G4_Builder/scripts clean
	@ $(MAKE) -C $(proj_usb_port_reset) clean
	@ $(MAKE) -C $(proj_imtool) clean

#To build the image.
eclipse_image:
	@ $(MAKE) -C G4_Builder/scripts image

eclipse_dummy:

.PHONY: eclipse_build eclipse_clean eclipse_image eclipse_dummy
endif

#To build the build information of project to console and log file.
print_build_info = \
	echo -e "\n$(COLOR_GREEN)********************************************************************$(COLOR_END)"; \
	echo -e "$(COLOR_GREEN)** Build $1 : $(shell date -R)$(COLOR_END)"; \
	echo -e "$(COLOR_GREEN)********************************************************************$(COLOR_END)"; \
	echo -e "*-----------------------------------------------------------">>$(LOG_FILE); \
	echo -e "* Build $1:$(shell date -R)"                             >>$(LOG_FILE); \
	echo -e "*-----------------------------------------------------------">>$(LOG_FILE)

#To build the clean information of project to console and log file.
print_clean_info = \
	echo -e "$(COLOR_RED)---------------------------- $(1) ----------------------------$(COLOR_END)"; \
	echo -e "$---------------------------- $(1) ----------------------------">>$(LOG_FILE)

#init the log file.
init_log = \
	@ if [ "$(MAKECMDGOALS)" = "$@" ]; then \
	echo > $(LOG_FILE); \
	fi

#To build the dependency of project.
build_dep = $(OUTPUT_FILE) \
	if [ "$(MAKECMDGOALS)" = "$@" ]; then \
		$(MAKE) -C $(BASE)/G4_Builder/scripts fs; \
		$(foreach dep,$(depend_$(notdir $(patsubst %,%,$@))), \
		$(call print_build_info,$(dep)); \
		$(MAKE) -C $(call gethome,$(patsubst %,%,$(dep))) -f $(call getmake,$(patsubst %,%,$(dep))) all $($(patsubst %,%,$(dep))_params); \
		if [ $$? -ne 0 ]; then echo -e "\t$(COLOR_RED)Dependency Prj:$(dep) Build Failed!!!!$(COLOR_END)\n"; exit 1;fi;) \
	fi;

#To clean the dependency of project.
clean_dep = $(OUTPUT_FILE) \
	if [ "$(MAKECMDGOALS)" = "$@" ]; then\
		echo > $(LOG_FILE); \
		$(foreach dep,$(depend_$(notdir $(patsubst %_clean,%,$@))), \
		$(call print_clean_info,$(dep)); \
		$(MAKE) -C $(call gethome,$(patsubst %_clean,%,$(dep))) -f $(call getmake,$(patsubst %_clean,%,$(dep))) clean $($(patsubst %_clean,%,$(dep))_params); \
		if [ $$? -ne 0 ]; then echo -e "\t$(COLOR_RED)Dependency Prj:$(dep) Clean Failed!!!!$(COLOR_END)\n"; fi;) \
	fi

#To record the start time of compile.
starttimer = @ echo $(shell date +%s.%N) > $(BUILD_TMP_FOLDER)/$1.tmstmp

#To end the timer; Compute the time of compile and write to the console the file.
endtimer = $(OUTPUT_FILE) \
	srt=`cat $(BUILD_TMP_FOLDER)/$1.tmstmp`; \
	end=`date +%s.%N`; \
	echo -e "\n$(COLOR_LIGHT_GREEN)@@@@@@ Build $1 Finished (took \
	$$[1000*$$[$$(echo $$end|cut -d '.' -f 1)-$$(echo $$srt|cut -d '.' -f 1)] \
	+ $$[10\#$$(echo $$end|cut -d '.' -f 2)-10\#$$(echo $$srt|cut -d '.' -f 2)]/1000000] \
	ms) @@@@@@@@$(COLOR_END)\n">&2
