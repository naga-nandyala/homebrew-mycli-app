"""Verify the MSAL PR #926 Intel-Mac broker gate in the *shipped* azure-cli msal.

Constructs a PublicClientApplication with broker enabled -- the exact broker
decision that ``az login`` performs -- fully offline, with no interactive or
device-code login.

GitHub no longer offers free Intel (x86_64) macOS runners, so set
``AZ_TEST_FORCE_MACHINE=x86_64`` to simulate an Intel host: it overrides
``platform.machine()`` (the single input the gate branches on) so the Intel
branch of the *unmodified* shipped application.py runs. On a real Intel host
the override is a harmless no-op.

Pass criteria (both required):
  1. ``app._enable_broker`` is False after construction.
  2. msal logged "Broker is not supported on Intel-based Macs.".
"""

import io
import logging
import os
import platform
import sys

SENTINEL = "Broker is not supported on Intel-based Macs."
FAKE_CLIENT_ID = "00000000-0000-0000-0000-000000000000"


def main() -> int:
    real_machine = platform.machine()
    forced = os.environ.get("AZ_TEST_FORCE_MACHINE")
    if forced:
        platform.machine = lambda: forced  # noqa: E731 - simulate CPU arch
    effective = platform.machine()

    print(f"real platform.machine()        = {real_machine}")
    print(f"forced (AZ_TEST_FORCE_MACHINE) = {forced or '(none)'}")
    print(f"effective platform.machine()   = {effective}")
    print(f"sys.platform                   = {sys.platform}")

    if sys.platform != "darwin":
        print("ERROR: this check must run on macOS (sys.platform=='darwin')", file=sys.stderr)
        return 2
    if effective not in ("x86_64", "i386"):
        print(
            "ERROR: effective machine is not Intel; set AZ_TEST_FORCE_MACHINE=x86_64 "
            f"to simulate (got {effective!r})",
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
        print("FAIL: broker was NOT disabled on (simulated) Intel Mac", file=sys.stderr)
        return 1
    if SENTINEL not in logs:
        print(f"FAIL: expected warning not logged: {SENTINEL!r}", file=sys.stderr)
        return 1

    print("PASS: PR #926 Intel-Mac gate disabled broker and logged the fallback warning")
    return 0


if __name__ == "__main__":
    sys.exit(main())
