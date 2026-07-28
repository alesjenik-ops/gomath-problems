String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PZD15C0T01';
Integer YEAR = 2015;

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
  'CERMAT M5A 2015 – úloha 7 (konstrukce)',
  new List<String>{'Na přímce $q$ leží bod $X$ a mimo ni bod $L$ (viz obrázek).','7.1 Narýsujte přímku $p$, která prochází bodem $L$ a je kolmá k přímce $q$. Průsečík přímek $p$, $q$ označte $M$.','7.2 Na polopřímce $MX$ sestrojte bod $N$ tak, aby úsečky $LM$ a $MN$ byly stejně dlouhé.','7.3 Sestrojte chybějící vrchol $O$ čtverce $LMNO$ a čtverec narýsujte.','7.4 Uvnitř čtverce $LMNO$ sestrojte takový bod $K$, aby body $K$, $L$, $M$ tvořily vrcholy rovnostranného trojúhelníku. Trojúhelník $KLM$ narýsujte.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 470 320" font-family="sans-serif"> <rect x="6" y="6" width="458" height="308" fill="none" stroke="#ccc"/> <line x1="60" y1="52" x2="420" y2="182" stroke="#000" stroke-width="2"/> <text x="428" y="196" font-size="16" font-style="italic">q</text> <line x1="94" y1="54" x2="102" y2="76" stroke="#000" stroke-width="2"/> <text x="82" y="90" font-size="16" font-style="italic">X</text> <text x="222" y="272" font-size="18" text-anchor="middle" font-weight="bold">&#215;</text> <text x="204" y="278" font-size="16" font-style="italic">L</text> </svg>',
  'primka-q-bod-L.svg',
  'Přímka q se zvýrazněným bodem X a bod L ležící mimo přímku q.',
  'Výchozí obrázek k úloze 7',
  new List<String>{'7.1 Z bodu $L$ spustíme kolmici na přímku $q$; její patou je bod $M$.','7.2 Kružnicí se středem $M$ a poloměrem $|LM|$ protneme polopřímku $MX$ v bodě $N$, takže $|MN|=|LM|$.','7.3 Protože $LM\\perp MN$ a $|LM|=|MN|$, je $LMNO$ čtverec. Vrchol $O$ je průsečíkem rovnoběžky s $MN$ vedené bodem $L$ a rovnoběžky s $LM$ vedené bodem $N$.','7.4 Bod $K$ je ten průsečík kružnic se středy $L$ a $M$ a poloměrem $|LM|$, který leží uvnitř čtverce $LMNO$.'},
  'Konstrukce: $M$ je pata kolmice z $L$ na přímku $q$; $N$ leží na polopřímce $MX$ a $|MN|=|LM|$; $O$ doplňuje čtverec $LMNO$; $K$ je průsečík kružnic $(L;|LM|)$ a $(M;|LM|)$ uvnitř čtverce – viz obrázek v klíči.',
  6, 11, '3',
  new List<String>{'zs1','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5A 2015 – úloha 8',
  new List<String>{'Obrazec $KLMN$ je vytvořen z rovnostranného a rovnoramenného trojúhelníku (viz obrázek).','Obvod rovnostranného trojúhelníku je 12 cm, obvod rovnoramenného trojúhelníku je dvojnásobný.','8.1 Vypočtěte délku společné strany $LN$ obou trojúhelníků.','8.2 Vypočtěte obvod celého obrazce $KLMN$.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 470 200" font-family="sans-serif"> <polygon points="32,95 160,26 434,95 160,164" fill="none" stroke="#000" stroke-width="2"/> <line x1="160" y1="26" x2="160" y2="164" stroke="#000" stroke-width="2" stroke-dasharray="8 6"/> <text x="16" y="100" font-size="16" font-style="italic">K</text> <text x="154" y="18" font-size="16" font-style="italic">N</text> <text x="154" y="184" font-size="16" font-style="italic">L</text> <text x="442" y="100" font-size="16" font-style="italic">M</text> </svg>',
  'obrazec-KLMN.svg',
  'Obrazec KLMN: rovnostranný trojúhelník KLN vlevo a rovnoramenný trojúhelník LMN vpravo, společná strana LN je čárkovaná.',
  'Schematický nákres obrazce $KLMN$',
  new List<String>{'8.1 Rovnostranný trojúhelník $KLN$ má všechny strany stejně dlouhé, proto $|LN|=12:3=4$ cm.','8.2 Rovnoramenný trojúhelník $LMN$ má obvod $2\\cdot 12=24$ cm a základnu $|LN|=4$ cm, tedy $|LM|=|MN|=(24-4):2=10$ cm.','Obvod obrazce je $|KL|+|LM|+|MN|+|NK|=4+10+10+4=28$ cm.'},
  '8.1: $4$ cm; 8.2: $28$ cm',
  3, 5, '3',
  new List<String>{'zs1','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5A 2015 – úloha 9',
  new List<String>{'Rozhodněte o každém z následujících výpočtů (9.1–9.3), zda je proveden správně (A), či nikoli (N).','9.1 $1$ kg $-$ $20$ g $=80$ g','9.2 $5$ km $-$ $70$ m $=4\\,930$ m','9.3 $14$ m $+$ $3$ cm $+$ $2$ mm $=1\\,432$ mm'},
  null,
  0,
  null,
  null,
  null,
  null,
  new List<String>{'9.1 $1$ kg $=1\\,000$ g, tedy $1\\,000-20=980$ g, nikoli 80 g. Výpočet je nesprávný.','9.2 $5$ km $=5\\,000$ m, tedy $5\\,000-70=4\\,930$ m. Výpočet je správný.','9.3 $14$ m $=14\\,000$ mm a $3$ cm $=30$ mm, tedy $14\\,000+30+2=14\\,032$ mm, nikoli $1\\,432$ mm. Výpočet je nesprávný.'},
  '9.1: Ne; 9.2: Ano; 9.3: Ne',
  3, 4, '2',
  new List<String>{'zs1','aritmetika','porozumeni','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
