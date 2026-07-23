String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PAD22C0T01';
Integer YEAR = 2022;

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
  'CERMAT M5A 2022 – úloha 13',
  new List<String>{'Ze stejných kostek tvaru krychle se slepují tělesa. Skrz každou kostku je provrtaný jeden otvor. Kostky mohou být otočeny třemi směry: otvor směřuje zepředu dozadu ($P$), z boku na druhý bok ($B$), nebo shora dolů ($H$). Otvory jsou vyznačeny dvěma způsoby: světlé otvory vedou skrz naskrz celým tělesem, tmavé otvory jsou uvnitř tělesa uzavřeny jinou kostkou. V ukázkovém tělese jsou $2$ kostky ve směru $P$, $1$ kostka ve směru $B$ a $2$ kostky ve směru $H$.','Přiřaďte ke každému tělesu (13.1–13.3) počty kostek otočených v daném směru (A–F). Tělesa 13.1, 13.2, 13.3 viz testový sešit.'},
  new List<String>{'A) $1P + 3B + 2H$','B) $1P + 2B + 3H$','C) $2P + 2B + 2H$','D) $2P + 1B + 3H$','E) $3P + 1B + 2H$','F) jiné počty'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 120" font-family="sans-serif"> <text x="280" y="52" font-size="13" text-anchor="middle">Telesa 13.1-13.3 slepena z krychli s otvory (smery P, B, H) - viz testovy sesit.</text> <text x="280" y="80" font-size="11" text-anchor="middle" fill="#666">Prostorova telesa nelze verne prenest do SVG; posuzuje se podle originalu.</text> </svg>',
  'kostky.svg',
  'Tři prostorová tělesa slepená z krychlí s otvory ve směrech P, B, H (schematická poznámka).',
  'schematický nákres',
  new List<String>{'13.1 → E ($3P + 1B + 2H$).','13.2 → C ($2P + 2B + 2H$).','13.3 → B ($1P + 2B + 3H$).'},
  '13.1: E ($3P + 1B + 2H$); 13.2: C ($2P + 2B + 2H$); 13.3: B ($1P + 2B + 3H$)',
  5, 6, '4',
  new List<String>{'zs1','stereometrie','porozumeni','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5A 2022 – úloha 14',
  new List<String>{'Pyramida se skládá ze shodných čtverců. Horní řadu tvoří vždy jeden tmavý čtverec. V pyramidě s více než jedním čtvercem se pravidelně střídají řady s tmavými a řady s bílými čtverci. Každá další řada má vždy o $1$ čtverec více než řada nad ní (viz obrázek).','14.1 Pyramida má $10$ řad. Určete, o kolik se liší počet tmavých a bílých čtverců v pyramidě.','14.2 Pyramida má $73$ řad. Určete, o kolik se liší počet tmavých a bílých čtverců v pyramidě.','14.3 V pyramidě je o $101$ bílých čtverců méně než tmavých čtverců. Určete, kolik řad má pyramida.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 175" font-family="sans-serif"><rect x="20.0" y="134" width="16" height="16" fill="#9a9a9a" stroke="#000"/><rect x="70.0" y="118" width="16" height="16" fill="#9a9a9a" stroke="#000"/><rect x="62.0" y="134" width="16" height="16" fill="#ffffff" stroke="#000"/><rect x="78.0" y="134" width="16" height="16" fill="#ffffff" stroke="#000"/><rect x="136.0" y="102" width="16" height="16" fill="#9a9a9a" stroke="#000"/><rect x="128.0" y="118" width="16" height="16" fill="#ffffff" stroke="#000"/><rect x="144.0" y="118" width="16" height="16" fill="#ffffff" stroke="#000"/><rect x="120.0" y="134" width="16" height="16" fill="#9a9a9a" stroke="#000"/><rect x="136.0" y="134" width="16" height="16" fill="#9a9a9a" stroke="#000"/><rect x="152.0" y="134" width="16" height="16" fill="#9a9a9a" stroke="#000"/><rect x="218.0" y="86" width="16" height="16" fill="#9a9a9a" stroke="#000"/><rect x="210.0" y="102" width="16" height="16" fill="#ffffff" stroke="#000"/><rect x="226.0" y="102" width="16" height="16" fill="#ffffff" stroke="#000"/><rect x="202.0" y="118" width="16" height="16" fill="#9a9a9a" stroke="#000"/><rect x="218.0" y="118" width="16" height="16" fill="#9a9a9a" stroke="#000"/><rect x="234.0" y="118" width="16" height="16" fill="#9a9a9a" stroke="#000"/><rect x="194.0" y="134" width="16" height="16" fill="#ffffff" stroke="#000"/><rect x="210.0" y="134" width="16" height="16" fill="#ffffff" stroke="#000"/><rect x="226.0" y="134" width="16" height="16" fill="#ffffff" stroke="#000"/><rect x="242.0" y="134" width="16" height="16" fill="#ffffff" stroke="#000"/><text x="288" y="134" font-size="22">...</text></svg>',
  'pyramida.svg',
  'Pyramidy z 1, 2, 3 a 4 řad shodných čtverců; liché řady jsou tmavé, sudé bílé, každá řada má o jeden čtverec více.',
  'Pyramidy z 1 až 4 řad',
  new List<String>{'V $n$-té řadě (shora) je $n$ čtverců; liché řady jsou tmavé, sudé bílé.','14.1 Pro $10$ řad: tmavé $1+3+5+7+9=25$, bílé $2+4+6+8+10=30$; liší se o $5$ čtverců.','14.2 Pro $73$ řad: tmavých $1+3+\\dots+73=37^2=1369$, bílých $2+4+\\dots+72=36\\cdot 37=1332$; liší se o $37$ čtverců.','14.3 Při lichém počtu řad $R$ převažují tmavé čtverce o $\\frac{R+1}{2}$. Z rovnice $\\frac{R+1}{2}=101$ plyne $R=201$ řad.'},
  '14.1: o $5$ čtverců; 14.2: o $37$ čtverců; 14.3: $201$ řad',
  4, 6, '3',
  new List<String>{'zs1','posloupnosti','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
