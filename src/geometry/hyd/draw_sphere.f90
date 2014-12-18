! Spherical obstacle
subroutine draw_sphere
  use mpi
  use fsi_vars
  use penalization ! mask array etc
  implicit none

  integer :: ix, iy, iz
  real (kind=pr) :: x, y, z, tmp, R, N_smooth

  N_smooth = 1.5d0

  do iz=ra(3),rb(3)
    do iy=ra(2),rb(2)
      do ix=ra(1),rb(1) 
        x=dble(ix)*dx
        y=dble(iy)*dy
        z=dble(iz)*dz
        R = dsqrt( (x-x0)**2 + (y-y0)**2 + (z-z0)**2 )
        if ( R <= 0.5d0*length+2.d0*N_smooth*max(dx,dy,dz) ) then
          call SmoothStep (tmp, R, 0.5d0*length , N_smooth*max(dx,dy,dz))
          mask (ix, iy, iz) = tmp

          ! assign color "1" where >0 indicates something "useful"
          if (tmp > 1.0e-12) mask_color(ix,iy,iz) = 1
        endif
      enddo
    enddo
  enddo
end subroutine draw_sphere


! draws a circular cylinder, the axis is the x-axis (then it can be used for 2D
! runs as well)
subroutine draw_cylinder_x
  use mpi
  use fsi_vars
  use penalization ! mask array etc
  implicit none

  integer :: ix, iy, iz
  real (kind=pr) :: x, y, z, tmp, R, N_smooth

  N_smooth = 1.5d0

  do iz=ra(3),rb(3)
    do iy=ra(2),rb(2)
      do ix=ra(1),rb(1) 
        y=dble(iy)*dy
        z=dble(iz)*dz
        R = dsqrt( (y-y0)**2 + (z-z0)**2 )
        if ( R <= 0.5d0*length+2.d0*N_smooth*max(dx,dy,dz) ) then
          call SmoothStep (tmp, R, 0.5d0*length , N_smooth*max(dx,dy,dz))
          mask (ix, iy, iz) = tmp
          us(ix,iy,iz,1) = 0.d0
          us(ix,iy,iz,2) = 0.d0
          us(ix,iy,iz,3) = 0.d0

          ! assign color "1" where >0 indicates something "useful"
          if (tmp > 1.0e-12) mask_color(ix,iy,iz) = 1
        endif
      enddo
    enddo
  enddo
end subroutine draw_cylinder_x


