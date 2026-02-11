"use client"

import Image from "next/image"
import {
  SidebarMenu,
  SidebarMenuItem,
} from "@/components/ui/sidebar"

export function SidebarLogo() {
  return (
    <SidebarMenu>
      <SidebarMenuItem>
        <div className="flex items-center gap-2 px-4 py-3 group-data-[collapsible=icon]:px-2 group-data-[collapsible=icon]:justify-center">
          <Image
            src="/logos/logo-dark.svg"
            alt="Diego Barbosa"
            width={32}
            height={32}
            className="h-8 w-8 shrink-0"
            priority
          />
          <span className="font-heading text-sm font-semibold text-sidebar-foreground transition-all group-data-[collapsible=icon]:hidden">
            Diego Barbosa OS
          </span>
        </div>
      </SidebarMenuItem>
    </SidebarMenu>
  )
}
