
include $(BASE)/mkEnv.mk



#define project target value.
TARGET_PREFIX := test1
PROJECT_TARGET := $(TARGET_PREFIX)
PROJECT_MAP := $(TARGET_PREFIX).map
PROJECT_DES_PATH := $(PROGRAM_PATH)


#append the complain used resource.
PROJECT_IFLAGS = $(IFLAGS) -I./sub/ -I$(BASE)/library-prjs/libCom/include
PROJECT_CFLAGS = $(CFLAGS) 
PROJECT_LDFLAGS = $(LDFLAGS)  -L/$(LIB_SHARE_PATH)  -lCom 


#get the soruce code resource.
PROJECT_SRC = $(wildcard ./*.c) $(wildcard ./sub/*.c)
PROJECT_DEPENDS =$(patsubst %.c,%.o,$(PROJECT_SRC))



#start buidl steps:
all:$(PROJECT_TARGET)
	@echo -e "INSTALL - $(PROJECT_TARGET)\nINSTALL - $(PROJECT_MAP)"
	@mkdir -p $(PROJECT_DES_PATH)
	@cp -f $(PROJECT_TARGET) $(PROJECT_DES_PATH)
	@mkdir -p $(MAP_FILE_PATH)
	@cp -f $(PROJECT_MAP) $(MAP_FILE_PATH)


$(PROJECT_TARGET):$(PROJECT_DEPENDS)
	@echo -e "Buidling target -- $@"
	@echo $(notdir $(basename $@))
	$(CC) -o $@ $^ $(PROJECT_LDFLAGS)
	$(STRIP) -s $(PROJECT_TARGET)

%.o:%.c
	@echo -e "Complain the Obj -- $@"
	$(CC) $(PROJECT_CFLAGS)  $(PROJECT_IFLAGS) -c -o $@ $<

.PHONY:clean
clean:
	@echo "Clean "$(PROJECT_TARGET)
	@rm -rf $(PROJECT_DEPEND)
	@find ./ \( -name "*.o" -o -name "*.d" \) -exec rm -rf '{}' \;
	@rm -rf $(PROJECT_MAP) $(PROJECT_TARGET)


-include $(PROJECT_DEPEND:.o=.d)