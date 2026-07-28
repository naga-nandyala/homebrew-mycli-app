"""Verify the MSAL PR #926 Intel-Mac broker gate in the *shipped* azure-cli msal.

Run on an Intel (x86_64) macOS host, using the msal that ships inside the
installed azure-cli cask (via PYTHONPATH). This exercises the exact broker
decision that ``az login`` performs -- constructing a PublicClientApplication
with broker enabled -- but headlessly, with no interactive/device-code login.

Pass criteria (both required):
  1. ``app._enable_broker`` is False after construction on Intel.
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
    if machine not in ("x86_64", "i386"):
        print(f"ERROR: expected an Intel runner, got {machine!r}", file=sys.stderr)
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

    # This is the broker-decision path az login runs; instance_discovery=False
    # keeps it fully offline (no network, no device code).
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
