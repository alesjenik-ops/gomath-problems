String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PAD26C0T01';
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
  'CERMAT M9A 2026 – úloha 12',
  new List<String>{'Na parkovišti je $15$ míst vyhrazeno pro zásobování. Zatímco loni tato místa představovala jednu dvacetinu celkové kapacity parkoviště, letos díky rozšíření parkoviště představují tato místa pouze $4\\,\\%$ celkové kapacity.','O kolik parkovacích míst se díky rozšíření parkoviště zvětšila jeho celková kapacita?'},
  new List<String>{'A) o $25$ míst','B) o $50$ míst','C) o $75$ míst','D) o $125$ míst','E) o jiný počet míst'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Loni: $15$ míst $=\\frac{1}{20}$ kapacity, tedy kapacita $15\\cdot 20=300$ míst. Letos: $15$ míst $=4\\,\\%$ kapacity, tedy kapacita $\\frac{15}{0{,}04}=375$ míst. Zvětšení o $375-300=75$ míst.'},
  'C) o $75$ míst',
  2, 4, '3',
  new List<String>{'zs2','r9','procenta','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9A 2026 – úloha 13',
  new List<String>{'Rovnoramenný trojúhelník $KLM$ se základnou $LM$ délky $16$ cm má obvod $50$ cm.','Jaký je obsah trojúhelníku $KLM$?'},
  new List<String>{'A) $120$ cm²','B) $136$ cm²','C) $240$ cm²','D) $272$ cm²','E) jiný obsah'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 260 200" font-family="sans-serif"> <polygon points="40,44 220,44 130,180" fill="none" stroke="#000" stroke-width="2"/> <text x="28" y="40" font-size="15" font-style="italic">L</text> <text x="224" y="40" font-size="15" font-style="italic">M</text> <text x="130" y="196" font-size="15" text-anchor="middle" font-style="italic">K</text> <text x="130" y="34" font-size="13" text-anchor="middle">16 cm</text> </svg>',
  'trojuhelnik-klm.svg',
  'Rovnoramenný trojúhelník KLM se základnou LM délky 16 cm nahoře a vrcholem K dole.',
  'Výchozí obrázek k úloze 13',
  new List<String>{'Ramena: $|KL|=|KM|=\\frac{50-16}{2}=17$ cm. Výška na základnu: $v=\\sqrt{17^2-8^2}=\\sqrt{289-64}=\\sqrt{225}=15$ cm. Obsah $S=\\frac{1}{2}\\cdot 16\\cdot 15=120$ cm².'},
  'A) $120$ cm²',
  2, 4, '2',
  new List<String>{'zs2','r9','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2026 – úloha 14',
  new List<String>{'První i druhý pravidelný čtyřboký hranol mají podstavnou hranu délky $a=3$ cm. První hranol má o $72$ cm² větší povrch než druhý hranol.','O kolik cm se liší výšky obou hranolů?'},
  new List<String>{'A) o $8$ cm','B) o $6$ cm','C) o $5$ cm','D) o $4$ cm','E) o $3$ cm'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 360 210" font-family="sans-serif"> <text x="92" y="20" font-size="13" text-anchor="middle">1. hranol</text> <text x="272" y="20" font-size="13" text-anchor="middle">2. hranol</text> <rect x="62" y="50" width="46" height="120" fill="#dcdcdc" stroke="#000"/> <polygon points="62,50 80,36 126,36 108,50" fill="#eeeeee" stroke="#000"/> <polygon points="108,50 126,36 126,156 108,170" fill="#cccccc" stroke="#000"/> <rect x="242" y="110" width="46" height="60" fill="#dcdcdc" stroke="#000"/> <polygon points="242,110 260,96 306,96 288,110" fill="#eeeeee" stroke="#000"/> <polygon points="288,110 306,96 306,156 288,170" fill="#cccccc" stroke="#000"/> <text x="85" y="188" font-size="13" text-anchor="middle" font-style="italic">a</text> <text x="265" y="188" font-size="13" text-anchor="middle" font-style="italic">a</text> <text x="314" y="140" font-size="13" font-style="italic">a</text> <line x1="150" y1="36" x2="150" y2="96" stroke="#000" stroke-dasharray="3 3"/> <text x="158" y="72" font-size="15">?</text> </svg>',
  'hranoly.svg',
  'Dva pravidelné čtyřboké hranoly se stejnou podstavnou hranou a; první je vyšší, rozdíl výšek je označen otazníkem.',
  'Schematický nákres dvou hranolů',
  new List<String>{'Povrch pravidelného čtyřbokého (čtvercového) hranolu: $S=2a^2+4a\\cdot v$. Rozdíl povrchů závisí jen na výškách: $4a\\cdot v_1-4a\\cdot v_2=4\\cdot 3\\cdot(v_1-v_2)=12\\cdot(v_1-v_2)=72$, tedy $v_1-v_2=6$ cm.'},
  'B) o $6$ cm',
  2, 4, '3',
  new List<String>{'zs2','r9','stereometrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
