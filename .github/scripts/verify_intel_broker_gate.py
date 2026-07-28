"""Verify the MSAL PR #926 Intel-Mac broker gate in the *shipped* azure-cli msal.

Constructs a PublicClientApplication with broker enabled -- the exact broker
decision that ``az login`` performs -- fully offline, with no interactive or
device-code login. No mocking: this must run on genuine Intel (x86_64) macOS
hardware so ``platform.machine()`` naturally reports an Intel arch.

Pass criteria (both required):
  1. ``app._enable_broker`` is False after construction.
  2. msal logged "Broker is not supported on Intel-based Macs.".
"""

import io
import logging
import platform
import sys

SENTINEL = "Broker is not supported on Intel-based Macs."
FAKE_CLIENT_ID = "00000000-0000-0000-0000-000000000000"


def main() -> int:
    machine = platform.machine()
    print(f"platform.machine() = {machine}")
    print(f"sys.platform       = {sys.platform}")

    if sys.platform != "darwin":
        print("ERROR: this check must run on macOS (sys.platform=='darwin')", file=sys.stderr)
        return 2
    if machine not in ("x86_64", "i386"):
        print(
            f"ERROR: expected genuine Intel hardware, got machine={machine!r}. "
            "Run this job on a real Intel runner (e.g. macos-15-intel).",
            file=sys.stderr,
        )
        return 2

    import msal
    import msal.application as application

    print(f"msal version : {msal.__version__}")
    print(f"msal file    : {application.__file__}")

    # Capture msal WARNING-level logs.
    stream = io.StringIO()
    handler = logging.StreamHandler(stream)
    handler.setLevel(logging.WARNING)
    msal_logger = logging.getLogger("msal")
    msal_logger.addHandler(handler)
    msal_logger.setLevel(logging.WARNING)

    # instance_discovery=False keeps construction fully offline.
    app = msal.PublicClientApplication(
        FAKE_CLIENT_ID,
        enable_broker_on_mac=True,
        instance_discovery=False,
    )

    enabled = getattr(app, "_enable_broker", None)
    logs = stream.getvalue().strip()

    print(f"app._enable_broker = {enabled}")
    print("---- captured msal warnings ----")
    print(logs or "(none)")
    print("--------------------------------")

    if enabled is not False:
        print("FAIL: broker was NOT disabled on Intel Mac", file=sys.stderr)
        return 1
    if SENTINEL not in logs:
        print(f"FAIL: expected warning not logged: {SENTINEL!r}", file=sys.stderr)
        return 1

    print("PASS: PR #926 Intel-Mac gate disabled broker and logged the fallback warning")
    return 0


if __name__ == "__main__":
    sys.exit(main())
