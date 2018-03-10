silent! se guifont=Inconsolata:h15
se go-=e "remove native tab pages
se go-=r "remove permenant right scrollbar
se go-=L "remove some other scrollbar

if strftime("%H") < 17
  silent! colo base16-atelier-forest-light
else
  silent! colo base16-solarflare
endif
