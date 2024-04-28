#------------------------------------------------------------------------------#
# Files and directiries                                                        #
#------------------------------------------------------------------------------#
SOURCE_DIR          := src
RESULT_DIR          := res

PROTO_FILE          := $(SOURCE_DIR)/proto.py
MAIN_FILE           := $(SOURCE_DIR)/code.ml
ALT_V1_FILE         := $(SOURCE_DIR)/codeRotation.ml

RES_PROTO_FILE      := $(RESULT_DIR)/proto.txt
RES_MAIN_FILE       := $(RESULT_DIR)/code.txt
RES_ALT_V1_FILE     := $(RESULT_DIR)/codeRotation.txt

#------------------------------------------------------------------------------#
# Commands                                                                     #
#------------------------------------------------------------------------------#
.PHONY : all, clean, re, proto, main, alt_v1
all : main
	@echo "  Other available targets:"
	@echo "   -> proto (prototype using python, very long)"
	@echo "   -> alt_v1 (alternative version checking all rotations)"
clean : $(RESULT_DIR)
	@rm -rv $(RESULT_DIR)
re : clean
	@make

proto : $(RES_PROTO_FILE)
	@echo "Done!"
	@echo "Result in $(RESULT_DIR)"
main : $(RES_MAIN_FILE)
	@echo "Done!"
	@echo "Result in $(RESULT_DIR)"
alt_v1 : $(RES_ALT_V1_FILE)
	@echo "Done!"
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
$(RES_ALT_V1_FILE) : $(ALT_V1_FILE)
	@mkdir -pv $(dir $@)
	@time ocaml $< > $@
