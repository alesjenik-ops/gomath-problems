String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PCD25C0T03';
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
  'CERMAT M7C 2025 – úloha 14',
  new List<String>{'V obdélníku $ABCD$ leží na straně $CD$ bod $X$. Přímka $o_1$ je osa úhlu $BAX$ a přímka $o_2$ je osa úhlu $AXB$. Velikosti některých úhlů jsou vyznačeny v obrázku (u vrcholu $A$ úhel $22^\\circ$, mezi osami $o_1$ a $o_2$ úhel $62^\\circ$).','Jaká je velikost úhlu $\\alpha$? Velikosti úhlů neměřte, ale vypočtěte (obrázek je pouze ilustrativní).'},
  new List<String>{'A) $22^\\circ$','B) $28^\\circ$','C) $34^\\circ$','D) $40^\\circ$','E) jiná velikost'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 370" font-family="sans-serif"> <rect x="60" y="60" width="360" height="240" fill="none" stroke="#000" stroke-width="2"/> <text x="50" y="54" font-size="15" font-weight="bold">D</text> <text x="424" y="54" font-size="15" font-weight="bold">C</text> <text x="46" y="318" font-size="15" font-weight="bold">A</text> <text x="424" y="318" font-size="15" font-weight="bold">B</text> <text x="278" y="52" font-size="15" font-weight="bold">X</text> <line x1="285" y1="60" x2="60" y2="300" stroke="#000" stroke-width="2"/> <line x1="285" y1="60" x2="420" y2="300" stroke="#000" stroke-width="2"/> <line x1="40" y1="316" x2="482" y2="176" stroke="#000" stroke-dasharray="7 3 2 3"/> <text x="486" y="176" font-size="14" font-style="italic">o1</text> <line x1="285" y1="60" x2="250" y2="342" stroke="#000" stroke-dasharray="7 3 2 3"/> <text x="238" y="356" font-size="14" font-style="italic">o2</text> <text x="96" y="292" font-size="13">22°</text> <text x="250" y="188" font-size="13">62°</text> <text x="392" y="286" font-size="14" font-style="italic">α</text> </svg>',
  'obdelnik-osy.svg',
  'Obdélník ABCD s bodem X na straně CD, úsečkami XA a XB a osami úhlů o1, o2; vyznačené úhly 22°, 62° a alfa u vrcholu B.',
  'Schematický nákres (obrázek je ilustrativní)',
  new List<String>{'Osa $o_1$ dělí úhel $BAX$; $22^\\circ$ je jeho polovina, takže úhel $BAX=44^\\circ$. Úhel mezi osami $o_1$ a $o_2$ je vnějším úhlem trojúhelníku $A$, $X$, průsečík os, proto se rovná součtu polovin úhlů $BAX$ a $AXB$: $22^\\circ+\\frac{1}{2}\\cdot\\angle AXB=62^\\circ$, tedy $\\frac{1}{2}\\cdot\\angle AXB=40^\\circ$ a $\\angle AXB=80^\\circ$. V trojúhelníku $ABX$ je úhel $ABX=180^\\circ-44^\\circ-80^\\circ=56^\\circ$. Protože $\\angle ABC=90^\\circ$, je $\\alpha=\\angle XBC=90^\\circ-56^\\circ=34^\\circ$.'},
  'C) $34^\\circ$',
  2, 6, '4',
  new List<String>{'zs2','r7','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7C 2025 – úloha 15',
  new List<String>{'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).','15.1 Prázdný kbelík se zcela naplní přesně 50 hrnky borůvek. Z plného kbelíku jsme odsypali 46 % borůvek. Kolik hrnků borůvek zbývá v kbelíku?','15.2 Hrnčíři Petr, Radim, Slávek a Tomáš vyrobili dohromady 240 hrnků. Petr vyrobil o polovinu méně hrnků než Radim. Slávek i Tomáš vyrobili každý o 25 % hrnků méně než Radim. O kolik hrnků více vyrobil Tomáš než Petr?','15.3 Jitka s maminkou a babičkou trhaly na zahradě rybíz do stejně velkých hrnků. Maminka natrhala dvakrát více rybízu než Jitka. Babička natrhala o polovinu více rybízu než Jitka. Přitom babička natrhala o 2 hrnky rybízu méně než maminka. Kolik hrnků rybízu natrhaly všechny tři dohromady?'},
  new List<String>{'A) 18 hrnků','B) 20 hrnků','C) 21 hrnků','D) 23 hrnků','E) 25 hrnků','F) více než 25 hrnků'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'15.1 Zbývá $100\\,\\%-46\\,\\%=54\\,\\%$ z $50$ hrnků, tj. $0{,}54\\cdot 50=27$ hrnků (více než 25) → F.','15.2 Radim $R$, Petr $\\frac{R}{2}$, Slávek i Tomáš $0{,}75R$. Součet $R+\\frac{R}{2}+0{,}75R+0{,}75R=3R=240$, $R=80$. Tomáš $60$, Petr $40$, rozdíl $20$ → B.','15.3 Jitka $J$, maminka $2J$, babička $1{,}5J$. Z $1{,}5J=2J-2$ plyne $J=4$; dohromady $4+8+6=18$ hrnků → A.'},
  '15.1: F (27 hrnků); 15.2: B (20 hrnků); 15.3: A (18 hrnků)',
  6, 9, '4',
  new List<String>{'zs2','r7','procenta','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
