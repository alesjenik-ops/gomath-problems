String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PBD21C0T02';
Integer YEAR = 2021;

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
  'CERMAT M5B 2021 – úloha 13',
  new List<String>{'Na podložce stavíme stavby ze stejně velkých krychliček. Číslo v tabulce udává počet krychliček ve sloupci nad sebou (počet pater). V tabulkách tří staveb jsou kartičkami K, L a M zakryta tři čísla (viz obrázek).','Přiřaďte ke každé otázce (13.1–13.3) správnou odpověď (A–F).','13.1 V 1. stavbě je celkem $24$ krychliček. Jaké číslo je zakryto kartičkou K?','13.2 Ve 2. stavbě se počet krychliček v 5. a 6. patře liší o $2$ krychličky. Jaké číslo je zakryto kartičkou L?','13.3 Ve 3. stavbě je v nejvyšších třech patrech celkem $9$ krychliček. Jaké číslo je zakryto kartičkou M?'},
  new List<String>{'A) menší než 4','B) 4','C) 5','D) 6','E) 7','F) větší než 7'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 328 146" font-family="sans-serif"><text x="54" y="30" font-size="13" text-anchor="middle">1. stavba</text><rect x="12" y="44" width="28" height="28" fill="#ffffff" stroke="#000"/><text x="26" y="62" font-size="13" text-anchor="middle">5</text><rect x="40" y="44" width="28" height="28" fill="#cfcfcf" stroke="#000"/><text x="54" y="62" font-size="13" text-anchor="middle" font-weight="bold">K</text><rect x="68" y="44" width="28" height="28" fill="#ffffff" stroke="#000"/><text x="82" y="62" font-size="13" text-anchor="middle">3</text><rect x="12" y="72" width="28" height="28" fill="#ffffff" stroke="#000"/><text x="26" y="90" font-size="13" text-anchor="middle">1</text><rect x="40" y="72" width="28" height="28" fill="#ffffff" stroke="#000"/><text x="54" y="90" font-size="13" text-anchor="middle">3</text><rect x="68" y="72" width="28" height="28" fill="#ffffff" stroke="#000"/><text x="82" y="90" font-size="13" text-anchor="middle">2</text><rect x="40" y="100" width="28" height="28" fill="#ffffff" stroke="#000"/><text x="54" y="118" font-size="13" text-anchor="middle">2</text><text x="164" y="30" font-size="13" text-anchor="middle">2. stavba</text><rect x="122" y="44" width="28" height="28" fill="#ffffff" stroke="#000"/><text x="136" y="62" font-size="13" text-anchor="middle">10</text><rect x="150" y="44" width="28" height="28" fill="#ffffff" stroke="#000"/><text x="164" y="62" font-size="13" text-anchor="middle">1</text><rect x="178" y="44" width="28" height="28" fill="#ffffff" stroke="#000"/><text x="192" y="62" font-size="13" text-anchor="middle">7</text><rect x="150" y="72" width="28" height="28" fill="#ffffff" stroke="#000"/><text x="164" y="90" font-size="13" text-anchor="middle">5</text><rect x="122" y="100" width="28" height="28" fill="#ffffff" stroke="#000"/><text x="136" y="118" font-size="13" text-anchor="middle">2</text><rect x="150" y="100" width="28" height="28" fill="#cfcfcf" stroke="#000"/><text x="164" y="118" font-size="13" text-anchor="middle" font-weight="bold">L</text><rect x="178" y="100" width="28" height="28" fill="#ffffff" stroke="#000"/><text x="192" y="118" font-size="13" text-anchor="middle">6</text><text x="274" y="30" font-size="13" text-anchor="middle">3. stavba</text><rect x="232" y="44" width="28" height="28" fill="#ffffff" stroke="#000"/><text x="246" y="62" font-size="13" text-anchor="middle">7</text><rect x="260" y="44" width="28" height="28" fill="#ffffff" stroke="#000"/><text x="274" y="62" font-size="13" text-anchor="middle">3</text><rect x="260" y="72" width="28" height="28" fill="#cfcfcf" stroke="#000"/><text x="274" y="90" font-size="13" text-anchor="middle" font-weight="bold">M</text><rect x="288" y="72" width="28" height="28" fill="#ffffff" stroke="#000"/><text x="302" y="90" font-size="13" text-anchor="middle">6</text><rect x="232" y="100" width="28" height="28" fill="#ffffff" stroke="#000"/><text x="246" y="118" font-size="13" text-anchor="middle">4</text><rect x="260" y="100" width="28" height="28" fill="#ffffff" stroke="#000"/><text x="274" y="118" font-size="13" text-anchor="middle">8</text><rect x="288" y="100" width="28" height="28" fill="#ffffff" stroke="#000"/><text x="302" y="118" font-size="13" text-anchor="middle">7</text></svg>',
  'stavby.svg',
  'Tabulky ukázkové stavby a tří staveb s počty pater; v tabulkách jsou zakryta čísla K, L, M.',
  'Tabulky staveb k úloze 13',
  new List<String>{'13.1 Součet čísel v 1. stavbě $=5+K+3+1+3+2+2=16+K=24$, tedy $K=8$ (větší než 7) → F.','13.2 V 5. patře jsou sloupce s výškou aspoň $5$, v 6. patře s výškou aspoň $6$. Rozdíl je $2$ pouze pro $L=5$ → C.','13.3 Tři nejvyšší patra (6., 7. a 8.) mají dohromady $9$ krychliček jen pro $M=6$ → D.'},
  '13.1: F ($K=8$); 13.2: C ($L=5$); 13.3: D ($M=6$)',
  5, 7, '3',
  new List<String>{'zs1','stereometrie','porozumeni','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
