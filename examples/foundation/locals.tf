locals {

  asg_schedules = {
    scale_in_recurrence  = "0 01 * * *"
    scale_in_count       = 0
    scale_out_recurrence = "0 12 * * 1-5"
    scale_out_count      = 1
  }

}
