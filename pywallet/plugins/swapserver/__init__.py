from pywallet.i18n import _

fullname = _('SwapServer')
description = """
Submarine swap server for an Pywallet daemon.

Example setup:

  pywallet -o setconfig enable_plugin_swapserver True
  pywallet -o setconfig swapserver_port 5455
  pywallet daemon -v

"""

available_for = ['cmdline']
