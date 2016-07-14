# Project prefix
PREFIX = cba
# Build location
BIN = @CBA_A3
# Name of the zipped release package
ZIP = CBA_A3
# Path to directory that contains included Arma 3 files
ARMA = include
# armake flags (-i include -w disable certain warnings) - defined again for filepatching build below
FLAGS = -i $(ARMA) -w unquoted-string -w redefinition-wo-undef

MAJOR = $(shell grep "^\#define[[:space:]]*MAJOR" addons/main/script_mod.hpp | egrep -m 1 -o '[[:digit:]]+')
MINOR = $(shell grep "^\#define[[:space:]]*MINOR" addons/main/script_mod.hpp | egrep -m 1 -o '[[:digit:]]+')
PATCH = $(shell grep "^\#define[[:space:]]*PATCHLVL" addons/main/script_mod.hpp | egrep -m 1 -o '[[:digit:]]+')
BUILD = $(shell grep "^\#define[[:space:]]*BUILD" addons/main/script_mod.hpp | egrep -m 1 -o '[[:digit:]]+')
VERSION = v$(MAJOR).$(MINOR).$(PATCH).$(BUILD)

$(BIN)/addons/$(PREFIX)_%.pbo: addons/%
	@mkdir -p $(BIN)/addons
	@echo "  PBO  $@"
	@armake build ${FLAGS} -f $< $@

$(BIN)/optionals/$(PREFIX)_%.pbo: optionals/%
	@mkdir -p $(BIN)/optionals
	@echo "  PBO  $@"
	@armake build ${FLAGS} -f $< $@

# Shortcut for building single addons (eg. "make <component>.pbo")
%.pbo:
	make $(patsubst %, $(BIN)/addons/$(PREFIX)_%, $@)

all: $(patsubst addons/%, $(BIN)/addons/$(PREFIX)_%.pbo, $(wildcard addons/*)) \
		$(patsubst optionals/%, $(BIN)/optionals/$(PREFIX)_%.pbo, $(wildcard optionals/*))

filepatching:
	make FLAGS="-i $(ARMA) -w unquoted-string -w redefinition-wo-undef -p"

$(BIN)/keys/%.biprivatekey:
	@mkdir -p $(BIN)/keys
	@echo "  KEY  $@"
	@armake keygen -f $(patsubst $(BIN)/keys/%.biprivatekey, $(BIN)/keys/%, $@)

$(BIN)/addons/$(PREFIX)_%.pbo.$(PREFIX)_$(VERSION).bisign: $(BIN)/addons/$(PREFIX)_%.pbo $(BIN)/keys/$(PREFIX)_$(VERSION).biprivatekey
	@echo "  SIG  $@"
	@armake sign -f $(BIN)/keys/$(PREFIX)_$(VERSION).biprivatekey $<

$(BIN)/optionals/$(PREFIX)_%.pbo.$(PREFIX)_$(VERSION).bisign: $(BIN)/optionals/$(PREFIX)_%.pbo $(BIN)/keys/$(PREFIX)_$(VERSION).biprivatekey
	@echo "  SIG  $@"
	@armake sign -f $(BIN)/keys/$(PREFIX)_$(VERSION).biprivatekey $<

signatures: $(patsubst addons/%, $(BIN)/addons/$(PREFIX)_%.pbo.$(PREFIX)_$(VERSION).bisign, $(wildcard addons/*)) \
		$(patsubst optionals/%, $(BIN)/optionals/$(PREFIX)_%.pbo.$(PREFIX)_$(VERSION).bisign, $(wildcard optionals/*))

clean:
	rm -rf $(BIN) $(ZIP)_*.zip

release: clean signatures
	@rm $(BIN)/keys/*.biprivatekey
	@echo "  ZIP  $(ZIP)_$(VERSION).zip"
	@cp LICENSE.md logo_cba_ca.paa mod.cpp README.md $(BIN)
	@zip -r $(ZIP)_$(VERSION).zip $(BIN) &> /dev/null

.PHONY: release
