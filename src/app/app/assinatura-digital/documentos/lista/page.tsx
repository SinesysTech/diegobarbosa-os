import { Suspense } from "react";
import { ListaDocumentosClient } from "./client-page";

export const metadata = {
  title: "Documentos de Assinatura Digital | Diego Barbosa Soluções Jurídicas",
  description: "Lista de documentos enviados para assinatura digital",
};

export default function ListaDocumentosPage() {
  return (
    <Suspense fallback={<div className="p-8">Carregando documentos...</div>}>
      <ListaDocumentosClient />
    </Suspense>
  );
}
