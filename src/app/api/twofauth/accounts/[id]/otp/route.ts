// Rota de API para obter OTP de uma conta específica do 2FAuth
// GET: Retorna o código OTP atual de uma conta

import { NextRequest, NextResponse } from "next/server";
import { authenticateRequest } from "@/lib/auth/api-auth";
import { getOTPByAccountId, TwoFAuthError } from "@/lib/integrations/twofauth";

/**
 * @swagger
 * /api/twofauth/accounts/{id}/otp:
 *   get:
 *     summary: Obtém OTP de uma conta
 *     description: Retorna o código OTP atual e próximo (se disponível) de uma conta específica
 *     tags:
 *       - 2FAuth
 *     security:
 *       - bearerAuth: []
 *       - sessionAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: ID da conta no 2FAuth
 *     responses:
 *       200:
 *         description: OTP retornado com sucesso
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success:
 *                   type: boolean
 *                 data:
 *                   type: object
 *                   properties:
 *                     password:
 *                       type: string
 *                       description: Código OTP atual
 *                     nextPassword:
 *                       type: string
 *                       description: Próximo código OTP (se disponível)
 *       401:
 *         description: Não autenticado
 *       404:
 *         description: Conta não encontrada
 *       500:
 *         description: Erro interno ou 2FAuth não configurado
 */
export async function GET(
  request: NextRequest,
  { params }: { params: Promise<{ id: string }> }
) {
  try {
    // 1. Autenticação
    const authResult = await authenticateRequest(request);
    if (!authResult.authenticated) {
      return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
    }

    // 2. Obter ID da conta
    const { id } = await params;
    const accountId = parseInt(id, 10);

    if (isNaN(accountId)) {
      return NextResponse.json(
        { success: false, error: "ID inválido" },
        { status: 400 }
      );
    }

    // 3. Obter OTP da conta
    const otpResult = await getOTPByAccountId(accountId);

    // 4. Retornar resultado
    return NextResponse.json({
      success: true,
      data: otpResult,
    });
  } catch (error) {
    console.error("Error in twofauth OTP GET:", error);

    if (error instanceof TwoFAuthError) {
      const status =
        error.statusCode === 404
          ? 404
          : error.statusCode >= 500
            ? 500
            : error.statusCode;

      return NextResponse.json(
        {
          success: false,
          error: error.message,
          statusCode: error.statusCode,
        },
        { status }
      );
    }

    return NextResponse.json(
      { success: false, error: "Internal server error" },
      { status: 500 }
    );
  }
}
