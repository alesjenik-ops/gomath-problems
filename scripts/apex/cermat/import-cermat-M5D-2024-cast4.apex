String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PDD24C0T04';
Integer YEAR = 2024;

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
  'CERMAT M5D 2024 – úloha 8',
  new List<String>{'Ve čtvercové síti je nakreslen obdélník $ABCD$ s vrcholy v mřížových bodech. Tento obdélník lze rozstříhat na $20$ shodných čtverců. Obvod tohoto obdélníku je $54$ cm. V síti je vyznačen tmavý obrazec (viz obrázek).','Rozhodněte o každém z tvrzení 8.1–8.3, zda je pravdivé (Ano), či nikoli (Ne).','8.1 Obsah obdélníku $ABCD$ je $180$ cm².','8.2 Obvod tmavého obrazce je $69$ cm.','8.3 Obsah tmavého obrazce je $90$ cm².'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 210 176" font-family="sans-serif"><rect x="54" y="20" width="34" height="34" fill="#9a9a9a"/><rect x="122" y="20" width="34" height="34" fill="#9a9a9a"/><rect x="20" y="54" width="34" height="34" fill="#9a9a9a"/><rect x="122" y="54" width="34" height="34" fill="#9a9a9a"/><rect x="156" y="54" width="34" height="34" fill="#9a9a9a"/><rect x="88" y="88" width="34" height="34" fill="#9a9a9a"/><rect x="54" y="122" width="34" height="34" fill="#9a9a9a"/><rect x="122" y="122" width="34" height="34" fill="#9a9a9a"/><rect x="88" y="54" width="34" height="34" fill="#9a9a9a"/><line x1="20" y1="20" x2="20" y2="156" stroke="#777"/><line x1="54" y1="20" x2="54" y2="156" stroke="#777"/><line x1="88" y1="20" x2="88" y2="156" stroke="#777"/><line x1="122" y1="20" x2="122" y2="156" stroke="#777"/><line x1="156" y1="20" x2="156" y2="156" stroke="#777"/><line x1="190" y1="20" x2="190" y2="156" stroke="#777"/><line x1="20" y1="20" x2="190" y2="20" stroke="#777"/><line x1="20" y1="54" x2="190" y2="54" stroke="#777"/><line x1="20" y1="88" x2="190" y2="88" stroke="#777"/><line x1="20" y1="122" x2="190" y2="122" stroke="#777"/><line x1="20" y1="156" x2="190" y2="156" stroke="#777"/><rect x="20" y="20" width="170" height="136" fill="none" stroke="#000" stroke-width="2.5"/><text x="24" y="35" font-size="13" font-style="italic">D</text><text x="177" y="35" font-size="13" font-style="italic">C</text><text x="24" y="151" font-size="13" font-style="italic">A</text><text x="177" y="151" font-size="13" font-style="italic">B</text></svg>',
  'sit-obdelnik.svg',
  'Čtvercová síť s obdélníkem ABCD (5 krát 4 čtverečky) a tmavým obrazcem uvnitř.',
  'Schematický nákres (přesné rozmístění tmavých čtverečků viz testový sešit)',
  new List<String>{'Obdélník má $20$ čtverečků uspořádaných $5\\times 4$. Z obvodu: $2\\cdot(5+4)\\cdot s=54$, tedy strana čtverečku $s=3$ cm a obsah jednoho čtverečku $9$ cm².','8.1 Obsah obdélníku $=20\\cdot 9=180$ cm² → Ano.','8.2 Obvod obrazce v síti je vždy sudý počet stran čtverečku, tj. násobek $6$ cm. $69$ cm není násobek $6$ cm, obvod tedy nemůže být $69$ cm → Ne.','8.3 Tmavý obrazec netvoří $10$ čtverečků, jeho obsah proto není $90$ cm² → Ne.'},
  '8.1: Ano; 8.2: Ne; 8.3: Ne',
  3, 5, '3',
  new List<String>{'zs1','planimetrie','argumentace','slovni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5D 2024 – úloha 9',
  new List<String>{'Jedno balení stavebnice obsahuje $180$ kostek. Jedna desetina těchto kostek je modrá a jedna devítina červená.','Kolik takových balení kostek musíme koupit, abychom dohromady měli $190$ modrých a červených kostek?'},
  new List<String>{'A) $1$','B) $3$','C) $5$','D) $10$','E) jiný výsledek'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'V jednom balení je modrých $180:10=18$ a červených $180:9=20$, dohromady $38$ modrých a červených. Potřebujeme $190:38=5$ balení.'},
  'C) $5$',
  2, 3, '2',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5D 2024 – úloha 10',
  new List<String>{'Který z uvedených obrázků (A–E) logicky nepatří mezi ostatní? (Obrázky A–E viz testový sešit.)'},
  new List<String>{'A) obrázek A','B) obrázek B','C) obrázek C','D) obrázek D','E) obrázek E'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 120" font-family="sans-serif"> <text x="280" y="52" font-size="13" text-anchor="middle">Pet obrazku A-E slozenych z obdelniku a ctverecku s teckami (viz testovy sesit).</text> <text x="280" y="80" font-size="11" text-anchor="middle" fill="#666">Vizualni logickou ulohu nelze verne prenest do SVG; posuzuje se podle originalu.</text> </svg>',
  'obrazky-A-E.svg',
  'Pět obrázků A až E složených z obdélníků a čtverečků s tečkami.',
  'Výchozí obrázek k úloze 10 (schematická poznámka)',
  new List<String>{'Porovnáním obrázků nepatří mezi ostatní obrázek $B$.'},
  'B) obrázek B',
  2, 3, '3',
  new List<String>{'zs1','planimetrie','porozumeni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
