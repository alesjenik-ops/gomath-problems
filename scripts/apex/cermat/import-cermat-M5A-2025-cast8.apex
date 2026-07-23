String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PAD25C0T01';
Integer YEAR = 2025;

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
  'CERMAT M5A 2025 – úloha 13',
  new List<String>{'Kostka tvaru krychle má na třech stěnách po 1 tečce a na zbývajících třech stěnách po 3 tečkách. Součet počtu teček na protějších stěnách je vždy 4. Počet všech teček na povrchu kostky je tedy 12. Z takovýchto kostek slepíme tři tělesa. Kostky před slepováním vhodně natočíme, aby byly splněny následující podmínky: první těleso má na svém povrchu co nejvíce teček a zbývající dvě tělesa co nejméně teček. První těleso jsou 2 kostky v řadě, druhé těleso 3 kostky v řadě, třetí těleso 3 kostky ve tvaru L.','Přiřaďte ke každému tělesu (13.1–13.3) počet všech teček na jeho povrchu (A–F).','13.1 První těleso','13.2 Druhé těleso','13.3 Třetí těleso'},
  new List<String>{'A) méně než 20 teček','B) 20 teček','C) 22 teček','D) 24 teček','E) 26 teček','F) 28 teček'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 175" font-family="sans-serif"><text x="80" y="30" font-size="12" text-anchor="middle">1. těleso</text><rect x="50" y="95" width="32" height="32" fill="#ececec" stroke="#000"/><polygon points="50,95 63,82 95,82 82,95" fill="#f6f6f6" stroke="#000"/><polygon points="82,95 95,82 95,114 82,127" fill="#d6d6d6" stroke="#000"/><rect x="82" y="95" width="32" height="32" fill="#ececec" stroke="#000"/><polygon points="82,95 95,82 127,82 114,95" fill="#f6f6f6" stroke="#000"/><polygon points="114,95 127,82 127,114 114,127" fill="#d6d6d6" stroke="#000"/><text x="250" y="30" font-size="12" text-anchor="middle">2. těleso</text><rect x="200" y="95" width="32" height="32" fill="#ececec" stroke="#000"/><polygon points="200,95 213,82 245,82 232,95" fill="#f6f6f6" stroke="#000"/><polygon points="232,95 245,82 245,114 232,127" fill="#d6d6d6" stroke="#000"/><rect x="232" y="95" width="32" height="32" fill="#ececec" stroke="#000"/><polygon points="232,95 245,82 277,82 264,95" fill="#f6f6f6" stroke="#000"/><polygon points="264,95 277,82 277,114 264,127" fill="#d6d6d6" stroke="#000"/><rect x="264" y="95" width="32" height="32" fill="#ececec" stroke="#000"/><polygon points="264,95 277,82 309,82 296,95" fill="#f6f6f6" stroke="#000"/><polygon points="296,95 309,82 309,114 296,127" fill="#d6d6d6" stroke="#000"/><text x="435" y="30" font-size="12" text-anchor="middle">3. těleso</text><rect x="400" y="95" width="32" height="32" fill="#ececec" stroke="#000"/><polygon points="400,95 413,82 445,82 432,95" fill="#f6f6f6" stroke="#000"/><polygon points="432,95 445,82 445,114 432,127" fill="#d6d6d6" stroke="#000"/><rect x="432" y="95" width="32" height="32" fill="#ececec" stroke="#000"/><polygon points="432,95 445,82 477,82 464,95" fill="#f6f6f6" stroke="#000"/><polygon points="464,95 477,82 477,114 464,127" fill="#d6d6d6" stroke="#000"/><rect x="400" y="63" width="32" height="32" fill="#ececec" stroke="#000"/><polygon points="400,63 413,50 445,50 432,63" fill="#f6f6f6" stroke="#000"/><polygon points="432,63 445,50 445,82 432,95" fill="#d6d6d6" stroke="#000"/><text x="260" y="165" font-size="10" text-anchor="middle" fill="#666">Schematický nákres tří těles (2, 3 a 3 kostky); posuzuje se podle testového sešitu.</text></svg>',
  'telesa-kostky.svg',
  'Tři tělesa slepená z krychlových kostek: dvě kostky, tři kostky v řadě a tři kostky ve tvaru L (schematicky).',
  'Schematický nákres tří těles',
  new List<String>{'Každá kostka má $12$ teček; na protějších stěnách je součet $4$ (naproti $1$ je vždy $3$). Slepené stěny se skryjí.','13.1 První těleso (2 kostky, co nejvíce teček): skryjeme dvě stěny s $1$ tečkou, tedy $2$; na povrchu $2\\cdot 12 - 2 = 22$ teček → C.','13.2 Druhé těleso (řada 3 kostek, co nejméně): prostřední kostka má slepené protilehlé stěny (součet $4$), krajní kostky po jedné stěně se $3$ tečkami; skryto $4 + 3 + 3 = 10$; na povrchu $36 - 10 = 26$ teček → E.','13.3 Třetí těleso (tvar L, co nejméně): rohová kostka má slepené dvě sousední stěny, obě mohou mít po $3$ tečkách; skryto $3 + 3 + 3 + 3 = 12$; na povrchu $36 - 12 = 24$ teček → D.'},
  '13.1: C (22 teček); 13.2: E (26 teček); 13.3: D (24 teček)',
  5, 6, '4',
  new List<String>{'zs1','stereometrie','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
