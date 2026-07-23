String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PAD19C0T01';
Integer YEAR = 2019;

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
  'CERMAT M5A 2019 – úloha 14',
  new List<String>{'Na čtvercové síti vytváříme ze sirek čtvercové labyrinty podle jednotných pravidel: každá sirka odděluje vždy dvě pole čtvercové sítě; sirky na sebe navazují, začínají ve středu labyrintu a končí v jeho levém dolním rohu; nejmenší labyrint je složen z $8$ sirek a obsahuje $4$ pole; při sestavování následujícího labyrintu se přidá k předchozímu nejmenší možný počet sirek. Na obrázku jsou tři nejmenší labyrinty.','14.1 Vypočtěte, kolik polí čtvercové sítě obsahuje 4. labyrint.','14.2 Vypočtěte, o kolik polí čtvercové sítě je 7. labyrint větší než 6. labyrint.','14.3 Vypočtěte, kolik sirek musíme přidat, chceme-li zvětšit 9. labyrint na 10. labyrint.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 150" font-family="sans-serif"><path d="M18 28h60M18 28v60M18 58h60M48 28v60M18 88h60M78 28v60" stroke="#cfcfcf" stroke-width="0.6" fill="none"/><polyline points="48,58 48,88 78,88 78,28 18,28 18,88" fill="none" stroke="#000" stroke-width="3"/><circle cx="48" cy="58" r="3" fill="#000"/><circle cx="48" cy="88" r="3" fill="#000"/><circle cx="78" cy="88" r="3" fill="#000"/><circle cx="78" cy="28" r="3" fill="#000"/><circle cx="18" cy="28" r="3" fill="#000"/><circle cx="18" cy="88" r="3" fill="#000"/><text x="18" y="19" font-size="13">1.</text><path d="M165 28h80M165 28v80M165 48h80M185 28v80M165 68h80M205 28v80M165 88h80M225 28v80M165 108h80M245 28v80" stroke="#cfcfcf" stroke-width="0.6" fill="none"/><polyline points="205,68 205,88 225,88 225,48 185,48 185,108 245,108 245,28 165,28 165,108" fill="none" stroke="#000" stroke-width="3"/><circle cx="205" cy="68" r="3" fill="#000"/><circle cx="205" cy="88" r="3" fill="#000"/><circle cx="225" cy="88" r="3" fill="#000"/><circle cx="225" cy="48" r="3" fill="#000"/><circle cx="185" cy="48" r="3" fill="#000"/><circle cx="185" cy="108" r="3" fill="#000"/><circle cx="245" cy="108" r="3" fill="#000"/><circle cx="245" cy="28" r="3" fill="#000"/><circle cx="165" cy="28" r="3" fill="#000"/><circle cx="165" cy="108" r="3" fill="#000"/><text x="165" y="19" font-size="13">2.</text><path d="M380 28h90M380 28v90M380 43h90M395 28v90M380 58h90M410 28v90M380 73h90M425 28v90M380 88h90M440 28v90M380 103h90M455 28v90M380 118h90M470 28v90" stroke="#cfcfcf" stroke-width="0.6" fill="none"/><polyline points="425,73 425,88 440,88 440,58 410,58 410,103 455,103 455,43 395,43 395,118 470,118 470,28 380,28 380,118" fill="none" stroke="#000" stroke-width="3"/><circle cx="425" cy="73" r="3" fill="#000"/><circle cx="425" cy="88" r="3" fill="#000"/><circle cx="440" cy="88" r="3" fill="#000"/><circle cx="440" cy="58" r="3" fill="#000"/><circle cx="410" cy="58" r="3" fill="#000"/><circle cx="410" cy="103" r="3" fill="#000"/><circle cx="455" cy="103" r="3" fill="#000"/><circle cx="455" cy="43" r="3" fill="#000"/><circle cx="395" cy="43" r="3" fill="#000"/><circle cx="395" cy="118" r="3" fill="#000"/><circle cx="470" cy="118" r="3" fill="#000"/><circle cx="470" cy="28" r="3" fill="#000"/><circle cx="380" cy="28" r="3" fill="#000"/><circle cx="380" cy="118" r="3" fill="#000"/><text x="380" y="19" font-size="13">3.</text></svg>',
  'labyrinty.svg',
  'Tři nejmenší čtvercové labyrinty ze sirek ve tvaru spirály na čtvercové síti.',
  '1., 2. a 3. nejmenší labyrint',
  new List<String>{'V $n$-tém labyrintu je $(2n)^2=4n^2$ polí a $4n(n+1)$ sirek. (1. labyrint: $4$ pole a $8$ sirek.)','14.1 4. labyrint: $4\\cdot 4^2=64$ polí.','14.2 Rozdíl 7. a 6. labyrintu: $4\\cdot 7^2-4\\cdot 6^2=196-144=52$ polí.','14.3 Přidané sirky: $4\\cdot 10\\cdot 11-4\\cdot 9\\cdot 10=440-360=80$ sirek.'},
  '14.1: $64$ polí; 14.2: o $52$ polí; 14.3: $80$ sirek',
  4, 6, '3',
  new List<String>{'zs1','posloupnosti','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
