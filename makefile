deps:
	ansible-galaxy install -r requirements.yml
zfs:
	ansible-playbook main.yml -i hosts.yml -e @vault.yml --ask-vault-pass --tags zfs
encrypt_string:
	$(info IMPORTANT: press ctrl-d twice after entering your string (do not press enter or a newline will be added to your string))
	ansible-vault encrypt_string --ask-vault-pass
vault:
	ansible-vault encrypt vault.yml
install:
	ansible-playbook main.yml -i hosts.yml -e @vault.yml --ask-vault-pass --tags install
test:
	ansible-playbook main.yml -i hosts.yml -e @vault.yml --ask-vault-pass --tags test
