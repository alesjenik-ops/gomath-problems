String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PBD26C0T02';
Integer YEAR = 2026;

public class C {
  Map<String,Id> tx; Set<String> have; String src; String stype; String ccode; Integer yr; public Integer created=0;
  C(Map<String,Id> tx, Set<String> have, String src, String stype, String ccode, Integer yr){this.tx=tx;this.have=have;this.src=src;this.stype=stype;this.ccode=ccode;this.yr=yr;}
  Id sv(String t,String fn,String s){ContentVersion cv=new ContentVersion(Title=t,PathOnClient=fn,VersionData=Blob.valueOf(s),Origin='H');insert cv;return [SELECT ContentDocumentId FROM ContentVersion WHERE Id=:cv.Id].ContentDocumentId;}
  void lk(Id d,Id r){try{insert new ContentDocumentLink(ContentDocumentId=d,LinkedEntityId=r,ShareType='V',Visibility='AllUsers');}catch(Exception e){insert new ContentDocumentLink(ContentDocumentId=d,LinkedEntityId=r,ShareType='V',Visibility='InternalUsers');}}
  String para(String t){return '{"type":"paragraph","text":'+JSON.serialize(t)+'}';}
  String content(List<String> zad, Id d, String alt, String cap, List<String> opts, Integer ln){
    String s='{"schemaVersion":1,"blocks":[';
    for(Integer i=0;i<zad.size();i++){if(i>0)s+=',';s+=para(zad[i]);}
    if(d!=null){s+=',{"type":"image","contentDocumentId":"'+d+'","alt":'+JSON.serialize(alt)+',"caption":'+JSON.serialize(cap)+',"widthPercent":75,"align":"center"}';}
    if(opts!=null && !opts.isEmpty()){s+=',{"type":"list","items":[';for(Integer i=0;i<opts.size();i++){if(i>0)s+=',';s+=JSON.serialize(opts[i]);}s+=']}';}
    if(ln!=null && ln>0){s+=',{"type":"answerSpace","lines":'+ln+'}';}
    s+=']}';return s;
  }
  String solution(List<String> ps){String s='{"schemaVersion":1,"blocks":[';for(Integer i=0;i<ps.size();i++){if(i>0)s+=',';s+=para(ps[i]);}s+=']}';return s;}
  void add(String name,List<String> zad,List<String> opts,Integer ln,String svg,String fn,String alt,String cap,List<String> solp,String ans,Decimal pts,Decimal mins,String diff,List<String> codes){
    if(have.contains(name))return;
    Id d=(svg!=null)?sv(name,fn,svg):null;
    Math_Problem__c mp=new Math_Problem__c(Name=name,Status__c='Publikováno',Visibility__c='Organizace',Language__c='cs',Current_Version_Number__c=1);insert mp;
    String cj=content(zad,d,alt,cap,opts,ln); String sj=solution(solp);
    String aj=JSON.serialize(new Map<String,Object>{'type'=>'Text','value'=>ans});
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,CERMAT_Code__c=ccode,Source_Year__c=yr,License__c='Jiná',Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
    insert pub;
    List<Problem_Taxon__c> ls=new List<Problem_Taxon__c>();
    for(String code:codes){Id ti=tx.get(code);if(ti==null)continue;ls.add(new Problem_Taxon__c(Problem_Version__c=pub.Id,Taxon__c=ti,Unique_Key__c=pub.Id+'_'+ti));}
    if(!ls.isEmpty())insert ls;
    if(d!=null)lk(d,mp.Id);
    created++;
  }
}
Map<String,Id> tx=new Map<String,Id>();
for(Taxon__c t:[SELECT Id,Code__c FROM Taxon__c])tx.put(t.Code__c,t.Id);
Set<String> have=new Set<String>();
for(Math_Problem__c p:[SELECT Name FROM Math_Problem__c])have.add(p.Name);
C c=new C(tx,have,SRC,STYPE,CCODE,YEAR);

