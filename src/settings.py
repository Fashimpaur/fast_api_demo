# src/settings.py

CONTROLLER_CONFIG = {
    "backend_controller": {
        "module": "backend.controller",  # maps to src/backend/controler.py
        "port": 8080,
    },
    "frontend_controller": {
        "module": "frontend.controller",  # maps to src/frontend/other_controller.py
        "port": 8081,
    }
}
