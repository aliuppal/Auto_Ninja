-- A fill-up can be paid partly by the fuel card and partly by the driver ("split").
-- card_liters is the card's share in liters; the rest of the fill-up is paid by the
-- driver, and the amount paid is shared in the same ratio.

alter table public.fuel_fillups drop constraint if exists fuel_fillups_paid_by_check;
alter table public.fuel_fillups
  add constraint fuel_fillups_paid_by_check check (paid_by in ('card', 'self', 'split'));

alter table public.fuel_fillups
  add column card_liters numeric(8, 3)
  check (card_liters is null or (card_liters >= 0 and (liters is null or card_liters <= liters)));
