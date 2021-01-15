include $(BASE)/mkEnv.mk



#define project target value.
TARGET_PREFIX := libCom
PROJECT_TARGET := $(TARGET_PREFIX).so
PROJECT_MAP := $(TARGET_PREFIX).map
PROJECT_DES_PATH := $(LIB_SHARE_PATH)


#append the complain used resource.
PROJECT_IFLAGS = $(IFLAGS) -I./include
PROJECT_CFLAGS = $(CFLAGS) -fPIC
PROJECT_LDFLAGS = $(LDFLAGS) -shared


#get the soruce code resource.
PROJECT_SRC = $(wildcard ./src/*.c)
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

%.o:%.c
	@echo -e "Complain the Obj -- $@"
	$(CC) $(PROJECT_CFLAGS)  $(PROJECT_IFLAGS) -c -o $@ $<

clean:
	@echo "Clean $(PROJECT_TARGET)"
	@find ./ \( -name "*.o" -o -name "*.d" \) -exec rm -f '{}' \;
	@rm -f $(PROJECT_MAP) $(PROJECT_TARGET)


-include $(PROJECT_DEPEND:.o=.d)