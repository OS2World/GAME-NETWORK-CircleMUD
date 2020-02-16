/* */

say "Purging playerfile, please wait..."
"cd lib/misc"
"echo "DATE()" >> DELETED"
"../../bin/purgeplay players >> DELETED"
if stream("players.new","c","query exists")="" then do
   "move players players.old >&nul"
   "move players.new players >&nul"
end
say "Done."

"cd ../plrobjs"
call purgeobjs
"cd ..\.."

