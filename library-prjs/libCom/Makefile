include $(BASE)/mkEnv.mk



#define project target value.
TARGET_PREFIX := libCom
PROJECT_TARGET := $(TARGET_PREFIX).so
PROJECT_MAP := $(TARGET_PREFIX).map
PROJECT_DES_PATH := $(LIB_SHARE_PATH)

#compile option:
#append the complain used resource.
PROJECT_IFLAGS = $(IFLAGS) -I./include
PROJECT_CFLAGS = $(CFLAGS) -fPIC
PROJECT_LDFLAGS = $(LDFLAGS) -shared


#get the soruce code resource.
PROJECT_SRC = $(wildcard ./src/*.c)
PROJECT_DEPENDS =$(patsubst %.c,%.o,$(PROJECT_SRC))



#start buidl steps:
all:$(PROJECT_TARGET)
	@echo -e "INSTALL --->$(PROJECT_TARGET)<--- to $(PROJECT_INSTALL_PATH)"
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
	@rm -rf $(PROJECT_DEPENDS)
	@find ./ \( -name "*.o" -o -name "*.d" \) -exec rm -rf '{}' \;
	@rm -rf $(PROJECT_MAP) $(PROJECT_TARGET)


-include $(PROJECT_DEPEND:.o=.d)