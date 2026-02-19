import { redirect } from "next/navigation";
import Link from "next/link";
import { PageShell } from "@/components/shared/page-shell";
import { Button } from "@/components/ui/button";
import { actionObterMetricasDB } from "@/features/admin";
import { MetricasDBContent } from "./components/metricas-db-content";

export const dynamic = 'force-dynamic';

export default async function MetricasDBPage() {
  const result = await actionObterMetricasDB();

  if (!result.success) {
    if (result.error?.includes("Acesso negado")) {
      redirect("/app/dashboard");
    }

    return (
      <PageShell title="Métricas do Banco de Dados">
        <div className="text-destructive">{result.error || "Erro ao carregar métricas"}</div>
      </PageShell>
    );
  }

  return (
    <PageShell
      title="Métricas do Banco de Dados"
      actions={
        <Button variant="outline" size="sm" asChild>
          <Link href="/app/admin/metricas-db/avaliar-upgrade">Avaliar Upgrade</Link>
        </Button>
      }
    >
      {result.data && <MetricasDBContent metricas={result.data} />}
    </PageShell>
  );
}
