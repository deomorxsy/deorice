INSTALL_ROOT_DIR:="./neovim-artifacts"
NVIM_HEADLESS:=nvim --headless --noplugin -u tests/sample-init.vim


dependencies:
	git clone --depth 1 https://github.com/deomorxsy/kjxf.nvim ./assets/

.PHONY: clean_dependencies
clean_dependencies:
	rm -rf dependencies

.PHONY: clean_fixtures
clean_fixtures:
	echo "hmm..."

.PHONY: clean
clean: clean_fixtures clean_dependencies

.PHONY: test
test: clean_fixtures dependencies
	INSTALL_ROOT_DIR=${INSTALL_ROOT_DIR} $(NVIM_HEADLESS) -c "call RunTests()"

