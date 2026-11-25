CREATE PROCEDURE [dbo].[usp_repo_veri_kardex_gen_alm]
	@Per [int]
WITH EXECUTE AS CALLER
AS
--declare @Per int
--select @Per = 2009  

set nocount on

declare @Fecha datetime, @cod char(8)
declare @codI char(8)
declare @Tx table (codi_prod char(8) null,  GeneP numeric(12,4) null,  GeneR numeric(12,4) null,
			Alma1P numeric(12,4) null, Alma1R numeric(12,4) null, 
			Alma2P numeric(12,4) null, Alma2R numeric(12,4) null,
			Alma3P numeric(12,4) null, Alma3R numeric(12,4) null)

insert @TX 
select codi_prod , isnull((Select top 1 isnull(cant_saldo,0)
		From dbo.Kardex X (nolock ) where X.codi_prod =t.codi_prod
		and X.periodo=@Per and X.fech_tran in (Select max(K.fech_tran)
			From dbo.Kardex K (nolock ) where K.codi_prod = T.codi_prod and K.periodo=@Per)
		order by X.codi_prod, X.fech_tran desc , X.i_o desc , X.codi_docu_i_o desc , x.item desc),0) as GP, 
	isnull((Select sum (isnull( cant_ingr,0 )-  isnull( CANT_SALi,0 )) 
		From dbo.Kardex X (nolock ) where X.codi_prod =T.codi_prod and periodo=@Per ) ,0) GR,

	 isnull((Select top 1 isnull(cant_saldo_alma,0)
		From dbo.Kardex X (nolock ) where X.codi_almA='01' and X.codi_prod =t.codi_prod
		and X.periodo=@Per and X.fech_tran in (Select max(K.fech_tran)
			From dbo.Kardex K (nolock ) where K.codi_prod = T.codi_prod and K.periodo=@Per and k.codi_alma='01')
		order by X.codi_prod, X.fech_tran desc , X.i_o desc , X.codi_docu_i_o desc , x.item desc),0) as Al1P, 
	isnull((Select sum (isnull( cant_ingr,0 )-  isnull( CANT_SALi,0 )) 
		From dbo.Kardex X (nolock ) where X.codi_prod =T.codi_prod and periodo=@Per and x.codi_alma='01') ,0) AL1R,

	 isnull((Select top 1 isnull(cant_saldo_alma,0)
		From dbo.Kardex X (nolock ) where X.codi_almA='02' and X.codi_prod =t.codi_prod
		and X.periodo=@Per and X.fech_tran in (Select max(K.fech_tran)
			From dbo.Kardex K (nolock ) where K.codi_prod = T.codi_prod and K.periodo=@Per and k.codi_alma='02')
		order by X.codi_prod, X.fech_tran desc , X.i_o desc , X.codi_docu_i_o desc , x.item desc),0) as Al2P, 
	isnull((Select sum (isnull( cant_ingr,0 )-  isnull( CANT_SALi,0 )) 
		From dbo.Kardex X (nolock ) where X.codi_prod =T.codi_prod and periodo=@Per and x.codi_alma='02') ,0) AL2R,

	 isnull((Select top 1 isnull(cant_saldo_alma,0)
		From dbo.Kardex X (nolock ) where X.codi_almA='03' and X.codi_prod =t.codi_prod
		and X.periodo=@Per and X.fech_tran in (Select max(K.fech_tran)
			From dbo.Kardex K (nolock ) where K.codi_prod = T.codi_prod and K.periodo=@Per and k.codi_alma='03')
		order by X.codi_prod, X.fech_tran desc , X.i_o desc , X.codi_docu_i_o desc , x.item desc),0) as Al3P, 
	isnull((Select sum (isnull( cant_ingr,0 )-  isnull( CANT_SALi,0 )) 
		From dbo.Kardex X (nolock ) where X.codi_prod =T.codi_prod and periodo=@Per and x.codi_alma='03') ,0) AL3R
from productos T (nolock)


select codi_prod ,  (select desc_prod from productos P (nolock) where P.codi_prod=T.codi_prod collate sql_latin1_general_cp1_ci_as ) desc_prod,
	GeneP ,  GeneR , Alma1P , Alma1R , Alma2P , Alma2R , Alma3P , Alma3R 
from @TX T 
where not ( geneP=GeneR and alma1P=alma1R and alma2P=alma2R and alma3P=alma3R)
GO
