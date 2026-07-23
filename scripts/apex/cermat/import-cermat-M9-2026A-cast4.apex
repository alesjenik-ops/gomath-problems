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
  'CERMAT M9A 2026 – úloha 10 (konstrukce)',
  new List<String>{'V rovině leží bod $A$ a přímka $o$ (viz obrázek).','Bod $A$ je vrchol rovnoběžníku $ABCD$. Přímka $o$ je osou souměrnosti tohoto rovnoběžníku a leží na ní vrcholy $B$, $D$. Úhlopříčka $BD$ rovnoběžníku $ABCD$ je dvakrát delší než úhlopříčka $AC$.','Sestrojte vrcholy $B$, $C$, $D$ rovnoběžníku $ABCD$, označte je písmeny a rovnoběžník narýsujte.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 260" font-family="sans-serif"> <line x1="40" y1="80" x2="360" y2="182" stroke="#000" stroke-width="2"/> <text x="44" y="72" font-size="15" font-style="italic">o</text> <text x="196" y="206" font-size="14" text-anchor="middle">×</text> <text x="196" y="224" font-size="14" text-anchor="middle" font-style="italic">A</text> </svg>',
  'primka-o.svg',
  'Bod A a přímka o.',
  'Výchozí obrázek k úloze 10',
  new List<String>{'Protože osa souměrnosti $o$ prochází vrcholy $B$, $D$, je $ABCD$ kosočtverec; úhlopříčka $BD$ leží na $o$ a úhlopříčka $AC$ je na ni kolmá. Vrchol $C$ je obrazem bodu $A$ v osové souměrnosti podle přímky $o$; střed $O$ (průsečík úhlopříček) je pata kolmice z $A$ na $o$.','Platí $|AC|=2\\cdot|AO|$ a $|BD|=2\\cdot|AC|$, takže $|OB|=|OD|=\\frac{|BD|}{2}=|AC|$. Body $B$, $D$ tedy leží na přímce $o$ ve vzdálenosti $|AC|$ od bodu $O$ na obě strany.'},
  'Vrchol $C$ je obraz bodu $A$ v osové souměrnosti podle $o$; střed $O$ je pata kolmice z $A$ na $o$. Body $B$, $D$ leží na $o$ ve vzdálenosti $|AC|$ od $O$ na obě strany (protože $|BD|=2\\cdot|AC|$). $ABCD$ je kosočtverec – viz obrázek v klíči.',
  2, 5, '3',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2026 – úloha 11',
  new List<String>{'Náklad na lodi se skládá pouze ze čtyř druhů zboží – rýže, cukru, kávy a banánů. Loď veze $36$ tun banánů a $36$ tun kávy. Diagram udává, jaký podíl na celkové hmotnosti nákladu mají jednotlivé druhy zboží (rýže $35\\,\\%$, cukr $25\\,\\%$).','Rozhodněte o každém z následujících tvrzení 11.1–11.3, zda je pravdivé (A), či nikoli (N).','11.1 Káva a banány tvoří dohromady dvě pětiny celkové hmotnosti nákladu.','11.2 Poměr hmotnosti kávy ku hmotnosti rýže je $4:7$.','11.3 Loď veze $63$ tun rýže.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 360 220" font-family="sans-serif"> <defs><pattern id="h" width="8" height="8" patternUnits="userSpaceOnUse" patternTransform="rotate(45)"> <line x1="0" y1="0" x2="0" y2="8" stroke="#555" stroke-width="2.5"/></pattern></defs> <path d="M140,120 L140,40 A80,80 0 0 1 204.7,167 Z" fill="url(#h)" stroke="#000"/> <path d="M140,120 L204.7,167 A80,80 0 0 1 93,184.7 Z" fill="#ffffff" stroke="#000"/> <path d="M140,120 L93,184.7 A80,80 0 0 1 63.9,95.3 Z" fill="#d0d0d0" stroke="#000"/> <path d="M140,120 L63.9,95.3 A80,80 0 0 1 140,40 Z" fill="#6a6a6a" stroke="#000"/> <text x="168" y="104" font-size="13">35 %</text> <text x="120" y="168" font-size="13">25 %</text> <rect x="250" y="56" width="14" height="14" fill="url(#h)" stroke="#000"/><text x="270" y="68" font-size="13">ryze</text> <rect x="250" y="82" width="14" height="14" fill="#ffffff" stroke="#000"/><text x="270" y="94" font-size="13">cukr</text> <rect x="250" y="108" width="14" height="14" fill="#d0d0d0" stroke="#000"/><text x="270" y="120" font-size="13">kava</text> <rect x="250" y="134" width="14" height="14" fill="#6a6a6a" stroke="#000"/><text x="270" y="146" font-size="13">banany</text> </svg>',
  'diagram-naklad.svg',
  'Kruhový diagram podílu druhů zboží na hmotnosti nákladu: rýže 35 % (šrafovaný díl), cukr 25 %, dále díly pro kávu a banány.',
  'Podíl druhů zboží na hmotnosti nákladu',
  new List<String>{'Z diagramu rýže $35\\,\\%$, cukr $25\\,\\%$; na kávu a banány zbývá $100-35-25=40\\,\\%$. Kávy i banánů je stejně ($36$ t), proto káva $=$ banány $=20\\,\\%$. Z $20\\,\\%=36$ t plyne celková hmotnost $180$ t.','11.1 Káva + banány $=72$ t $=\\frac{2}{5}\\cdot 180$ t → pravdivé (A).','11.2 Rýže $=35\\,\\%$ z $180$ t $=63$ t; $36:63=4:7$ → pravdivé (A).','11.3 Rýže $=63$ t → pravdivé (A).'},
  '11.1: A (Ano); 11.2: A (Ano); 11.3: A (Ano)',
  4, 6, '3',
  new List<String>{'zs2','r9','statistika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
