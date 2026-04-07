INSERT INTO VIEW_TEMPLATE (
    VWT_OID, 
    VWT_CONTEXT, 
    VWT_NAME, 
    VWT_OWNER_TYPE, 
    VWT_OWNER_OID, 
    VWT_DESCRIPTION, 
    VWT_VIEW_DEFINITION
)
VALUES 
/* --- ERROR 10 --- */
(
    'VWTmaSim000010', 
    'dynamic.maSimsHelper.10', 
    'MA SIMS Error 10', 
    '1', 
    '*dst', 
    NULL, 
    '<?xml version="1.0" encoding="UTF-8"?>
    <template>
      <tab name="tab.student.std.list.detail">
        <row>
          <block>
            <line border="bottom" shaded="true">
              <text bold="true" font-size="large">&lt;span style="color:#00a3cc;"&gt;Error Code:&lt;/span&gt;</text>
              <text bold="true" font-size="medium">&amp;nbsp;10</text>
              <spacer height="15" />
            </line>
          </block>
        </row>
        <row>
          <block>
            <line border="bottom" shaded="true">
              <text bold="true" font-size="medium">Error Description:</text>
              <text font-size="medium">&amp;nbsp; Days in Membership-Average Days in membership too low&amp;nbsp;</text>
              <spacer height="15" />
            </line>
            <line border="none">
              <cell align="left" border="none" cell-span="1" line-span="1">
                <text font-size="medium">For in-district students\, the sum of all days in membership divided by the number of students\, must be greater than or equal to 150 days. &amp;nbsp;</text>
                <spacer height="15" />
              </cell>
            </line>
          </block>
        </row>
        <row>
          <block>
            <line border="bottom" shaded="true">
              <cell border="none" cell-span="1" line-span="1" shaded="true">
                <text bold="true" font-size="medium">Steps to resolve:</text>
              </cell>
            </line>
            <line border="bottom">
              <cell border="none" cell-span="1" line-span="1">
                <text font-size="medium">Verify the days in membership of these students is at least 150 and that no Prev Adj Membership values on membership records are affecting this value.</text>
                <spacer width="15" />
              </cell>
            </line>
          </block>
        </row>
      </tab>
    </template>'
),

/* --- ERROR 101 --- */
(
    'VWTmaSim000101', 
    'dynamic.maSimsHelper.101', 
    'MA SIMS Error 101', 
    '1', 
    '*dst', 
    NULL, 
    '<?xml version="1.0" encoding="UTF-8"?>
    <template>
      <tab name="tab.student.std.list.detail">
        <row>
          <block>
            <line border="bottom" shaded="true">
              <text bold="true" font-size="large">&lt;span style="color:#00a3cc;"&gt;Error Code:&lt;/span&gt;</text>
              <text bold="true" font-size="medium">&amp;nbsp;101</text>
            </line>
          </block>
        </row>
        <row>
          <block>
            <line border="bottom" shaded="true">
              <text bold="true" font-size="medium">Error Description:</text>
              <text font-size="medium">&amp;nbsp;Student SASID from last period is missing&amp;nbsp;</text>
            </line>
          </block>
        </row>
        <row>
          <block>
            <line border="bottom" shaded="true">
              <text bold="true" font-size="medium">If you receive this error\, please contact Technical Support for assistance.</text>
            </line>
            <line border="bottom">
              <text bold="true" font-size="medium">Call: 888-244-1366\, option 1</text>
            </line>
          </block>
        </row>
      </tab>
    </template>'
),

/* --- ERROR 101452 --- */
(
    'VWTmaSim101452', 
    'dynamic.maSimsHelper.101452', 
    'MA SIMS Error 101452', 
    '1', 
    '*dst', 
    NULL, 
    '<?xml version="1.0" encoding="UTF-8"?>
    <template>
      <tab name="tab.student.std.list.detail">
        <row>
          <block>
            <line border="bottom" shaded="true">
              <text bold="true" font-size="large">&lt;span style="color:#00a3cc;"&gt;Error Code:&lt;/span&gt;</text>
              <text bold="true" font-size="medium">101452</text>
            </line>
          </block>
        </row>
        <row>
          <block>
            <line border="bottom" shaded="true">
              <text bold="true" font-size="medium">Steps to resolve:</text>
            </line>
            <line border="none">
              <cell border="none" cell-span="1" line-span="1">
                <text font-size="medium">1. Update the student''s DOE 12 to Active</text>
              </cell>
            </line>
            <line border="none">
              <cell border="none" cell-span="1" line-span="1">
                <text font-size="medium">2. Update Adjusted Status to Not Enrolled/SPED Only</text>
              </cell>
            </line>
            <line border="none">
              <cell border="none" cell-span="1" line-span="1">
                <text font-size="medium">3. Check "Adjusted Service Only" on membership record.</text>
              </cell>
            </line>
          </block>
        </row>
      </tab>
    </template>'
);