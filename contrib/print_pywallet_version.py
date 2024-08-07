#!/usr/bin/python3
# For usage in shell, to get the version of pywallet, without needing pywallet installed.
# usage: ./print_pywallet_version.py [<attr_name>]
#
# For example:
# $ VERSION=$("$CONTRIB"/print_pywallet_version.py)
# $ VERSION=$("$CONTRIB"/print_pywallet_version.py APK_VERSION)
# instead of
# $ VERSION=$(python3 -c "import pywallet; print(pywallet.version.PYWALLET_VERSION)")
# $ VERSION=$(python3 -c "import pywallet; print(pywallet.version.APK_VERSION)")

import importlib.util
import os
import sys


if __name__ == '__main__':
    if len(sys.argv) >= 2:
        attr_name = sys.argv[1]
    else:
        attr_name = "PYWALLET_VERSION"

    project_root = os.path.abspath(os.path.dirname(os.path.dirname(__file__)))
    version_file_path = os.path.join(project_root, "pywallet", "version.py")

    # load version.py; needlessly complicated alternative to "imp.load_source":
    version_spec = importlib.util.spec_from_file_location('version', version_file_path)
    version_module = version = importlib.util.module_from_spec(version_spec)
    version_spec.loader.exec_module(version_module)

    attr_val = getattr(version, attr_name)
    print(attr_val, file=sys.stdout)

