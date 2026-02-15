"use client";

import { createContext, useContext, useEffect, useState } from "react";
import { getPublicEnv } from "@/lib/env-runtime";

type EnvContextType = {
  NEXT_PUBLIC_SUPABASE_URL?: string;
  NEXT_PUBLIC_SUPABASE_PUBLISHABLE_OR_ANON_KEY?: string;
  NEXT_PUBLIC_DYTE_ORG_ID?: string;
};

const EnvContext = createContext<EnvContextType>({});

export function EnvProvider({ children }: { children: React.ReactNode }) {
  const [env, setEnv] = useState<EnvContextType>({});

  useEffect(() => {
    getPublicEnv().then((envVars) => {
      setEnv(envVars);
    });
  }, []);

  return <EnvContext.Provider value={env}>{children}</EnvContext.Provider>;
}

export const usePublicEnv = () => {
  return useContext(EnvContext);
};
