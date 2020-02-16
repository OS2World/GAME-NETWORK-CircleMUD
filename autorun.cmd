/* CircleMUD 2.0 autorun script
 * Originally by Fred C. Merkel
 * Copyright (c) 1993 The Trustees of The Johns Hopkins University
 * All Rights Reserved
 * See license.doc for more information
 *
 * If .fastboot exists, the script will sleep for only 5 seconds between
 * reboot attempts.  If .killscript exists, the script commit suicide (and
 * remove .killscript).  If pause exists, the script will repeatedly sleep for
 *  60 seconds and will not restart the mud until pause is removed.
 */

PORT=4000
FLAGS=''

call RxFuncAdd "SysLoadFuncs", "RexxUtil", "SysLoadFuncs"
call SysLoadFuncs

Do While 1=1
  Say "autoscript starting game "DATE()
  "echo autoscript starting game "DATE()" >> syslog"

  "bin\circle" FLAGS PORT ">>& syslog"

  'find "self-delete" syslog >> log\delete'
  'find "death trap" syslog >> log\dts'
  'find "killed" syslog >> log\rip'
  'find "Running" syslog >> log\restarts'
  'find "advanced" syslog >> log\levels'
  'find "equipment lost" syslog >> log\rentgone'
  'find "usage" syslog >> log\usage'
  'find "new player" syslog >> log\newplayers'
  'find "SYSERR" syslog >> log\errors'
  'find "(GC)" syslog >> log\godcmds'
  'find "Bad PW" syslog >> log\badpws'

  "del log\syslog.1 >&nul"
  "move log\syslog.2 log\syslog.1 >&nul"
  "move log\syslog.3 log\syslog.2 >&nul"
  "move log\syslog.4 log\syslog.3 >&nul"
  "move log\syslog.5 log\syslog.4 >&nul"
  "move log\syslog.6 log\syslog.5 >&nul"
  "move syslog       log\syslog.6 >&nul"
  Call Charout syslog

  Do while stream("pause","c","query exists")<>""
    Say "Pausing..."
    Call SysSleep(10)
  end

  if (stream("fastboot","c","query exists")="") then do
    Say "Waiting 40 seconds to reboot"
    Call SysSleep(40)
  end
  else do
    "del fastboot"
    Say "Waiting 5 seconds to reboot"
    Call SysSleep(5)
  end

  if (stream("killscr","c","query exists")<>"") then do
    Say "Exiting autorun"
    "echo autoscript killed "DATE() ">> syslog"
    "del killscr"
    exit
  end

end


