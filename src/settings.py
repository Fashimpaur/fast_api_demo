# src/settings.py

CONTROLLER_CONFIG = {
    "backend_controller": {
        "module": "backend.controller",  # maps to src/backend/controller.py
        "port": 8080,
    },
    "frontend_controller": {
        "module": "frontend.controller",  # maps to src/frontend/controller.py
        "port": 8081,
    }
}
