String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PDD25C0T04';
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
  'CERMAT M7D 2025 - uloha 13',
  new List<String>{'Ve stanici Licha Lhota stoji na kazde ze tri koleji jeden vlak. Vlak na druhe koleji ma o $3$ vagony vice nez vlak na prvni koleji a dvakrat mene vagonu nez vlak na treti koleji. Vsechny tri vlaky dohromady maji $41$ vagonu.','O kolik vagonu vice ma vlak na treti koleji nez vlak na prvni koleji?'},
  new List<String>{'A) o $8$ vagonu','B) o $10$ vagonu','C) o $11$ vagonu','D) o $13$ vagonu','E) o $14$ vagonu'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Prvni kolej $x$, druha $x+3$, treti dvakrat vice nez druha, tedy $2(x+3)=2x+6$. Soucet $x+(x+3)+(2x+6)=4x+9=41$, odkud $x=8$. Vlaky maji $8$, $11$ a $22$ vagonu; treti ma o $22-8=14$ vagonu vice nez prvni.'},
  'E) o $14$ vagonu',
  2, 4, '2',
  new List<String>{'zs2','r7','rovnice','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7D 2025 - uloha 14',
  new List<String>{'Jonas a Beata se zapojili do programu Ptaci hodinka. Kazdy v okoli sveho krmitka sledoval vyskyt ptaku v prubehu jedne vybrane hodiny. U kazdeho ptaciho druhu zaznamenali do grafu vzdy nejvyssi pocet jedincu spatrenych najednou. Jonas spatril pet druhu ptaku, zatimco Beata pouze ctyri z nich. Oba dohromady zaznamenali penkav o $6$ mene nez sykor. Jonas zaznamenal celkem o petinu vice ptacich jedincu nez Beata.','Kolik jedincu brhlika lesniho zaznamenala Beata?'},
  new List<String>{'A) $2$ jedince','B) $3$ jedince','C) $4$ jedince','D) $5$ jedincu','E) vice nez $5$ jedincu'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 300" font-family="sans-serif"><line x1="60" y1="30" x2="60" y2="250" stroke="#000"/><line x1="60" y1="250" x2="500" y2="250" stroke="#000"/><line x1="60" y1="206" x2="470" y2="206" stroke="#ccc"/><line x1="60" y1="162" x2="470" y2="162" stroke="#ccc"/><line x1="60" y1="118" x2="470" y2="118" stroke="#ccc"/><line x1="60" y1="74" x2="470" y2="74" stroke="#ccc"/><text x="52" y="254" font-size="11" text-anchor="end">0</text><text x="24" y="150" font-size="12" text-anchor="middle" transform="rotate(-90 24 150)">Nejvyssi pocet jedincu</text><rect x="90" y="118" width="20" height="132" fill="#595959" stroke="#000"/><rect x="112" y="162" width="20" height="88" fill="#d9d9d9" stroke="#000"/><text x="110" y="266" font-size="10" text-anchor="middle">kos</text><text x="110" y="278" font-size="10" text-anchor="middle">cerny</text><rect x="170" y="162" width="20" height="88" fill="#595959" stroke="#000"/><rect x="192" y="184" width="20" height="66" fill="none" stroke="#000" stroke-dasharray="4 3"/><text x="202.0" y="228" font-size="15" text-anchor="middle">?</text><text x="190" y="266" font-size="10" text-anchor="middle">brhlik</text><text x="190" y="278" font-size="10" text-anchor="middle">lesni</text><rect x="250" y="74" width="20" height="176" fill="#595959" stroke="#000"/><rect x="272" y="74" width="20" height="176" fill="#d9d9d9" stroke="#000"/><text x="270" y="266" font-size="10" text-anchor="middle">sykora</text><text x="270" y="278" font-size="10" text-anchor="middle">konadra</text><rect x="330" y="206" width="20" height="44" fill="#595959" stroke="#000"/><text x="350" y="266" font-size="10" text-anchor="middle">cervenka</text><text x="350" y="278" font-size="10" text-anchor="middle">obecna</text><rect x="410" y="162" width="20" height="88" fill="#595959" stroke="#000"/><rect x="432" y="118" width="20" height="132" fill="#d9d9d9" stroke="#000"/><text x="430" y="266" font-size="10" text-anchor="middle">penkava</text><text x="430" y="278" font-size="10" text-anchor="middle">obecna</text><rect x="512" y="80" width="12" height="12" fill="#595959" stroke="#000"/><text x="530" y="90" font-size="11">Jonas</text><rect x="512" y="100" width="12" height="12" fill="#d9d9d9" stroke="#000"/><text x="530" y="110" font-size="11">Beata</text></svg>',
  'graf-ptaci-hodinka.svg',
  'Skupinovy sloupcovy graf poctu jedincu peti ptacich druhu pro Jonase a Beatu; sloupec Beaty u brhlika lesniho je neznamy (oznaceny otaznikem).',
  'Nejvyssi pocty jedincu jednotlivych druhu (Jonas, Beata)',
  new List<String>{'Z grafu: sykora $8+8=16$, tedy penkavy dohromady $16-6=10$ (Jonas $4$, Beata $6$). Jonas celkem $6+4+8+2+4=24$ jedincu. Beata (bez brhlika) $4+8+0+6=18$; ma-li Jonas o petinu vice, je Beata celkem $24:1{,}2=20$. Brhlika lesniho tedy Beata zaznamenala $20-18=2$ jedince.'},
  'A) $2$ jedince',
  2, 5, '3',
  new List<String>{'zs2','r7','statistika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
