# had an old one with amixer and awk and stuff but i had issues with my audio sources on my pc, so this uses pamixer instead

echo $(pamixer --get-volume)% 