c.add(
  'CERMAT M9B 2026 – úloha 16',
  new List<String>{'První obrazec je bílý čtverec. Druhý obrazec vznikne z prvního vložením menšího šedého čtverce, jehož vrcholy leží ve středech stran bílého čtverce. Další obrazce vznikají střídavým vkládáním stále menších bílých a šedých čtverců, jejichž vrcholy vždy leží ve středech stran čtverce vloženého v předchozím obrazci (viz obrázek). Druhý a každý další obrazec se skládá z bílých a šedých dílů. Např. třetí obrazec obsahuje $9$ dílů – $1$ bílý čtverec, $4$ šedé trojúhelníky a $4$ bílé trojúhelníky.','16.1 Určete, kolik šedých dílů obsahuje 10. obrazec.','16.2 Určete, kolikátý obrazec obsahuje $89$ bílých dílů.','16.3 Vyjádřete zlomkem, jakou část obsahu 5. obrazce představuje obsah všech jeho šedých dílů dohromady.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 170" font-family="sans-serif"><text x="80" y="30" font-size="12" text-anchor="middle">1. obrazec</text><polygon points="28.0,43.0 132.0,43.0 132.0,147.0 28.0,147.0" fill="#ffffff" stroke="#000" stroke-width="1.2"/><text x="230" y="30" font-size="12" text-anchor="middle">2. obrazec</text><polygon points="178.0,43.0 282.0,43.0 282.0,147.0 178.0,147.0" fill="#ffffff" stroke="#000" stroke-width="1.2"/><polygon points="230,43.0 282.0,95 230,147.0 178.0,95" fill="#b9b9b9" stroke="#000" stroke-width="1.2"/><text x="380" y="30" font-size="12" text-anchor="middle">3. obrazec</text><polygon points="328.0,43.0 432.0,43.0 432.0,147.0 328.0,147.0" fill="#ffffff" stroke="#000" stroke-width="1.2"/><polygon points="380,43.0 432.0,95 380,147.0 328.0,95" fill="#b9b9b9" stroke="#000" stroke-width="1.2"/><polygon points="354.0,69.0 406.0,69.0 406.0,121.0 354.0,121.0" fill="#ffffff" stroke="#000" stroke-width="1.2"/><text x="530" y="30" font-size="12" text-anchor="middle">4. obrazec</text><polygon points="478.0,43.0 582.0,43.0 582.0,147.0 478.0,147.0" fill="#ffffff" stroke="#000" stroke-width="1.2"/><polygon points="530,43.0 582.0,95 530,147.0 478.0,95" fill="#b9b9b9" stroke="#000" stroke-width="1.2"/><polygon points="504.0,69.0 556.0,69.0 556.0,121.0 504.0,121.0" fill="#ffffff" stroke="#000" stroke-width="1.2"/><polygon points="530,69.0 556.0,95 530,121.0 504.0,95" fill="#b9b9b9" stroke="#000" stroke-width="1.2"/><text x="612" y="102" font-size="24">…</text></svg>',
  'obrazce-ctverce.svg',
  'První až čtvrtý obrazec: do bílého čtverce se střídavě vkládají menší šedé a bílé čtverce s vrcholy ve středech stran.',
  '1., 2., 3. a 4. obrazec',
  new List<String>{'Celkový počet dílů roste $1, 5, 9, 13, 17,\\dots$ (o $4$ na obrazec), tj. $4n-3$ dílů. Bílých a šedých dílů přibývá střídavě po $4$: pro $n$-tý obrazec je bílých dílů $2n$ (sudé $n$) nebo $2n-1$ (liché $n$), zbytek je šedý.','16.1 V 10. obrazci je bílých $2\\cdot 10=20$ dílů z celkových $4\\cdot 10-3=37$, šedých je tedy $37-20=17$.','16.2 Pro liché $n$ je bílých dílů $2n-1$; z rovnice $2n-1=89$ plyne $n=45$, tj. 45. obrazec.','16.3 Obsah každého vloženého čtverce je poloviční oproti předchozímu. Šedé díly 5. obrazce mají obsah $\\frac{1}{4}+\\frac{1}{16}=\\frac{5}{16}$ obsahu celého obrazce.'},
  '16.1: $17$ šedých dílů; 16.2: 45. obrazec; 16.3: $\\frac{5}{16}$',
  4, 8, '4',
  new List<String>{'zs2','r9','posloupnosti','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
