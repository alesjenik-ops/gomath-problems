String SRC   = 'CERMAT – Jednotná přijímací zkouška 2025, 1. náhradní termín (M9C)';
String STYPE = 'CERMAT';

public class C {
  Map<String,Id> tx; Set<String> have; String src; String stype; public Integer created=0;
  C(Map<String,Id> tx, Set<String> have, String src, String stype){this.tx=tx;this.have=have;this.src=src;this.stype=stype;}
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
  void add(String name,List<String> zad,List<String> opts,Integer ln,String svg,String fn,String alt,String cap,List<String> solp,String ans,Decimal pts,Decimal mins,String diff,List<String> codes,String ccode,Integer yr){
    if(have.contains(name))return;
    Id d=(svg!=null)?sv(name,fn,svg):null;
    Math_Problem__c mp=new Math_Problem__c(Name=name,Status__c='Publikováno',Visibility__c='Organizace',Language__c='cs',Current_Version_Number__c=1);insert mp;
    String cj=content(zad,d,alt,cap,opts,ln); String sj=solution(solp);
    String aj=JSON.serialize(new Map<String,Object>{'type'=>'Text','value'=>ans});
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,License__c='Jiná',CERMAT_Code__c=ccode,Source_Year__c=yr,Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
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
C c=new C(tx,have,SRC,STYPE);

c.add(
  'CERMAT 2025 M9C · úloha 14',
  new List<String>{'V obdélníku $ABCD$ leží na straně $CD$ bod $X$. Přímka $o_1$ je osa úhlu $BAX$ a přímka $o_2$ je osa úhlu $AXB$. V obrázku jsou vyznačeny úhly $22^\\circ$ a $62^\\circ$.','Jaká je velikost úhlu $\\alpha$? (Velikosti neměřte, ale vypočtěte.)'},
  new List<String>{'A) $22^\\circ$','B) $28^\\circ$','C) $34^\\circ$','D) $40^\\circ$','E) jiná velikost'},
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 244"><path d="M13 75L240 75L240 211L13 211ZM13 211L169 75M240 211L169 75" style="fill:none;stroke:#000000;stroke-width:2"/><path d="M172 56L138 240" style="fill:none;stroke:#000000;stroke-width:1"/><text x="20" y="12" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">V obdélníku</text><text x="65" y="12" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">ABCD</text><text x="114" y="12" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">leží na straně</text><text x="156" y="12" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">CD</text><text x="176" y="12" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">bod</text><text x="192" y="12" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">X</text><text x="199" y="12" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">.</text><text x="7" y="28" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Přímka</text><text x="29" y="28" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">o</text><text x="34" y="29" font-size="9" fill="#000" text-anchor="middle" font-family="sans-serif">1</text><text x="66" y="28" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">je osa úhlu</text><text x="105" y="28" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">BAX</text><text x="139" y="28" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">a přímka</text><text x="167" y="28" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">o</text><text x="172" y="29" font-size="9" fill="#000" text-anchor="middle" font-family="sans-serif">2</text><text x="204" y="28" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">je osa úhlu</text><text x="243" y="28" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">AXB</text><text x="255" y="28" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">.</text><text x="116" y="44" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Velikosti některých úhlů jsou vyznačeny v obrázku.</text><text x="243" y="73" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">C</text><text x="12" y="73" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">D</text><text x="165" y="73" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">X</text></svg>',
  'obr.svg',
  'Obdélník ABCD s bodem X na straně CD, osami o1 úhlu BAX a o2 úhlu AXB a vyznačenými úhly 22° a 62°.',
  '',
  new List<String>{'Z os úhlů $BAX$ a $AXB$ a z pravých úhlů obdélníku (a rovnoběžnosti $AB$ s $CD$) se dopočtou vnitřní úhly; vychází $\\alpha=34^\\circ$.'},
  'C) $34^\\circ$',
  2, 4, '4',
  new List<String>{'zs2','r9','geometrie','planimetrie','argumentace','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PCD25C0T03', 2025
);
c.add(
  'CERMAT 2025 M9C · úloha 15',
  new List<String>{'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).','15.1 Kbelík se naplní $50$ hrnky borůvek. Z plného kbelíku jsme odsypali $46\\ \\%$ borůvek. Kolik hrnků zbývá v kbelíku?','15.2 Petr, Radim, Slávek a Tomáš vyrobili dohromady $240$ hrnků. Petr vyrobil o polovinu méně než Radim, Slávek i Tomáš každý o $25\\ \\%$ méně než Radim. O kolik hrnků více vyrobil Tomáš než Petr?','15.3 Maminka natrhala dvakrát více rybízu než Jitka, babička o polovinu více než Jitka; babička natrhala o $2$ hrnky méně než maminka. Kolik hrnků natrhaly všechny tři dohromady?'},
  new List<String>{'A) $18$ hrnků','B) $20$ hrnků','C) $21$ hrnků','D) $23$ hrnků','E) $25$ hrnků','F) více než $25$ hrnků'},
  null,
  null,
  null,
  null,
  null,
  new List<String>{'15.1: zbývá $54\\ \\%$ z $50$, tj. $27$ hrnků — F.','15.2: $\\frac{R}{2}+R+\\frac{3}{4}R+\\frac{3}{4}R=3R=240\\Rightarrow R=80$; Tomáš $60$, Petr $40$, rozdíl $20$ — B.','15.3: maminka $2J$, babička $1{,}5J$; $2J-1{,}5J=2\\Rightarrow J=4$; celkem $4{,}5\\cdot4=18$ — A.'},
  '15.1: F ($27$); 15.2: B ($20$); 15.3: A ($18$)',
  6, 6, '3',
  new List<String>{'zs2','r9','procenta','slovni','modelovani','bez-kalkulacky','bezny-zivot'},
  'M9PCD25C0T03', 2025
);

System.debug('Vytvořeno úloh: '+c.created);
