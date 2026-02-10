"use client"

import { Scale } from "lucide-react"
import {
  SidebarMenu,
  SidebarMenuItem,
} from "@/components/ui/sidebar"

export function SidebarLogo() {
  return (
    <SidebarMenu>
      <SidebarMenuItem>
        <div className="flex items-center gap-2 px-4 py-2 group-data-[collapsible=icon]:px-2 group-data-[collapsible=icon]:justify-center">
          {/* Icon - always visible */}
          <div className="flex h-8 w-8 shrink-0 items-center justify-center rounded-lg bg-brand-blue text-white">
            <Scale className="h-4 w-4" />
          </div>

          {/* Text - hidden when collapsed */}
          <span className="font-heading text-sm font-semibold text-sidebar-foreground transition-all group-data-[collapsible=icon]:hidden">
            Diego Barbosa
          </span>
        </div>
      </SidebarMenuItem>
    </SidebarMenu>
  )
}
