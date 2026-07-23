String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PDD21C0T04';
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
  'CERMAT M7D 2021 – úloha 11',
  new List<String>{'Na obrázku jsou dvě rovnoběžné přímky (vyznačené shodnými značkami) a dvě příčky. Jsou vyznačeny úhly $62^\\circ$ a $66^\\circ$.','Jaká je velikost úhlu $\\varphi$? Velikosti úhlů neměřte, ale vypočtěte.'},
  new List<String>{'A) $128^\\circ$','B) $126^\\circ$','C) $118^\\circ$','D) $114^\\circ$','E) jiná velikost'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 320" font-family="sans-serif"> <line x1="70" y1="42" x2="210" y2="300" stroke="#000" stroke-width="2"/> <line x1="210" y1="42" x2="350" y2="300" stroke="#000" stroke-width="2"/> <line x1="30" y1="122" x2="400" y2="72" stroke="#000" stroke-width="2"/> <line x1="60" y1="252" x2="410" y2="202" stroke="#000" stroke-width="2"/> <line x1="64" y1="36" x2="74" y2="50" stroke="#000" stroke-width="2"/> <line x1="71" y1="36" x2="81" y2="50" stroke="#000" stroke-width="2"/> <line x1="204" y1="36" x2="214" y2="50" stroke="#000" stroke-width="2"/> <line x1="211" y1="36" x2="221" y2="50" stroke="#000" stroke-width="2"/> <text x="118" y="122" font-size="15">62°</text> <text x="248" y="108" font-size="17" font-style="italic">φ</text> <text x="120" y="248" font-size="15">66°</text> </svg>',
  'uhly-fi.svg',
  'Dvě rovnoběžné šikmé přímky se shodnými značkami a dvě příčky; vyznačené úhly 62°, φ a 66°.',
  'Výchozí obrázek k úloze 11',
  new List<String>{'Přímky se shodnými značkami jsou rovnoběžné, proto pomocí střídavých úhlů vznikne trojúhelník s vnitřními úhly $62^\\circ$, $66^\\circ$ a $180^\\circ-62^\\circ-66^\\circ=52^\\circ$. Úhel $\\varphi$ je vnějším úhlem tohoto trojúhelníku u vrcholu s úhlem $66^\\circ$, tedy $\\varphi=62^\\circ+52^\\circ=114^\\circ$ (rovněž $180^\\circ-66^\\circ$).'},
  'D) $114^\\circ$',
  2, 4, '3',
  new List<String>{'zs2','r7','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7D 2021 – úloha 12',
  new List<String>{'Všechny díly stavebnice jsou pravidelné čtyřboké hranoly s rozměry $1$ cm $\\times$ $1$ cm $\\times$ $2$ cm. Ve stavbě, která má podobu tří spojených kvádrů, jsou díly naskládány bez mezer tak, aby stavba obsahovala co největší počet stojících dílů. Stojící díl má dole čtvercovou stěnu, ležící díl nikoli. Kvádry mají shodnou šířku $3$ cm a hloubku $4$ cm; jejich výšky jsou $6$ cm, $7$ cm a $5$ cm.','Kolik ležících dílů stavba obsahuje?'},
  new List<String>{'A) $0$','B) $6$','C) $12$','D) $18$','E) $24$'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 380 260" font-family="sans-serif"><polygon points="136,128 152,117 152,219 136,230" fill="#c4c4c4" stroke="#000"/><polygon points="92,128 108,117 152,117 136,128" fill="#dedede" stroke="#000"/><rect x="92" y="128" width="44" height="102" fill="#f2f2f2" stroke="#000"/><polygon points="180,111 196,100 196,219 180,230" fill="#c4c4c4" stroke="#000"/><polygon points="136,111 152,100 196,100 180,111" fill="#dedede" stroke="#000"/><rect x="136" y="111" width="44" height="119" fill="#f2f2f2" stroke="#000"/><polygon points="224,145 240,134 240,219 224,230" fill="#c4c4c4" stroke="#000"/><polygon points="180,145 196,134 240,134 224,145" fill="#dedede" stroke="#000"/><rect x="180" y="145" width="44" height="85" fill="#f2f2f2" stroke="#000"/><text x="80" y="179" font-size="12" text-anchor="end">6</text><text x="158.0" y="96" font-size="12" text-anchor="middle">7</text><text x="244" y="196" font-size="12">5</text><text x="114.0" y="245" font-size="11" text-anchor="middle">3</text><text x="158.0" y="245" font-size="11" text-anchor="middle">3</text><text x="202.0" y="245" font-size="11" text-anchor="middle">3</text><text x="248" y="60" font-size="12">Stavba</text></svg>',
  'stavba-kvadry.svg',
  'Schematický nákres stavby ze tří spojených kvádrů o výškách 6, 7 a 5 cm, šířkách 3 cm a hloubce 4 cm.',
  'Stavba ze tří kvádrů',
  new List<String>{'Sloupce se snažíme zaplnit stojícími díly (výška $2$ cm). Ležící díly jsou nutné jen v nejvyšší vrstvě sloupce liché výšky. Kvádr výšky $6$ cm (sudá) → $0$ ležících dílů. Kvádry výšky $7$ cm a $5$ cm (liché) mají navrchu vrstvu $3\\times 4=12$ cm² vysokou $1$ cm, do níž se vejde $12:2=6$ ležících dílů. Celkem $6+6=12$.'},
  'C) $12$',
  2, 4, '3',
  new List<String>{'zs2','r7','stereometrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
