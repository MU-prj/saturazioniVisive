# Nome dell'ambiente virtuale (modificabile)
VENV_NAME = venv
PYTHON = python3
PIP = $(VENV_NAME)/bin/pip

# Target principale - mostra la guida
help:
	@echo "Comandi disponibili:"
	@echo "  make init        - Crea virtual environment e installa requirements"
	@echo "  make install     - Installa pacchetti da requirements.txt"
	@echo "  make activate    - Attiva virtual environment (consiglio: esegui manualmente 'source $(VENV_NAME)/bin/activate')"
	@echo "  make update      - Aggiorna pip e pacchetti"
	@echo "  make clean       - Rimuove virtual environment e cache"
	@echo "  make sync        - Operazioni Git (add, commit, pull, push)"
	@echo "  make status      - Mostra stato dell'ambiente"

# Inizializza tutto l'ambiente
init:
	@echo "Creazione virtual environment..."
	$(PYTHON) -m venv $(VENV_NAME)
	@echo "Installazione dipendenze..."
	$(MAKE) install
	@echo ""
	@echo "Ambiente pronto! Attiva con:"
	@echo "  source $(VENV_NAME)/bin/activate"

# Installa le dipendenze
install: $(VENV_NAME)/bin/activate
	$(PIP) install --upgrade pip
	@if [ -f requirements.txt ]; then \
		$(PIP) install -r requirements.txt; \
		echo "Requirements installati."; \
	else \
		echo "requirements.txt non trovato. Creane uno con le tue dipendenze."; \
	fi

# Target per attivazione (solo promemoria)
activate:
	@echo "Per attivare l'ambiente virtuale, esegui MANUALMENTE:"
	@echo "  source $(VENV_NAME)/bin/activate"
	@echo ""
	@echo "Oppure su Windows:"
	@echo "  $(VENV_NAME)\\Scripts\\activate"

# Aggiorna l'ambiente
update:
	$(PIP) install --upgrade pip
	@if [ -f requirements.txt ]; then \
		$(PIP) install --upgrade -r requirements.txt; \
	fi

# Pulisce l'ambiente
clean:
	@echo "Rimozione virtual environment..."
	rm -rf $(VENV_NAME)
	rm -rf __pycache__
	rm -rf .pytest_cache
	rm -rf .mypy_cache
	find . -type d -name "__pycache__" -exec rm -rf {} +
	find . -type f -name "*.pyc" -delete
	@echo "Pulizia completata."

# Mostra lo stato dell'ambiente
status:
	@echo "=== STATO AMBIENTE ==="
	@if [ -d "$(VENV_NAME)" ]; then \
		echo "✓ Virtual environment presente: $(VENV_NAME)"; \
		echo "  Percorso: $(shell pwd)/$(VENV_NAME)"; \
		echo ""; \
		echo "Pacchetti installati:"; \
		$(PIP) list | head -20; \
	else \
		echo "✗ Virtual environment NON presente"; \
	fi
	@echo ""
	@echo "Per attivare: source $(VENV_NAME)/bin/activate"

# I tuoi comandi Git esistenti
sync:
	git add .
	git commit -m "."
	git pull --quiet
	git push

# Target fittizi
.PHONY: help init install activate update clean status sync