variable "resource_group_name" {
    type = string
    default= "web-app-rg"
}
variable "resource_group_location"{
    type = string
    default= "East Us"
}
variable "app_service_plan_id" {
    type = string
    default= "asp"

}
variable "acr_name" {
    type = string
    default= "bannACR"

}
variable "app_service_name" {
    type = string
    default= "bannwebapp"

}
variable "app_service_plan_name" {
    type = string
    default= "bannWebappPlan"

}