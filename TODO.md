## 2016-02-25

- In Vedeu::XCoordinate and Vedeu::YCoordinate, rename #d_dn to
  #bd_bdn
- Add new #d_dn to Vedeu::XCoordinate and Vedeu::YCoordinate.
- Rename all private instance variables used for memoization from
  '@...' to '@_...'.

## 2016-01-16

- Add Vedeu::Index which converts a Vedeu::Point to an array index.
  i.e. Never less than 0, always 1 less than the Vedeu::Point value.

## 2016-01-11

- Investigate the differences between memoizing in
  Vedeu::Geometries::Geometry#area and not memoizing. Memoizing saves
  ~80ms on running test suite and considerably impacts app
  responsiveness, however changes to the geometry (such as movement or
  maximising) are not reflected.
