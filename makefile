#------------------------------------------------------------------------------#
# Files and directiries                                                        #
#------------------------------------------------------------------------------#
SOURCE_DIR          := src
RESULT_DIR          := res

PROTO_FILE          := $(SOURCE_DIR)/proto.py
MAIN_FILE           := $(SOURCE_DIR)/code.ml
MAIN_ROT_FILE       := $(SOURCE_DIR)/codeRotation.ml

RES_PROTO_FILE      := $(RESULT_DIR)/proto.txt
RES_MAIN_FILE       := $(RESULT_DIR)/code.txt
RES_MAIN_ROT_FILE   := $(RESULT_DIR)/codeRotation.txt

#------------------------------------------------------------------------------#
# Commands                                                                     #
#------------------------------------------------------------------------------#
.PHONY : all, clean, re, proto, main, main_rot
all : main main_rot
clean : $(RESULT_DIR)
	@rm -rv $(RESULT_DIR)
re : clean
	@make

proto : $(RES_PROTO_FILE)
	@echo "proto : Done!"
	@echo "Result in $(RESULT_DIR)"
main : $(RES_MAIN_FILE)
	@echo "main version : Done!"
	@echo "Result in $(RESULT_DIR)"
main_rot : $(RES_MAIN_ROT_FILE)
	@echo "main version (with rotations) : Done!"
	@echo "Result in $(RESULT_DIR)"

#------------------------------------------------------------------------------#
# Dependencies                                                                 #
#------------------------------------------------------------------------------#
$(RES_PROTO_FILE) : $(PROTO_FILE)
	@mkdir -pv $(dir $@)
	@time python3 $< > $@
$(RES_MAIN_FILE) : $(MAIN_FILE)
	@mkdir -pv $(dir $@)
	@time ocaml $< > $@
$(RES_MAIN_ROT_FILE) : $(MAIN_ROT_FILE)
	@mkdir -pv $(dir $@)
	@time ocaml $< > $@
